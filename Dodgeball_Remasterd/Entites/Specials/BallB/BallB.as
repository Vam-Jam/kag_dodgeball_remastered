//BallThatDoesDamage
#include "Hitters.as";
#include "ballparticle.as";
#include "MakeTestParticles.as";

void onInit(CBlob@ this)
{
	this.getShape().SetRotationsAllowed( true );
    this.server_setTeamNum(5);
    this.SetMapEdgeFlags( u8(CBlob::map_collide_none) | u8(CBlob::map_collide_nodeath) );
}

bool canBePickedUp( CBlob@ this, CBlob@ byBlob )
{
    return true;
}

void onAttach(CBlob@ this, CBlob@ attached, AttachmentPoint@ attachedPoint)
{
	if(this.getTeamNum() == 5)
	{
		this.server_setTeamNum(attached.getTeamNum());
	}
	if(attached.getTeamNum() == 0)
	{
		this.server_setTeamNum(0);
	}
	if(attached.getTeamNum()== 1)
	{
		this.server_setTeamNum(1);
	}
}

void onTick(CBlob@ this)
{
	Vec2f pos = this.getPosition();
	Vec2f spawnLocation = Vec2f( 399 + XORRandom(2), 20 + XORRandom(70) );
	Vec2f vel = this.getVelocity();
	Vec2f velr = getRandomVelocity(120.0f, 1.0f, 255.0f);
	if (this.isOnGround())
	{
		if(this.getTeamNum() == 0)
		{
			MakeTestParticles(this.getPosition(), "Explosion.png");
			this.getSprite().PlaySound("Explosion0.ogg");
			this.server_Die();
		}
		if(this.getTeamNum() == 1)
		{
			MakeTestParticles(this.getPosition(), "Explosion.png");
			this.getSprite().PlaySound("Explosion0.ogg");
			this.server_Die();
		}
	}
	if(vel.x > 0.5f || vel.y > 0.5f || vel.x < -0.5f || vel.y < -0.5f)
	{
		if(this.getTeamNum() == 0)
		{
			BallTrailBlackBlue(pos);
		}
		if(this.getTeamNum() == 1)
		{
			BallTrailBlackRed(pos);
		}
	}
	if (pos.x < 4.0f
			|| pos.x > (getMap().tilemapwidth * getMap().tilesize) - 4.0f
			|| pos.y < -1000.0f
			|| pos.y > (getMap().tilemapheight * getMap().tilesize) - -4.0f )
	{

		this.setPosition(spawnLocation);
		this.server_setTeamNum(5);

	}
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid, Vec2f normal)
{
	if(blob !is null && blob.getTeamNum() != this.getTeamNum())
	{
		if(this.getTeamNum() == 5)
		{
			if(blob.hasTag("flesh"))
			{
				this.server_Hit(blob, blob.getPosition(), this.getVelocity(), 0.0f, Hitters::crush, true);
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
				this.server_Hit(blob, blob.getPosition(), this.getVelocity(), 10.0f, Hitters::crush, true);
				MakeTestParticles(this.getPosition(), "Explosion.png");
				this.getSprite().PlaySound("Explosion0.ogg");
				this.server_Die();
			}
			if(solid)
			{
			}
		}
	}
}
