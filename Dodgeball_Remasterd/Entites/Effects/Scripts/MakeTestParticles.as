void MakeTestParticles(Vec2f pos, string file)
{
	CParticle@ temp = ParticleAnimated(CFileMatcher(file).getFirst(), pos - Vec2f(0, 8), Vec2f(0, 0), 1.0f + XORRandom(500.0f), 0.5f + XORRandom(2.0f), 3, 0.0f, false);
	if (temp !is null)
	{
		temp.width = 8;
		temp.height = 8;
	}
}
