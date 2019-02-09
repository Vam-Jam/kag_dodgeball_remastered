//BallThatDoesDamage
#include "Hitters.as";
#include "ballparticle.as";
#include "MakeTestParticles.as";

//Todo
//	-Custom settings to select particle trail
//	-Custom kill particle
//	-Custom death sound?

void onInit(CBlob@ this)
{
	this.getShape().SetRotationsAllowed( true );
  	this.server_setTeamNum(5);
  	this.SetMapEdgeFlags( u8(CBlob::map_collide_none) | u8(CBlob::map_collide_nodeath) );
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob)
{
    return true;
}

void onAttach(CBlob@ this, CBlob@ attached, AttachmentPoint@ attachedPoint)
{
	if(this.getTeamNum() == 5)
	{
		this.server_setTeamNum(attached.getTeamNum());
		this.getCurrentScript().tickFrequency = 1;
	}
	this.setVelocity(Vec2f(0,0));
	this.setAngleDegrees(0.0f);
	this.setAngularVelocity(0.0f);

}

void onDetach(CBlob@ this, CBlob@ detached, AttachmentPoint@ attachedPoint)
{
	if(this.getTeamNum() == 5)
	{
		this.server_setTeamNum(detached.getTeamNum());
		this.getCurrentScript().tickFrequency = 1;
	}
}

void onTick(CBlob@ this)
{
	if(this.isAttached())
		return;

	CMap@ map = getMap();
	Vec2f pos = this.getPosition();
	float rot = this.getAngleDegrees();
	Vec2f spawnLocation = Vec2f( 399 + XORRandom(2), 20 + XORRandom(70) );
	Vec2f vel = this.getVelocity();
	Vec2f velr = getRandomVelocity(120.0f, 1.0f, 255.0f);
	if (this.isOnMap() && this.isOnGround())
	{
		this.server_setTeamNum(5);
		this.getCurrentScript().tickFrequency = 0;
	}

	if(vel.x > 0.1f || vel.y > 0.1f || vel.x < -0.1f || vel.y < -0.1f)//recently changed from 
	{
		if(this.getTeamNum() == 0)
		{
			//BallTrailCopy(pos, rot, this.getSprite());
		}
		if(this.getTeamNum() == 1)
		{
			//BallTrailRed(pos, rot);
		}
	}
	
	/*if (pos.x < 4.0f
			|| pos.x > (getMap().tilemapwidth * getMap().tilesize) - 4.0f
			|| pos.y < -1000.0f
			|| pos.y > (getMap().tilemapheight * getMap().tilesize) - -4.0f )
	{

		this.setPosition(spawnLocation);
		this.server_setTeamNum(5);

	}*/
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid, Vec2f normal)
{
	if(blob !is null && blob.getTeamNum() != this.getTeamNum())
	{
		if(this.getTeamNum() == 5)
		{
			if(blob.hasTag("flesh"))
			{
				this.server_Hit(blob, blob.getPosition(), this.getVelocity(), 0.0, Hitters::crush, true);
				this.server_setTeamNum(5);
			}
			if(solid)
			{
			}
		}
		else
		{
			if(blob.hasTag("flesh"))
			{
				this.server_Hit(blob, blob.getPosition(), this.getVelocity(), 10.0, Hitters::crush, true);
				MakeTestParticles(this.getPosition(), "Explosion.png");
				this.getSprite().PlaySound("RocketExplosion.ogg");
			}
			if(solid)
			{
			}
		}
	}
}
