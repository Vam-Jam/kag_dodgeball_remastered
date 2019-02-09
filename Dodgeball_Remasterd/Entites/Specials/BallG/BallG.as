//BallThatDoesDamage
#include "Hitters.as";
#include "ballparticle.as";

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


void onTick(CBlob@ this)
{
	float rot = this.getAngleDegrees();
	Vec2f pos = this.getPosition();
	Vec2f spawnLocation = Vec2f( 399 + XORRandom(2), 20 + XORRandom(70) );
	Vec2f velr = getRandomVelocity(1.0f, 0.0f + XORRandom(5.0f), 0.0f + XORRandom(255.0f));
	Vec2f vel = this.getVelocity();

	if(vel.x > 0.5f || vel.y > 0.5f || vel.x < -0.5f || vel.y < -0.5f)
	{
		GodBallTrail(pos, rot);
	}
	if (pos.x < 4.0f || pos.x > (getMap().tilemapwidth * getMap().tilesize) - 4.0f)
	{
		this.setPosition(spawnLocation);
	}
}

//Vec2f ( 0 = (+ = left, - = right) , 0 = up or down ( - = up, + = down))

void onCollision( CBlob@ this, CBlob@ blob, bool solid, Vec2f normal)
{
	float rot = this.getAngleDegrees();
	Vec2f pos = this.getPosition();
	Vec2f spawnLocation = Vec2f( 399 + XORRandom(2), 20 + XORRandom(70) );
	Vec2f velr = getRandomVelocity(1.0f, 0.0f + XORRandom(5.0f), 0.0f + XORRandom(255.0f));
	Vec2f vel = this.getVelocity();
	for(int a = 0; a < 360; a ++)
	{
		if(a < 90)
		{
			CParticle@ this = ParticleSpark(pos + Vec2f(-a,-a), Vec2f(0,0) , SColor(100 + XORRandom(255), 0 , 0 + XORRandom(255) , 0));
			if(this !is null)
			{
				this.Z = -10;
				this.fadeout = true;
			}
		}
		else if (a < 180)
		{
			CParticle@ this = ParticleSpark(pos + Vec2f(-a,a), Vec2f(0,0) , SColor(100 + XORRandom(255), 0 , 0 + XORRandom(255) , 0));
			if(this !is null)
			{
				this.Z = -10;
				this.fadeout = true;
			}
		}
	}
	//Vec2f pos = this.getPosition();
	/*if(blob !is null)
	{
		//print("ball will kill");
		if(blob.hasTag("flesh"))
		{
			this.server_Hit(blob, blob.getPosition(), this.getVelocity(), 10.0, Hitters::crush, true);
			this.getSprite().PlaySound("Holy.ogg");
			this.server_Die();
		}
		if(solid)
		{
		}
	}*/
}
