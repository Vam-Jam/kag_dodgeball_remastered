//pretty straightforward, set properties for larger explosives
// wont work without "exploding"  tag

#include "Explosion.as";  // <---- onHit()

void onDie(CBlob@ this)
{
	Explode(this, 100.0f, 10.0f);
}
