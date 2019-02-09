// red barrier before match starts

//TODO clean up code, way to messy from testing, but it works with good performance for now.
//Team 255 spec so they can see the barrier



Vertex[] v_raw;
const string Jelly_name = "JellyTest.png";
//string render_texture_name;
const string test_name = "_scriptrender_test_texture";

void Setup()
{
	//ensure texture for our use exists
	if(!Texture::exists(test_name))
	{
		if(!Texture::createBySize(test_name, 8, 8))
		{
			warn("texture creation failed");
		}
		else
		{
			ImageData@ edit = Texture::data(test_name);

			for(int i = 0; i < edit.size(); i++)
			{
				edit[i] = SColor((((i + i / 8) % 2) == 0) ? 0xff707070 : 0xff909090);
			}

			if(!Texture::update(test_name, edit))
			{
				warn("texture update failed");
			}
		}
	}
}

void onTick(CRules@ this)
{
	CMap@ map = getMap();
	int posLeft = ((map.tilemapwidth * map.tilesize) * 0.5)-16;
	int posRight = ((map.tilemapwidth * map.tilesize) * 0.5)+24;
	for(u8 i = 0; i < getPlayerCount(); i++) //for each player in game
	{
		CPlayer@ player = getPlayer(i);
		if(player !is null)
		{
			CBlob@ blob = player.getBlob();
			if (blob !is null) 
			{
				if(blob.getTeamNum() == 0 && blob.getPosition().x > posLeft )
				{
					//print((blob.getPosition().x - posLeft)+"");
					blob.AddForce(Vec2f(-(blob.getPosition().x - (posLeft + 2))*7, 0));
				}
				else if(blob.getTeamNum() == 1 && blob.getPosition().x < posRight)
				{
					blob.AddForce(Vec2f(-(blob.getPosition().x - (posRight - 2))*7, 0));
				}
			}
		}
	}
}

void onRestart(CRules@ this)
{
	Reset(this);
}

void onInit(CRules@ this)
{
	Reset(this);
}

int cb_id = 0;

void Reset(CRules@ this)
{
	Setup();
	rightBotPos.clear();
	rightTopPos.clear();
	leftTopPos.clear();
	leftBotPos.clear();
	CMap@ map = getMap();
	Render::RemoveScript(cb_id);
	//posLeft.x = ((map.tilemapwidth * map.tilesize) * 0.5)-15;
	//posLeft.y = (map.tilemapheight / 10);
    //posRight.x = ((map.tilemapwidth * map.tilesize) * 0.5)+25;
	//posRight.y = (map.tilemapheight / 10);
	//render_texture_name = Jelly_name;
	cb_id = Render::addScript(Render::layer_postworld, "Dodgeball_Barrier.as", "RenderJelly", 100.0f);

}

void RenderJelly( int id)
{
	CMap@ map = getMap();
	CRules@ rules = getRules();
	RenderTheJellyTeam0(map,rules);
}

Vec2f posLeft;
Vec2f posRight;


//required for the length, if you don't have enoguh Vec2f placed down the engine hard crashes..
Vec2f[] leftTopPos = {Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0)};
Vec2f[] leftBotPos = {Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0)};

Vec2f[] rightTopPos = {Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0)};
Vec2f[] rightBotPos = {Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0),Vec2f(0,0)};

//Team 0 = left

//team 1 = right
int dryOutTime = 0;

