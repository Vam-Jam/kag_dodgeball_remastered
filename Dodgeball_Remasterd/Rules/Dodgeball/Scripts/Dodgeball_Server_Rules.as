//Dodgeball rules 
//remove map db19

//int8 != u8

#define SERVER_ONLY

bool notEnoughPlayers = false;
uint gameStartsIn = 0;
u8 teamRedInGame = 0;
u8 teamBlueInGame = 0;
u8 teamRedAlive = 0;
u8 teamBlueAlive = 0;
u8 ticksToWin = 0;
u32 barrierShrinkIn = 0;

void onInit(CRules@ this)
{
	onRestart(this);
}

void onNewPlayerJoin(CRules@ this, CPlayer@ player)
{
	randomTeam(player);
	//playerJoinSyncStuff(this,player);
}


void onPlayerDie( CRules@ this, CPlayer@ victim, CPlayer@ attacker, u8 customData )
{
	if(victim !is null)
	{
		if(victim.getTeamNum() == 0)
			teamBlueAlive += -1;
		else
			teamRedAlive += -1;
		//TODO make grave for possible respawn!!
		//victim.set_u32("respawn time",getGameTime() + (15*30));
		//victim.SyncToPlayer("respawn time",victim);
	}
}



void onTick(CRules@ this)
{
	uint currentGameTime = getGameTime();
	if(this.get_bool("gameStarted"))
	{
		if(teamRedAlive == 0 && teamBlueAlive == 0)
		{
			ticksToWin += 1;
			victoryStuff(this,3);
		}
		else if(teamRedAlive == 0)
		{
			if(ticksToWin == 30)
			{
				this.SetGlobalMessage("Team Blue won!");
				victoryStuff(this,0);
			}
			else
			{
				ticksToWin += 1;
			}
			//Todo sound and some effects
		}
		else if(teamBlueAlive == 0)
		{
			if(ticksToWin == 30)
			{
				this.SetGlobalMessage("Team Red won!");
				victoryStuff(this,1);
			}
			else
			{
				ticksToWin += 1;
			}
		}
		/*
		if(barrierShrinkIn != 0 && barrierShrinkIn < currentGameTime)
		{
			barrierShrinkIn = 0;
			print("done");
			this.set_bool("BreakBarrier",true);
			this.Sync("BreakBarrier",false);
		}*/
		//else
		//{
			/*CMap@ map = getMap();
			int mapPosLeft = ((map.tilemapwidth * map.tilesize) * 0.5)-16;
			int mapPosRight = ((map.tilemapwidth * map.tilesize) * 0.5)+24;
			for(u8 i = 0; i < getPlayerCount(); i++) //for each player in game
			{
				CPlayer@ player = getPlayer(i);
				if(player !is null)
				{
					CBlob@ blob = player.getBlob();
					if (blob !is null) 
					{
						if(blob.getTeamNum() == 0 && blob.getPosition().x > mapPosLeft)
						{
							blob.AddForce(Vec2f((mapPosLeft-blob.getPosition().x) * 0.5 , 0));
						}
						else if(blob.getTeamNum() == 1 && blob.getPosition().x < mapPosRight)
						{
							blob.AddForce(Vec2f((mapPosRight-blob.getPosition().x) * 0.5 , 0));
						}
					}
				}
			}*/

		//}

		for(u8 i = 0; i < getPlayerCount(); i++) //for each player in game
		{
			CPlayer@ player = getPlayer(i);
			if(player !is null)
			{
				CBlob@ blob = player.getBlob();
				if (blob is null && player.hasTag("Respawn")) 
				{

					player.Untag("Respawn");
					CBlob@ newPlayerBlob = server_CreateBlob("TestWizard");
					if (newPlayerBlob !is null)
					{
						newPlayerBlob.setPosition(this.get_Vec2f(player.getTeamNum()+"Spawn"));
						newPlayerBlob.server_setTeamNum(player.getTeamNum());
						newPlayerBlob.server_SetPlayer(player);
						if(player.getTeamNum() == 0)
							teamBlueAlive += 1;
						else
							teamRedAlive += 1;
					}			
				}
				else if(blob is null && player.hasTag("Revived"))
				{

					//respawn them at grave pos
				}
			}
		}


	}
	else
	{
		spawnAtSpawn(this);
		if(getPlayerCount() < 2)
		{
			if(!notEnoughPlayers)
			{

				notEnoughPlayers = true;
				this.SetGlobalMessage("Waiting for more players!");
			}
		}
		else
		{
			if(gameStartsIn == 0)
			{
				gameStartsIn = currentGameTime + 150;
			}
			this.SetGlobalMessage("Game starts in " + ((gameStartsIn - currentGameTime) / 30));
			if(gameStartsIn < currentGameTime)
			{
				barrierShrinkIn = currentGameTime + 2700;
				this.set_u32("barrierShrinkIn" , currentGameTime + 2700);
				this.set_bool("gameStarted", true);
				this.Sync("gameStarted",true);
				for(u8 i = 0; i < getPlayerCount(); i++) 
				{
					CPlayer@ player = getPlayer(i);
					if(player !is null)
					{
						CBlob@ blob = player.getBlob();
						if (blob is null) 
						{
							player.Tag("Respawn");
						}

					}
				}
				this.SetGlobalMessage("");
			}
		}
	}
}

