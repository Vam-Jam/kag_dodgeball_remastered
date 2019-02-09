
void onRender(CRules@ this)
{
	CPlayer@ player = getLocalPlayer();

	if(player is null)
		return;

	CBlob@ blob = player.getBlob();
	if(blob is null)
		return;

	CControls@ controls = player.getControls();

	GUI::DrawText("Charge is : " +blob.get_u16("charge") , controls.getMouseScreenPos() + Vec2f(0,-20), SColor(255,100,100,100));

	

}
