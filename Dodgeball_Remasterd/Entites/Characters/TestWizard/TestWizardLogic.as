//used pirate-robs template, thank you rob

#include "Hitters.as";
#include "Knocked.as";
#include "ThrowCommon.as";
#include "RunnerCommon.as";

int charge = 5;

void onInit(CBlob@ this)
{
	this.set_f32("gib health", -3.0f);
	this.set_s8("charge_time", 0);

	this.Tag("player");
	this.Tag("flesh");

	CShape@ shape = this.getShape();
	shape.SetRotationsAllowed(false);
	shape.getConsts().net_threshold_multiplier = 0.5f;

	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag = "dead";
	this.set_u16("charge",0);

	this.addCommandID("ShootObj");
}


void onSetPlayer(CBlob@ this, CPlayer@ player)
{
	if(player !is null)
	{
		player.SetScoreboardVars("ScoreboardIcons.png", 1, Vec2f(16, 16));
	}
}

void onTick(CBlob@ this)
{
	//declearing basic stuff

	if(!this.isMyPlayer())
	{
		return;
	}
	Vec2f pos = this.getPosition();
	Vec2f vel = this.getVelocity();
	CBlob@ attachedBlob = this.getAttachments().getAttachedBlob("PICKUP");
	if(attachedBlob !is null)
	{
		attachedBlob.setAngleDegrees(0.0f);
		
		if(this.isKeyPressed(key_action1))
		{
			if(this.get_u16("charge") < 50)
			{
				this.add_u16("charge",1);
			}
		}

		if(this.isKeyJustReleased(key_action1))// when key is closed, FIREEEE
		{
			//ShootObj

		}
	}
	else
	{
		this.set_u16("charge",0);
	}

}

void onCommand( CBlob@ this, u8 cmd, CBitStream @params )
{
	if(isServer())
	{
		if(cmd == this.getCommandID("ShootObj"))
		{/*
			attachedBlob.server_Die();
			CBlob@ ball = server_CreateBlobNoInit(attachedBlob.getName());
			if (ball !is null)
			{
				Vec2f ballVel = (this.getAimPos() - pos);
				ballVel.Normalize();//not sure what this does.. but it 'normalizes' the aiming so i'l keep it
				ballVel *= this.get_u16("charge")/2.5f;//will change in the future, will change the charge distance

				ball.SetDamageOwnerPlayer(this.getPlayer());
				ball.Init();

				ball.IgnoreCollisionWhileOverlapped(this);
				ball.server_setTeamNum(this.getTeamNum());
				ball.setPosition(pos);
				ball.setVelocity(ballVel);
			}*/
		}
	}
}