void victoryStuff(CRules@ this, int8 teamnum)
{
	LoadNextMap();
}

void spawnAtSpawn(CRules@ this)
{
	for(u8 i = 0; i < getPlayerCount(); i++) //for each player in game
	{
		CPlayer@ player = getPlayer(i);
		if(player !is null)
		{
			CBlob@ blob = player.getBlob();
			if (blob is null) 
			{
				if(player.hasTag("Joined"))
				{
					CBlob@ newPlayerBlob = server_CreateBlob("TestWizard");
					if (newPlayerBlob !is null)
					{
						newPlayerBlob.setPosition(this.get_Vec2f(player.getTeamNum()+"Spawn"));
						newPlayerBlob.server_setTeamNum(player.getTeamNum());
						newPlayerBlob.server_SetPlayer(player);
						if(player.getTeamNum() == 0)
							teamBlueAlive += 1;
						else
							teamRedAlive += 1;
					}	
				}		
			}
		}
	}
}


void setSpawnPos()
{
	CMap@ map = getMap();
	CRules@ rules = getRules();

	if (map !is null && map.tilemapwidth != 0)
	{
		Vec2f spawn;
		Vec2f respawnPos;
		if(getMap().getMarker("blue main spawn", spawn))
		{
			respawnPos = spawn;
			respawnPos.y -= 16.0f;
			server_CreateBlob("tdm_spawn", 0, respawnPos);
			rules.set_Vec2f("0Spawn", spawn);
			rules.Sync("0Spawn",true);
		}

		if(getMap().getMarker("red main spawn", spawn))
		{
			respawnPos = spawn;
			respawnPos.y -= 16.0f;
			server_CreateBlob("tdm_spawn", 1, respawnPos);
			rules.set_Vec2f("1Spawn", spawn);
			rules.Sync("1Spawn",true);
		}

	}
}

void randomTeam(CPlayer@ player)
{
	player.Tag("Joined");
	if(teamRedInGame == teamBlueInGame)
	{
		int teamnum = XORRandom(2);
		player.server_setTeamNum(teamnum);
		if(teamnum == 0)
			teamBlueInGame += 1;
		else
			teamRedInGame += 1;
	}
	else if(teamRedInGame > teamBlueInGame)
	{
		player.server_setTeamNum(0);
		teamBlueInGame += 1;
	}
	else
	{
		player.server_setTeamNum(1);
		teamRedInGame += 1;
	}
}


void scrambleTeams(CRules@ this)
{
	for(u8 i = 0; i < getPlayerCount(); i++) //for each player in game
	{
		CPlayer@ player = getPlayer(i);
		if(player !is null)
		{
			randomTeam(player);
		}
	}
}

/*void playerJoinSyncStuff(CRules@ this,CPlayer@ player)
{
	this.SyncToPlayer("BreakBarrier",player);
	this.SyncToPlayer("gameStarted",player);
}*/

void resetStuff(CRules@ this)
{
	notEnoughPlayers = false;
	gameStartsIn = 0;
	teamRedInGame = 0;
	teamBlueInGame = 0;
	teamRedAlive = 0;
	teamBlueAlive = 0;
	ticksToWin = 0;
	barrierShrinkIn = 0;

	this.SetGlobalMessage("");
	this.set_bool("BreakBarrier",false);
	this.Sync("BreakBarrier",true);
	this.set_bool("gameStarted", false);
	this.Sync("gameStarted",true);
}

void onRestart(CRules@ this )
{
	resetStuff(this);
	scrambleTeams(this);
	setSpawnPos();

	this.SetCurrentState(GAME);
	this.SetGlobalMessage("");	
}