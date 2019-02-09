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
	float rot = this.getAngleDegrees();
	Vec2f spawnLocation = Vec2f( 399 + XORRandom(2), 20 + XORRandom(70) );
	Vec2f vel = this.getVelocity();
	Vec2f velr = getRandomVelocity(120.0f, 1.0f, 255.0f);
	if (this.isOnGround())
	{
		this.server_setTeamNum(5);
	}
	if(vel.x > 0.5f || vel.y > 0.5f || vel.x < -0.5f || vel.y < -0.5f)
	{
		if(this.getTeamNum() == 0)
		{
			ChatBallBlue(pos, rot);
		}
		if(this.getTeamNum() == 1)
		{
			ChatBallRed(pos, rot);
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
				this.getSprite().PlaySound("Explosion1.ogg");
				if(XORRandom(5) == 0)
				{
					this.Chat("KABOOOOOOM!!");
					client_AddToChat("<Chat ball> KABOOOOOOM!!", SColor(255, 112, 156, 39));
				}
				else if (XORRandom(5) == 0)
				{
					this.Chat("BOOOOOOOM!!");
					client_AddToChat("<Chat ball> BOOOOOOOM!!", SColor(255, 112, 156, 39));
				}
				else if (XORRandom(5) == 0)
				{
					this.Chat("WEEEEEEEEEEEEEEEEEEEEEE");
					client_AddToChat("<Chat ball> WEEEEEEEEEEEEEEEEEEEEEE", SColor(255, 112, 156, 39));
				}
				else if (XORRandom(5) == 0)
				{
					this.Chat("I'm sorry!");
					client_AddToChat("<Chat ball> I'm sorry!", SColor(255, 112, 156, 39));
				}
				else
				{
					this.Chat("ops");
					client_AddToChat("<Chat ball> ops", SColor(255, 112, 156, 39));
				}
			}
			if(solid)
			{
			}
		}
	}
}
