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
				print((this.get_u16("charge"))+"");
			}
		}

		if(this.isKeyJustReleased(key_action1))// when key is closed, FIREEEE
		{
			attachedBlob.server_Die();

			CBlob@ ball = server_CreateBlobNoInit(attachedBlob.getName());
			if (ball !is null)
			{
				Vec2f ballVel = (this.getAimPos() - pos);
				ballVel.Normalize();//not sure what this does.. but it 'normalizes' the aiming so i'l keep it
				ballVel *= this.get_u16("charge")/3.0f;//will change in the future, will change the charge distance

				ball.SetDamageOwnerPlayer(this.getPlayer());
				ball.Init();

				ball.IgnoreCollisionWhileOverlapped(this);
				ball.server_setTeamNum(this.getTeamNum());
				ball.setPosition(pos);
				ball.setVelocity(ballVel);
			}
			this.set_u16("charge",0);
		}
	}

	//if left mouse key is pressed, + 1 to charge

	/*
	if(this.isKeyJustReleased(key_action2))// when key is closed, FIREEEE
	{
		int x;
		int y;
		int bx;
		int by;


		for(int x = y; x <= y - 1; x++);
		{
			CoolEffect(pos + (Vec2f(a,a)), vel + Vec2f(a-a,a),SColor(255, 255, 100+ a, 150 + a));
		}
		for(int y = x; y <= x; y++)
		{
			CoolEffect(pos + (Vec2f(a,a)), vel + Vec2f(a-a,a),SColor(255, 255, 100+ a, 150 + a));
		}

		CBlob@ metor = server_CreateBlobNoInit("Metor");
		if (metor !is null)
		{
			Vec2f metorVel = (this.getAimPos() - pos);
			metorVel.Normalize();//not sure what this does.. but it 'normalizes' the aiming so i'l keep it
			metorVel *= charge/3.0f;//will change in the future, will change the charge distance

			metor.SetDamageOwnerPlayer(this.getPlayer());
			metor.Init();

			metor.IgnoreCollisionWhileOverlapped(this);
			metor.server_setTeamNum(this.getTeamNum());
			metor.setPosition(Vec2f(pos.x, 0));
			metor.setVelocity(Vec2f(0,0));
		}
		charge = 5;
	}


	if(this.isInInventory())
		return;

	const bool ismyplayer = this.isMyPlayer();

	if(ismyplayer && getHUD().hasMenus())
	{
		return;
	}

	if(ismyplayer)
	{

		if(this.isKeyJustPressed(key_action3))
		{
			CBlob@ carried = this.getCarriedBlob();
			if(carried is null)
			{
				client_SendThrowOrActivateCommand(this);
			}
		}
	}*/
}
