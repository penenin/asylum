class TorchEmitter extends Emitter;

simulated function PostBeginPlay(){
	//SetPhysics(PHYS_Trailer);
	OldLocation = Location;
	Emitters[1] = new(self, "Flames") class'FireEmitter';
	SetTimer(0.05, true);
	Super.PostBeginPlay();
}
event Timer(){
	log(VSize(Location-OldLocation)/0.05);
	if ( (VSize(Location-OldLocation)/0.05) >= 50.0){

		FireEmitter(Emitters[1]).SetParticleLifeRange(0.1, 0.1);

	}else{
		FireEmitter(Emitters[1]).SetParticleLifeRange(0.5,0.5);
	}
	OldLocation=Location;
}
defaultproperties{

	//fire
	//Begin Object Class=SpriteEmitter Name=FlameEmitter


	//End Object

	//smoke
	Begin Object Class=SpriteEmitter Name=SmokeEmitter
			//UseColorScale=true
			//ColorScale(0) = (RelativeTime=0.0,Color=(B=50,G=50,R=50,A=150))
			//ColorScale(1) = (RelativeTime=2.0,Color=(B=0,G=0,R=0,A=255))
			//ColorScaleRepeats = 0.0

			MaxParticles = 20
			Disabled = false
			RespawnDeadParticles = true
			ParticlesPerSecond = 10
			InitialParticlesPerSecond = 10
			AutomaticInitialSpawning = true
			Texture = Texture'AsylumTextures.Weapons.Smoke'
			ZTest = false
			AcceptsProjectors=false
			//AlphaTest = true
			//BlendBetweenSubdivisions = true
			DrawStyle = PTDS_AlphaBlend
			//PTDS_AlphaBlend
			StartSizeRange = (X=(Min=15.0,Max=15.0),Y=(Min=15.0,Max=15.0),Z=(Min=20.0,Max=20.0))
			LifeTimeRange = (Min=4.0,Max=4.0)
			StartVelocityRange = (X=(Min=-20.0,Max=20.0),Y=(Min=-20.0,Max=20.0),Z=(Min=70.0,Max=70.0))


			//SizeScale[0]=(RelativeTime=0.0,RelativeSize=0.5)
			SizeScale[0]=(RelativeTime=1.0,RelativeSize=4.0)
			UseSizeScale = true
			UseRegularSizeScale = false

			FadeOut = true
			FadeOutStartTime=2.0

			FadeIn = true
			FadeInEndTime=1.0

			StartLocationRange = (X=(Min=0.0,Max=0.0),Y=(Min=0.0,Max=0.0),Z=(Min=20.0,Max=20.0))

	End Object

	//Emitters[1] = new(self, "Flames") class'FireEmitter'
	Emitters[0] = SpriteEmitter'SmokeEmitter'
	AutoDestroy = false
	bNoDelete=False

}
