class FireEmitter extends SpriteEmitter;
function SetParticleLifeRange(float Minimum, float Maximum){
	LifeTimeRange.Min=Minimum;
	LifeTimeRange.Max=Maximum;
}
defaultproperties{

			UseColorScale=true
			ColorScale(0) = (RelativeTime=0.0,Color=(B=118,G=209,R=254,A=255))
			ColorScale(1) = (RelativeTime=2.0,Color=(B=0,G=0,R=255,A=150))
			ColorScaleRepeats = 0.0
			
			MaxParticles = 200
			Disabled = false
			RespawnDeadParticles = true
			ParticlesPerSecond = 50
			InitialParticlesPerSecond = 50
			AutomaticInitialSpawning = true
			Texture = Texture'AsylumTextures.Weapons.Flame'
			ZTest = false
			AcceptsProjectors=false
			//AlphaTest = true
			//BlendBetweenSubdivisions = true
			DrawStyle = PTDS_Brighten
			//PTDS_AlphaBlend
			StartSizeRange = (X=(Min=15.0,Max=15.0),Y=(Min=15.0,Max=15.0),Z=(Min=20.0,Max=20.0))
			LifeTimeRange = (Min=0.5,Max=0.5)
			StartVelocityRange = (X=(Min=-20.0,Max=20.0),Y=(Min=-20.0,Max=20.0),Z=(Min=100.0,Max=100.0))

			
			SizeScale[0]=(RelativeTime=1.0,RelativeSize=0.0)
			UseSizeScale = true
			UseRegularSizeScale = false

			FadeOut = true
			FadeOutStartTime=0

			StartLocationRange = (X=(Min=-5.0,Max=5.0),Y=(Min=-5.0,Max=5.0),Z=(Min=20.0,Max=20.0))

}