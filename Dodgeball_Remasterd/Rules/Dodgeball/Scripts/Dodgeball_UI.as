#define CLIENT_ONLY


const f32 SCREEN_X = getScreenWidth();
const f32 SCREEN_Y = getScreenHeight();
const f32 SCREEN_X_HALF = SCREEN_X / 2;
const f32 SCREEN_Y_HALF = SCREEN_Y / 2;



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
	CMap@ map = getMap();
	Render::RemoveScript(cb_id);
	cb_id = Render::addScript(Render::layer_prehud, "Dodgeball_UI.as", "RenderUI", 100.0f);

}

void onTick(CRules@ this)
{
	Vec2f centerPosTop = getDriver().getWorldPosFromScreenPos(Vec2f(SCREEN_X_HALF - 200,SCREEN_Y_HALF - 200));
	Vec2f centerPosBot = getDriver().getWorldPosFromScreenPos(Vec2f(SCREEN_X_HALF + 200,SCREEN_Y_HALF + 200));
	CControls@ controls = getControls();
	//int mousePos = controls.getMouseScreenPos().length();
	//bool mouseClicked = controls.isKeyJustPressed(KEY_LBUTTON);
}

void RenderUI(int id)
{
	CMap@ map = getMap();
	CRules@ rules = getRules();
	CCamera@ camera = getCamera();
	LetsRenderTheUI(map,rules,camera);
}
bool posReset = false;

Vertex[] v_raw;
const SColor col = SColor(255,255,255,255);
void LetsRenderTheUI(CMap@ map, CRules@ rules, CCamera@ camera)
{
	f32 targetZoom = camera.targetDistance * 2;
	//print(""+targetZoom);

	Vec2f botPos = getDriver().getWorldPosFromScreenPos(Vec2f(0 + 50,SCREEN_Y - 50));
	Vec2f centerPosTop = getDriver().getWorldPosFromScreenPos(Vec2f(SCREEN_X_HALF - 200,SCREEN_Y_HALF - 200));
	Vec2f centerPosBot = getDriver().getWorldPosFromScreenPos(Vec2f(SCREEN_X_HALF + 200,SCREEN_Y_HALF + 200));

	v_raw.clear();
	int zoomScale = 20 / targetZoom;

	Vec2f rotateNegTest = Vec2f(botPos.x - zoomScale, botPos.y - zoomScale);
	Vec2f rotatePosTest =  Vec2f(botPos.x + zoomScale, botPos.y + zoomScale);
	v_raw.push_back(Vertex(rotateNegTest.x, rotateNegTest.y , 1, 0, 0, col));
	v_raw.push_back(Vertex(rotatePosTest.x			 	  , rotateNegTest.y, 1, 1, 0, col));
	v_raw.push_back(Vertex(rotatePosTest.x, rotatePosTest.y, 1, 1, 1, col));
	v_raw.push_back(Vertex(rotateNegTest.x			      , rotatePosTest.y, 1, 0, 1, col));


	Render::RawQuads("TempCog.png", v_raw);

	

	/*v_raw.clear();

	v_raw.push_back(Vertex((centerPosBot.x - zoomScale), (centerPosBot.y - zoomScale) , 1, 1, 1, col));
	v_raw.push_back(Vertex((centerPosTop.x + zoomScale), (centerPosBot.y - zoomScale), 1, 0, 1, col));
	v_raw.push_back(Vertex((centerPosTop.x + zoomScale), (centerPosTop.y + zoomScale), 1, 0, 0, col));
	v_raw.push_back(Vertex((centerPosBot.x - zoomScale), (centerPosTop.y + zoomScale), 1, 1, 0, col));

	Render::RawQuads("TempBoder.png", v_raw);*/

	/*	v_raw.push_back(Vertex(startPos.x,startPos.y+40,	    100, 0, 1, SColor(255,255,255,255)));//top
	v_raw.push_back(Vertex(startPos.x,startPos.y+30,	    100, 0, 0, SColor(255,255,255,255)));//middle
	v_raw.push_back(Vertex(startPos.x + 20,startPos.y+20,		    100, 1, 1, SColor(255,255,255,255)));//bottom

	Render::SetAlphaBlend(true);
	Render::RawTriangles("JellyTest.png", v_raw);*/
}


/*void onRender(CRules@ this)
{

}*/



//1
	//201
	//516

	//315
//2
	//44
	//673

	//629
//3
	//-270
	//986

	//1256