/// UI class


const f32 SCREEN_X = getScreenWidth();
const f32 SCREEN_Y = getScreenHeight();
const f32 SCREEN_X_HALF = SCREEN_X / 2;
const f32 SCREEN_Y_HALF = SCREEN_Y / 2;


class basicTab
{
	Vec2f tabTopLeftPos = Vec2f(0,0);
	Vec2f tabBotRightPos = Vec2f(0,0);
	string tabName = "";
	bool isActive = false;
	int[] allTrailPos;

	basicTab()//onInit
	{
		print("hi");
	}

	void mousePos();
	{
		CControls@ controls = getControls();
		int mousePos = controls.getMouseScreenPos().length();
		bool mouseClicked = controls.isKeyJustPressed(KEY_LBUTTON);
		if(mouseClicked)
		{
			for(int i = 0; i < allTrailPos.length(); i++)
			{
				//
			}
		}
	}

	void render()
	{
		mousePos();


	}
	//do something on click
	void doOnClick(int trailNum)
	{

	}
	//remove everything
	void clearPage()
	{

	}


	//will position trails automagicly
	void addTrail(string name, string desc, int cost, string attribute, int size, string iconFile)
	{
		//Setting up properties


	}


	int16[] getTrailsOwned(string userName);

}