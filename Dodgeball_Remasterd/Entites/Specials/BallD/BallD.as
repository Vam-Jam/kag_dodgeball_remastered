#include "Hitters.as";
#include "ballparticle.as";
#include "MakeTestParticles.as";
//Redo of my first dodgeball mod
//I actually know how to code this time round



const u8 ignoreAllTeam = 200; 
u8 onHitCmd = 0; 
float mapsize;

void onInit(CBlob@ this)
{

	this.Tag("Ball");
	this.set_f32("scope_zoom", 0.05f);
	this.getShape().SetRotationsAllowed(true);
  	this.server_setTeamNum(ignoreAllTeam);
  	this.SetMapEdgeFlags( CBlob::map_collide_sides | CBlob::map_collide_bounce);

	onHitCmd = this.addCommandID("ServerHit");
	CMap@ map = getMap();
	mapsize = map.tilemapwidth * map.tilesize;
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob)
{
    return true;
}

void onAttach(CBlob@ this, CBlob@ attached, AttachmentPoint@ attachedPoint)
{
	this.server_setTeamNum(attached.getTeamNum());

}

bool doesCollideWithBlob( CBlob@ this, CBlob@ blob )
{
	//get once
	u8 teamNum = this.getTeamNum();
	u8 blobTeamNum = blob.getTeamNum();
	bool isBall = blob.hasTag("Ball");

	if(isBall)//so balls can hit mid air and on the ground etc
	{
		return true;
	}

	if(teamNum == ignoreAllTeam)
	{
		return false;
	}
	if(teamNum == blobTeamNum)
	{
		return false;
	}

	return true;
}

void onChangeTeam( CBlob@ this, const int oldTeam )
{
	u8 currentTeam = this.getTeamNum();
	
	if(currentTeam != ignoreAllTeam && oldTeam == ignoreAllTeam)
	{
		this.setVelocity(Vec2f(0,0));
		this.setAngleDegrees(0.0f);
		this.setAngularVelocity(0.0f);
	}
}

void onDetach(CBlob@ this, CBlob@ detached, AttachmentPoint@ attachedPoint)
{
	if(detached.get_u16("charge") < 1)
	{
		this.server_setTeamNum(ignoreAllTeam);
	}
}

void onTick(CBlob@ this)
{
	if(this.isAttached())
		return;

	if(isServer())
	{
		if(this.getPosition().x < 0)
		{
			Vec2f forceToAdd = Vec2f(0,0) - this.getPosition();
			print(forceToAdd.x + " a");
			this.AddForce(Vec2f(forceToAdd.x,0));
		}
		else if(this.getPosition().x > mapsize)
		{
			this.AddForce(Vec2f(-this.getVelocity().x,0));
		}
	}
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid, Vec2f normal)
{
	if(isServer())
	{
		if(blob !is null && blob.getTeamNum() != this.getTeamNum())
		{
			if(this.getTeamNum() == ignoreAllTeam)
			{
				return;
			}

			if(blob.hasTag("flesh"))
			{
				//send cmd first so the client will see the other person die as the explosion happens
				this.SendCommand(onHitCmd);
				this.server_Hit(blob, blob.getPosition(), this.getVelocity(), 10.0, Hitters::crush, true);	
			}
		}
	}
}

void onCommand( CBlob@ this, u8 cmd, CBitStream @params )
{
	if(isClient())
	{
		if(cmd == onHitCmd)
		{
			MakeTestParticles(this.getPosition(), "Explosion.png");
			this.getSprite().PlaySound("RocketExplosion.ogg");
		}
	}
}
