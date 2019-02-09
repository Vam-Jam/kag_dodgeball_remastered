void BallTrailBlue(Vec2f pos, float rot)
{//ballParticleBlue.


	CParticle@ this = ParticleAnimated("trail1.png", pos, Vec2f(0,0), rot, 1.0f, 1, 0.0f, true);
	if(this !is null)
	{
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
		//this.setRenderStyle(RenderStyle::normal); //additive works well (light to dark fading effect)
												 //light does well (oposite as above)

	}
}

void BallTrailRed(Vec2f pos, float rot)
{
	CParticle@ this = ParticleAnimated("ballParticleRed.png", pos, Vec2f(0,0), rot, 1.0f, 1, 0.0f, true);
	if(this !is null)
	{
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
	}
}

void BallTrailBlackBlue(Vec2f pos)
{
	CParticle@ this = ParticleAnimated("trailBlue.png", pos, Vec2f(0,0), 3.0f, 3.0f, 3, 0.0f, true);
	if(this !is null)
	{
		this.rotates = true;
		this.rotation = Vec2f(0.5, 0.5);
		this.fadeout = true;
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
	}
}

void BallTrailBlackRed(Vec2f pos)
{
	CParticle@ this = ParticleAnimated("trailRed.png", pos, Vec2f(0,0), 3.0f, 3.0f, 3, 0.0f, true);
	if(this !is null)
	{
		this.rotates = true;
		this.rotation = Vec2f(0.5, 0.5);
		this.fadeout = true;
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
	}
}

void ChatBallBlue(Vec2f pos, float rot)
{
	CParticle@ this = ParticleAnimated("chatBallBlue.png", pos, Vec2f(0,0), rot, 1.0f, 1, 0.0f, true);
	if(this !is null)
	{
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
	}
}

void ChatBallRed(Vec2f pos, float rot)
{
	CParticle@ this = ParticleAnimated("chatBallRed.png", pos, Vec2f(0,0), rot, 1.0f, 1, 0.0f, true);
	if(this !is null)
	{
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
	}
}

void BallTrailCopy(Vec2f pos, float rot, CSprite@ sprite)
{//ballParticleBlue.
	
	ImageData@ edit = Texture::dataFromSprite(sprite);
	if(edit is null)
	{
		print("Edit is null");
		print(sprite.getTextureName() + ' tname');
	}

	for(int i = 0; i < edit.size(); i++)
	{
		//CParticle@ this = ParticleSpark(pos, Vec2f(0,0), edit[i]);
		//if(this !is null)
		//{
		//	this.Z = -10;
		//	this.fastcollision = true;
		//	this.bounce = 0;
		//}
	}

	
	/*CParticle@ this = ParticleAnimated("trail1.png", pos, Vec2f(0,0), rot, 1.0f, 1, 0.0f, true);
	if(this !is null)
	{
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
		//this.setRenderStyle(RenderStyle::normal); //additive works well (light to dark fading effect)
												 //light does well (oposite as above)

	}*/
}


void GodBallTrail(Vec2f pos, float rot)
{
	CParticle@ this = ParticleAnimated("godballtrail.png", pos, Vec2f(0,0), rot, 1.0f, 1, 0.0f, true);
	if(this !is null)
	{
		this.Z = -10;
		this.fastcollision = true;
		this.bounce = 0;
	}
}

void GodBallParticle(Vec2f pos, Vec2f velr)
{
	for(int a = 0; a < 360; a ++)
	{
		CParticle@ this = ParticleSpark(pos + Vec2f(a,a), velr , SColor(100 + XORRandom(255), 0 , 0 + XORRandom(255) , 0));
		if(this !is null)
		{
			this.Z = -10;
			this.fadeout = true;
			this.fastcollision = true;
			this.bounce = 0;
		}
	}
}

void RawParticlee(Vec2f pos) //Can't seem to get this to work.. well i can, but its bloody hard to control, mess one thing up and BOOM! it ded
{
	CParticle@ this = ParticleRawOnScreen(pos);
	if(this !is null)
	{
		this.frame = 0;
		this.framesize = 0;
		this.animated = 0;
		this.style = 0;
		this.framestep = 0;
		this.stylestep = 0;
		this.position = Vec2f(pos);
		this.velocity = Vec2f(0,0);
		this.initpos = Vec2f(pos);
		this.tilepos = Vec2f(pos);
		this.Z = 0;
		this.slide = 0;
		this.damping = 0;
		this.mass = 0;
		this.waterdamping = 1;
		this.gravity = Vec2f(0,0);
		this.collides = true;
		this.diesoncollide = false;
		this.resting = true;
		this.diesonanimate = false;
		this.fastcollision = false;
		this.rotates = true;
		this.stretches = false;
		this.freerotation = false;
		this.rotation = Vec2f(20,20);
		this.freerotationscale = 0;
		this.timeout = 40;
		this.alivetime = 40;
		this.outofbounds = false;
		this.pickable = true;
		this.deadeffect = 0;
		this.emiteffect = 0;
		//this.effectoncollide = 0; //AAAAAAAAAAAAA
		this.windaffect = 0;
		this.damage = 0;
		this.standardcollision = true;
		this.scale = 1;
		this.growth = 1;
		this.fadeout = false;
		this.width = 40;
		this.height = 40;
		this.lighting = false;
		this.lighting_delay = 1;
		this.lighting_force_original_color = true;
		this.forcecolor = SColor(100,0,0,100 + XORRandom(125));
	}
}