void RenderTheJellyTeam0(CMap@ map, CRules@ rules)
{

	posLeft.x = ((map.tilemapwidth * map.tilesize) * 0.5)-16;
	//posLeft.y = (map.tilemapheight / 10);
	posRight.x = ((map.tilemapwidth * map.tilesize) * 0.5)+24;
	v_raw.clear();
	string render_texture_name = test_name;
	/*if(rules.get_bool("BreakBarrier") == true)
	{
		if(dryOutTime == 0)
			dryOutTime = getGameTime() + 150;//5 seconds before explosion
		print(""+getGameTime());//can be between 10 and 1.. gg
		
		//jelly dries up
		//sound effect
		//particle
	}*/
	
	for(int a = 0; a < 13; a++)
	{
		int b = 0;
		if(a == 0)
			b = -20;
		else
			b = (a * 20) - 20;//for each position for each chunk.
		CBlob@[] blobsInBotBox;//blobs in box
		CBlob@[] blobsInTopBox;//blobs in box
		//get pos for pushback
		leftTopPos[a] = Vec2f(posLeft.x,0 + b);//top part
		leftBotPos[a] = Vec2f(posLeft.x,20 + b);//bot part

		map.getBlobsInBox(Vec2f(posLeft.x,20+b),Vec2f(posLeft.x+20,20+b),@blobsInBotBox);
		map.getBlobsInBox(Vec2f(posLeft.x,0+b),Vec2f(posLeft.x+20,0+b),@blobsInTopBox);//get object in both areas
		if(blobsInBotBox.length != 0)
		{
			for (uint i = 0; i < blobsInBotBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInBotBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = leftBotPos[a] - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							//normalPos = -tempPos + blob.getPosition();
						}
						else
						{
							if(blob.getTeamNum() == 0)
							{
								leftBotPos[a] = -tempPos + leftBotPos[a];
								//print(""+tempPos.x);
								//blob.AddForce(Vec2f(tempPos.x , 0));
							}
						}
					}
				}
			}
		}

		if(blobsInTopBox.length != 0)
		{
			for (uint i = 0; i < blobsInTopBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInTopBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = leftTopPos[a] - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							//normalPos = -tempPos + blob.getPosition();
						}
						else
						{	
							if(blob.getTeamNum() == 0)
							{
								leftTopPos[a] = -tempPos + leftTopPos[a];
								//blob.AddForce(Vec2f(tempPos.x , 0));
							}
						}
					}
				}
			}
		}



			//1 0
			//1 0
			// 0 0

			// 0 0
			// 1 1
			// 0 1
		//left triangle pointing out

		v_raw.push_back(Vertex(posLeft.x+20,10+b,		    100, 1, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(posLeft.x+20,30+b,		    100, 1, 1, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(leftBotPos[a].x,20+b,		100, 0, 1,SColor(200,255,255,255)));//bottom

		//right triangle pointing in

		v_raw.push_back(Vertex(leftTopPos[a].x,0+b,	 		 100, 0, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(posLeft.x+20,10+b,			 100, 1, 1, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(leftBotPos[a].x,20+b,   		 100, 0, 1, SColor(200,255,255,255)));//bottom

	}

	for(int a = 0; a < 13; a++)
	{
		int b = 0;
		if(a == 0)
			b = -20;
		else
			b = (a * 20) - 20;//for each position for each chunk.
		CBlob@[] blobsInBotBox;//blobs in box
		CBlob@[] blobsInTopBox;//blobs in box
		//get pos for pushback
				//get pos for pushback
		rightBotPos[a] = Vec2f(posRight.x,0 + b);//top part
		rightTopPos[a] = Vec2f(posRight.x,20 + b);//bot part

		map.getBlobsInBox(Vec2f(posRight.x,20+b),Vec2f(posRight.x-20,30+b),@blobsInBotBox);
		map.getBlobsInBox(Vec2f(posRight.x,0+b),Vec2f(posRight.x-20,10+b),@blobsInTopBox);//get object in both areas
		if(blobsInBotBox.length != 0)
		{
			for (uint i = 0; i < blobsInBotBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInBotBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = rightBotPos[a] - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							if(blob.getTeamNum() == 1)
							{
							//normalPos = -tempPos + blob.getPosition();
								rightBotPos[a] = -tempPos + rightBotPos[a];
								//blob.AddForce(Vec2f(tempPos.x , 0));
							}
						}
						else
						{
							//blob.AddForce(Vec2f(-tempPos.x * 0.5 , 0));

						}
					}
				}
			}
		}

		if(blobsInTopBox.length != 0)
		{
			for (uint i = 0; i < blobsInTopBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInTopBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = posRight - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							if(blob.getTeamNum() == 1)
							{
								rightTopPos[a] = -tempPos + rightTopPos[a];
								//blob.AddForce(Vec2f(tempPos.x * 0.5 , 0));
							}
							//normalPos = -tempPos + blob.getPosition();
						}
						else
						{
							//blob.AddForce(Vec2f(-tempPos.x * 0.5 , 0));

						}
					}
				}
			}
		}
				//bot

					//0 1
					// 0 0
					// 1 1

					// 1 0
				    // 0 0
					// 1 0
		v_raw.push_back(Vertex(rightTopPos[a].x,10+b,	    100, 0, 1, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(rightBotPos[a].x,30+b,	    100, 0, 0, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(posRight.x-20,20+b,		    100, 1, 1, SColor(200,255,255,255)));//bottom


		v_raw.push_back(Vertex(posRight.x-20,0+b,			 100, 1, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(rightTopPos[a].x,10+b,		 100, 0, 1, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(posRight.x-20,20+b,   		 100, 1, 1, SColor(200,255,255,255)));//bottom
	}



	Render::SetAlphaBlend(true);
	Render::RawTriangles("JellyTest.png", v_raw);

}

/*
void RenderTheJellyTeam1(CMap@ map,CRules@ rules)
{
	posLeft.x = ((map.tilemapwidth * map.tilesize) * 0.5)-16;
	//posLeft.y = (map.tilemapheight / 10);
	posRight.x = ((map.tilemapwidth * map.tilesize) * 0.5)+24;
	v_raw.clear();
	string render_texture_name = test_name;
	for(int a = 0; a < 13; a++)
	{
		int b = 0;
		if(a == 0)
			b = -20;
		else
			b = (a * 20) - 20;//for each position for each chunk.
		CBlob@[] blobsInBotBox;//blobs in box
		CBlob@[] blobsInTopBox;//blobs in box
		//get pos for pushback
				//get pos for pushback
		leftTopPos[a] = Vec2f(posLeft.x,0 + b);//top part
		leftBotPos[a] = Vec2f(posLeft.x,20 + b);//bot part
		rightBotPos[a] = Vec2f(posRight.x,0 + b);//top part
		rightTopPos[a] = Vec2f(posRight.x,20 + b);//bot part

		map.getBlobsInBox(Vec2f(posRight.x,20+b),Vec2f(posRight.x-20,30+b),@blobsInBotBox);
		map.getBlobsInBox(Vec2f(posRight.x,0+b),Vec2f(posRight.x-20,10+b),@blobsInTopBox);//get object in both areas
		if(blobsInBotBox.length != 0)
			{
				for (uint i = 0; i < blobsInBotBox.length; i++)
				{//for every blob in box
					CBlob@ blob = blobsInBotBox[i];
					if(blob !is null)//make sure its not null
					{
						if(blob.hasTag("player"))
						{
							Vec2f tempPos = rightBotPos[a] - blob.getPosition();//work out the diffrence
							if(tempPos.x > 0)
							{
								if(blob.getTeamNum() == 1)
								{
								//normalPos = -tempPos + blob.getPosition();
									rightBotPos[a] = -tempPos + rightBotPos[a];
									//blob.AddForce(Vec2f(tempPos.x , 0));
								}
							}
							else
							{
								//blob.AddForce(Vec2f(-tempPos.x * 0.5 , 0));

							}
						}
					}
				}
			}

			if(blobsInTopBox.length != 0)
			{
				for (uint i = 0; i < blobsInTopBox.length; i++)
				{//for every blob in box
					CBlob@ blob = blobsInTopBox[i];
					if(blob !is null)//make sure its not null
					{
						if(blob.hasTag("player"))
						{
							Vec2f tempPos = posRight - blob.getPosition();//work out the diffrence
							if(tempPos.x > 0)
							{
								if(blob.getTeamNum() == 1)
								{
									rightTopPos[a] = -tempPos + rightTopPos[a];
									//blob.AddForce(Vec2f(tempPos.x , 0));
								}
								//normalPos = -tempPos + blob.getPosition();
							}
							else
							{
								//blob.AddForce(Vec2f(-tempPos.x * 0.5 , 0));

							}
						}
					}
				}
			}
		}

		for(int a = 0; a < 13; a++)
		{
			int b = 0;
			if(a == 0)
				b = -20;
			else
				b = (a * 20) - 20;//for each position for each chunk.
			CBlob@[] blobsInBotBox;//blobs in box
			CBlob@[] blobsInTopBox;//blobs in box
			//get pos for pushback
			leftTopPos[a] = Vec2f(posLeft.x,0 + b);//top part
			leftBotPos[a] = Vec2f(posLeft.x,20 + b);//bot part

			map.getBlobsInBox(Vec2f(posLeft.x,20+b),Vec2f(posLeft.x+20,20+b),@blobsInBotBox);
			map.getBlobsInBox(Vec2f(posLeft.x,0+b),Vec2f(posLeft.x+20,0+b),@blobsInTopBox);//get object in both areas
			if(blobsInBotBox.length != 0)
			{
				for (uint i = 0; i < blobsInBotBox.length; i++)
				{//for every blob in box
					CBlob@ blob = blobsInBotBox[i];
					if(blob !is null)//make sure its not null
					{
						if(blob.hasTag("player"))
						{
							Vec2f tempPos = leftBotPos[a] - blob.getPosition();//work out the diffrence
							if(tempPos.x > 0)
							{
								//normalPos = -tempPos + blob.getPosition();
							}
							else
							{
								if(blob.getTeamNum() == 0)
								{
									leftBotPos[a] = -tempPos + leftBotPos[a];
									//blob.AddForce(Vec2f(tempPos.x, 0));
								}
							}
						}
					}
				}
			}

			if(blobsInTopBox.length != 0)
			{
				for (uint i = 0; i < blobsInTopBox.length; i++)
				{//for every blob in box
					CBlob@ blob = blobsInTopBox[i];
					if(blob !is null)//make sure its not null
					{
						if(blob.hasTag("player"))
						{
							Vec2f tempPos = leftTopPos[a] - blob.getPosition();//work out the diffrence
							if(tempPos.x > 0)
							{
								//normalPos = -tempPos + blob.getPosition();
							}
							else
							{	
								if(blob.getTeamNum() == 0)
								{
									leftTopPos[a] = -tempPos + leftTopPos[a];
									//blob.AddForce(Vec2f(tempPos.x , 0));
								}
							}
						}
					}
				}
			}


		v_raw.push_back(Vertex(posLeft.x+20,10+b,		    100, 1, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(posLeft.x+20,30+b,		    100, 1, 0, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(leftBotPos[a].x,20+b,		100, 0, 0,SColor(200,255,255,255)));//bottom

		//right triangle pointing in

		v_raw.push_back(Vertex(leftTopPos[a].x,0+b,	 		 100, 0, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(posLeft.x+20,10+b,			 100, 1, 1, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(leftBotPos[a].x,20+b,   		 100, 0, 1, SColor(200,255,255,255)));//bottom
		//left triangle pointing out

		v_raw.push_back(Vertex(rightTopPos[a].x,10+b,	    100, 0, 1, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(rightBotPos[a].x,30+b,	    100, 0, 0, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(posRight.x-20,20+b,		    100, 1, 1, SColor(200,255,255,255)));//bottom

		//right triangle pointing in

		v_raw.push_back(Vertex(posRight.x-20,0+b,			 100, 1, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(rightTopPos[a].x,10+b,		 100, 0, 0, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(posRight.x-20,20+b,   		 100, 1, 0, SColor(200,255,255,255)));//bottom
	}
	Render::SetAlphaBlend(true);
	Render::RawTriangles("JellyTest.png", v_raw);
}
*/



/*void RenderTheJelly(CMap@ map)
{
	//string render_texture_name = Jelly_name;
	v_raw.clear();
	posLeft.x = ((map.tilemapwidth * map.tilesize) * 0.5)-15;
	posLeft.y = (map.tilemapheight / 10);
	posRight.x = ((map.tilemapwidth * map.tilesize) * 0.5)+25;
	posRight.y = (map.tilemapheight / 10);
	string render_texture_name = test_name	;
	for(int a = 0; a < 13; a++)
	{
		int b = 0;
		if(a == 0)
			b = -20;
		else
			b = (a * 20) - 20;//for each position for each chunk.
		CBlob@[] blobsInBotBox;//blobs in box
		CBlob@[] blobsInTopBox;//blobs in box
		//get pos for pushback
		leftTopPos[a] = Vec2f(posLeft.x,0 + b);//top part
		leftBotPos[a] = Vec2f(posLeft.x,20 + b);//bot part

		map.getBlobsInBox(Vec2f(posLeft.x,20+b),Vec2f(posLeft.x+20,20+b),@blobsInBotBox);
		map.getBlobsInBox(Vec2f(posLeft.x,0+b),Vec2f(posLeft.x+20,0+b),@blobsInTopBox);//get object in both areas
		if(blobsInBotBox.length != 0)
		{
			for (uint i = 0; i < blobsInBotBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInBotBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = leftBotPos[a] - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							//normalPos = -tempPos + blob.getPosition();
						}
						else
						{
							leftBotPos[a] = -tempPos + leftBotPos[a];
							blob.AddForce(Vec2f(tempPos.x * 0.5 , 0));

						}
					}
				}
			}
		}

		if(blobsInTopBox.length != 0)
		{
			for (uint i = 0; i < blobsInTopBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInTopBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = leftTopPos[a] - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							//normalPos = -tempPos + blob.getPosition();
						}
						else
						{
							leftTopPos[a] = -tempPos + leftTopPos[a];
							blob.AddForce(Vec2f(tempPos.x * 0.5 , 0));

						}
					}
				}
			}
		}
		//left triangle pointing out

		v_raw.push_back(Vertex(posLeft.x+20,10+b,		    100, 1, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(posLeft.x+20,30+b,		    100, 1, 0, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(leftBotPos[a].x,20+b,		100, 0, 0,SColor(200,255,255,255)));//bottom

		//right triangle pointing in

		v_raw.push_back(Vertex(leftTopPos[a].x,0+b,	 		 100, 0, 0, SColor(200,255,255,255)));//top
		v_raw.push_back(Vertex(posLeft.x+20,10+b,			 100, 1, 1, SColor(200,255,255,255)));//middle
		v_raw.push_back(Vertex(leftBotPos[a].x,20+b,   		 100, 0, 1, SColor(200,255,255,255)));//bottom
	}


	//right side
	for(int a = 0; a < 13; a++)
	{
		int b = 0;
		if(a == 0)
			b = -20;
		else
			b = (a * 20) - 20;//for each position for each chunk.
		CBlob@[] blobsInBotBox;//blobs in box
		CBlob@[] blobsInTopBox;//blobs in box
		//get pos for pushback
		rightBotPos[a] = Vec2f(posRight.x,0 + b);//top part
		rightTopPos[a] = Vec2f(posRight.x,20 + b);//bot part

		map.getBlobsInBox(Vec2f(posRight.x,20+b),Vec2f(posRight.x-20,30+b),@blobsInBotBox);
		map.getBlobsInBox(Vec2f(posRight.x,0+b),Vec2f(posRight.x-20,10+b),@blobsInTopBox);//get object in both areas
		if(blobsInBotBox.length != 0)
		{
			for (uint i = 0; i < blobsInBotBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInBotBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = rightBotPos[a] - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							//normalPos = -tempPos + blob.getPosition();
							rightBotPos[a] = -tempPos + rightBotPos[a];
							blob.AddForce(Vec2f(tempPos.x * 0.5 , 0));
						}
						else
						{
							//blob.AddForce(Vec2f(-tempPos.x * 0.5 , 0));

						}
					}
				}
			}
		}

		if(blobsInTopBox.length != 0)
		{
			for (uint i = 0; i < blobsInTopBox.length; i++)
			{//for every blob in box
				CBlob@ blob = blobsInTopBox[i];
				if(blob !is null)//make sure its not null
				{
					if(blob.hasTag("player"))
					{
						Vec2f tempPos = posRight - blob.getPosition();//work out the diffrence
						if(tempPos.x > 0)
						{
							//normalPos = -tempPos + blob.getPosition();
							rightTopPos[a] = -tempPos + rightTopPos[a];
							blob.AddForce(Vec2f(tempPos.x * 0.5 , 0));
						}
						else
						{
							//blob.AddForce(Vec2f(-tempPos.x * 0.5 , 0));

						}
					}
				}
			}
		}
		//left triangle pointing out

		v_raw.push_back(Vertex(rightTopPos[a].x,10+b,	    100, 0, 1, SColor(220,255,255,255)));//top
		v_raw.push_back(Vertex(rightBotPos[a].x,30+b,	    100, 0, 0, SColor(220,255,255,255)));//middle
		v_raw.push_back(Vertex(posRight.x-20,20+b,		    100, 1, 1, SColor(220,255,255,255)));//bottom

		//right triangle pointing in

		v_raw.push_back(Vertex(posRight.x-20,0+b,			 100, 1, 0, SColor(220,255,255,255)));//top
		v_raw.push_back(Vertex(rightTopPos[a].x,10+b,		 100, 0, 0, SColor(220,255,255,255)));//middle
		v_raw.push_back(Vertex(posRight.x-20,20+b,   		 100, 1, 0, SColor(220,255,255,255)));//bottom
	}
	Render::SetAlphaBlend(true);
	Render::RawTriangles("JellyTest.png", v_raw);

}
*/

/*
void onRender(CRules@ this)
{
	if (shouldBarrier(this))
	{
		f32 x1, x2, y1, y2;
		getBarrierPositions(x1, x2, y1, y2);
		GUI::DrawRectangle(getDriver().getScreenPosFromWorldPos(Vec2f(x1, y1)), getDriver().getScreenPosFromWorldPos(Vec2f(x2, y2)), SColor(150, 255, 153, 225)); //transpancey, blue, green, red
	}
}
*/

/**
 * Adding the barrier sector to the map
 */



/**
 * Removing the barrier sector from the map
 */










///////// DUMP OF CRAP THAT DID NOT WORK


		/*else if(blobsInBotBox.length == 0)
		{
					    switch(a)//check lower or higher then ours, if its not the same, then make ours match.
			{
				case 0:
					if(normalTopPos[a].x != normalBotPos[a].x)
						normalBotPos[a] = Vec2f(normalTopPos[a].x/1.3,normalBotPos[a].y);
					else if(normalTopPos[a + 1].x != normalBotPos[a].x)
						normalBotPos[a] = Vec2f(normalTopPos[a + 1].x/1.3,normalBotPos[a].y);

				break;

				case 10:	
					if(normalTopPos[a+1].x != normalBotPos[a].x)
						normalBotPos[a] = Vec2f(normalTopPos[a+1].x/1.3,normalBotPos[a].y);
					else if(normalTopPos[a].x != normalBotPos[a].x)
						normalBotPos[a] = Vec2f(normalTopPos[a].x/1.3,normalBotPos[a].y);
				break;

				case 11:

					//do nothing
				break;

				default:
					if(normalTopPos[a+1].x != normalBotPos[a].x)
					{
						print(""+normalTopPos[a+1].x);
						normalBotPos[a] = Vec2f(normalTopPos[a+1].x/1.3,normalBotPos[a].y);
					}
					else if(normalTopPos[a].x != normalBotPos[a].x)
					{
						print(""+normalTopPos[a].x);
						normalBotPos[a] = Vec2f(normalTopPos[a].x/1.3,normalBotPos[a].y);
					}
					else if(normalTopPos[a-1].x != normalBotPos[a].x)
					{
						print(""+normalTopPos[a-1].x);
						normalBotPos[a] = Vec2f(normalTopPos[a-1].x/1.3,normalBotPos[a].y);
					}
				break;
			}
		}
		else
		{
			switch(a)//check lower or higher then ours, if its not the same, then make ours match.
			{
				case 0:
					//do nothing
				break;

				case 1:
					if(normalBotPos[a - 1].x != normalTopPos[a].x)
						normalTopPos[a] = Vec2f(normalBotPos[a - 1].x/1.3,normalTopPos[a].y);
					else if(normalBotPos[a].x != normalTopPos[a].x)
						normalTopPos[a] = Vec2f(normalBotPos[a].x/1.3,normalTopPos[a].y);
				break;

				case 11:
					if(normalBotPos[a].x != normalTopPos[a].x)
						normalTopPos[a] = Vec2f(normalBotPos[a].x/1.3,normalTopPos[a].y);
					else if(normalBotPos[a - 1].x != normalTopPos[a].x)
						normalTopPos[a] = Vec2f(normalBotPos[a - 1].x/1.3,normalTopPos[a].y);
				break;

				default:
					if(normalBotPos[a - 1].x != normalTopPos[a].x)
					{
						print("yeee");
						normalTopPos[a] = Vec2f(normalBotPos[a - 1].x/1.3,normalTopPos[a].y);
					}
					else if(normalBotPos[a].x != normalTopPos[a].x)
					{
						print("ye");
						normalTopPos[a] = Vec2f(normalBotPos[a].x/1.3,normalTopPos[a].y);
					}
					else if(normalBotPos[a - 2].x != normalTopPos[a].x)
					{
						print("tru");
						normalTopPos[a] = Vec2f(normalBotPos[a - 2].x/1.3,normalTopPos[a].y);
					}
					//else if

				break;
			}*/

			/*for(int be = 0; be < normalTopPos.length; be++)
			{
				if(normalTopPos[be] != Vec2f(0,0))
				{
					print(be +" | "+normalTopPos[be]);
				}
				if(normalBotPos[be] != Vec2f(0,0))
				{
					print(be +" | "+normalBotPos[be]);
				}
			}*/















				/*CBlob@[] blobsInBox;
	Vec2f normalPos = Vec2f(100,0);

	map.getBlobsInBox(Vec2f(100, 180),Vec2f(120,180),@blobsInBox);
	for (uint i = 0; i < blobsInBox.length; i++)
	{
		CBlob@ blob = blobsInBox[i];
		if(blob !is null)
		{
			if(blob.hasTag("player"))
			{
				//82
				//106
				Vec2f tempPos = normalPos - blob.getPosition();
				if(tempPos.x > 0)
				{
					//do particle jelly thing maybe
				}
				else
				{
					normalPos = -tempPos + normalPos;
					blob.AddForce(Vec2f(tempPos.x, 0));
				}
			}
		}
			//print(""+blob.getVelocity());
	}
	v_raw.push_back(Vertex(120,170,10,0, 0, SColor(0xffff0000)));//top
	v_raw.push_back(Vertex(120,190,10,0, 0, SColor(0xffff0000)));//middle
	v_raw.push_back(Vertex(normalPos.x,180 ,10,0, 0, SColor(0xffff0000)));//bottom

	v_raw.push_back(Vertex(normalPos.x,160,10,0, 0, SColor(0xffff0000)));//top
	v_raw.push_back(Vertex(120,170,10,0, 0, SColor(0xffff0000)));//middle
	v_raw.push_back(Vertex(normalPos.x,180 ,10,0, 0, SColor(0xffff0000)));//bottom
	Render::RawTriangles(render_texture_name, v_raw);*/
	//Render::Triangles(render_texture_name, 10, v_pos, v_uv);
