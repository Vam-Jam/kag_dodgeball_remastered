//Dodgeball
#define CLIENT_ONLY
const uint width = getScreenWidth();
const uint height = getScreenHeight();

const Vec2f fPos1 = Vec2f(width - 300, height - 210);
const Vec2f fPos2 = Vec2f(width - 90, height - 150);

const Vec2f cPos1 = Vec2f(width - 290, height - 200);
const Vec2f cPos2 = Vec2f(width - 300, height - 160);
u8 chargeMaxTime = 240;
bool reverse = true;

void onRender(CRules@ this)
{
    CBlob@ blob = getLocalPlayerBlob();
    if(blob is null){ return; }

    Vec2f pPos = blob.getInterpolatedScreenPos();

    const u8 teamNum = blob.getTeamNum();
    const u16 charge = blob.get_u16("charge");
    const u16 chargeB3 = charge * 4;

    //Foreground
    if(charge > 0)
    {
        GUI::DrawFramedPane(pPos - Vec2f(30,40),pPos - Vec2f(-30,20));
        if(charge < 50)
        {
            chargeMaxTime = 240;
            Vec2f chargeProg = Vec2f(pPos.x - 26 + (charge), pPos.y - 26);
            SColor col = SColor(255,chargeMaxTime,200 - chargeB3, 200 - chargeB3);
            GUI::DrawRectangle(pPos - Vec2f(24,34), chargeProg,col);
        }
        else
        {
             //charge timer
            if(reverse)
            {
                chargeMaxTime--;
            }
            else
            {
                chargeMaxTime++;
            }


            if(chargeMaxTime == 255)
            {
                reverse = true;
            }
            if(chargeMaxTime == 0)
            {
                reverse = false;
            }
            
            //col
            Vec2f chargeProg = Vec2f(pPos.x - 26 + (charge), pPos.y - 26);
            u8 time = chargeMaxTime;
            SColor col = SColor(255,time,0,0);
            GUI::DrawRectangle(pPos - Vec2f(24,34), chargeProg,col);
        }
    }
    

}