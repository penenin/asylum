//==============================================================================
//
//       Class Name:  	AsylumPlayerPawn
//      Description:  	The player's pawn (in-game avatar)
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumPlayerPawn extends xPawn;

var Effect_ShadowController RealtimeShadow;
var bool bRealtimeShadows;

var float Stamina;
var float MaxStamina;
var bool bCanRun;
var bool bRecharge;
var bool bIsRunning;

//Sound related variables
var sound OutOfBreath;
var bool  bPlayingOutOfBreathSound;
var float TimeBeforeNextBreath;
var float PreviousFootstepTime;
var() float WalkSoundInterval;
var() float RunSoundInterval;

simulated function PostBeginPlay()
{
	//Super(UnrealPawn).PostBeginPlay();
	Super.PostBeginPlay();
	PreviousFootstepTime = Level.TimeSeconds;
	// Stamina gain/loss rate = -20/sec
	SetTimer(0.05, true);
	AssignInitialPose();

	if(bActorShadows && bPlayerShadows && (Level.NetMode != NM_DedicatedServer))
	{
		if(!bRealtimeShadows)
		{
			PlayerShadow = Spawn(class'ShadowProjector',self,'',Location);
			PlayerShadow.ShadowActor = self;
			PlayerShadow.bBlobShadow = bBlobShadow;
			PlayerShadow.LightDirection = Normal(vect(1,1,3));
			PlayerShadow.LightDistance = 320;
			PlayerShadow.MaxTraceDistance = 350;
			PlayerShadow.InitShadow();
		}
		else
		{
			RealtimeShadow = Spawn(class'Effect_ShadowController',self,'',Location);
			RealtimeShadow.Instigator = self;
			RealtimeShadow.Initialize();
		}
	}
}


simulated function FootStepping(int Side)
{
    local int SurfaceNum, i;
	local actor A;
	local material FloorMat;
	local vector HL,HN,Start,End,HitLocation,HitNormal;

	if ( (bIsRunning && ((Level.TimeSeconds - PreviousFootstepTime) >= RunSoundInterval)) ||
	    (!bIsRunning && ((Level.TimeSeconds - PreviousFootstepTime) >= WalkSoundInterval))){


		SurfaceNum = 0;

		for ( i=0; i<Touching.Length; i++ )
			if ( ((PhysicsVolume(Touching[i]) != None) && PhysicsVolume(Touching[i]).bWaterVolume)
				|| (FluidSurfaceInfo(Touching[i]) != None) )
			{
				if ( FRand() < 0.5 )
					PlaySound(sound'PlayerSounds.FootStepWater2', SLOT_Interact, FootstepVolume );
				else
					PlaySound(sound'PlayerSounds.FootStepWater1', SLOT_Interact, FootstepVolume );

				if ( !Level.bDropDetail && (Level.DetailMode != DM_Low)
					&& !Touching[i].TraceThisActor(HitLocation, HitNormal,Location - CollisionHeight*vect(0,0,1.1), Location) )
						Spawn(class'WaterRing',,,HitLocation,rot(16384,0,0));
				return;
			}

		if ( bIsCrouched || bIsWalking )
			return;

		if ( (Base!=None) && (!Base.IsA('LevelInfo')) && (Base.SurfaceType!=0) )
		{
			SurfaceNum = Base.SurfaceType;
		}
		else
		{
			Start = Location - Vect(0,0,1)*CollisionHeight;
			End = Start - Vect(0,0,16);
			A = Trace(hl,hn,End,Start,false,,FloorMat);
			if (FloorMat !=None)
				SurfaceNum = FloorMat.SurfaceType;
		}


		PlaySound(SoundFootsteps[SurfaceNum], SLOT_Interact, FootstepVolume,,400 );
		PreviousFootstepTime = Level.TimeSeconds;
	}

}

event Timer()
{

	Super.Timer();




	MaxStamina = Health * 1.27;
	if(bIsRunning) {
		Stamina -= 1.27;
	}
	else {
		if(bRecharge)
			Stamina += 0.127;
	}
	if(!bCanRun)
		bCanRun = true;
	if(Stamina > MaxStamina)
		Stamina = MaxStamina;
	if(Stamina <= 0) {
		Stamina = 0;
		bCanRun = false;
		StopRunning();

	}



	AsylumHUD(Level.GetLocalPlayerController().myHUD).StaminaBarLevel = Stamina;
	if(Stamina == MaxStamina) {
		AsylumHUD(Level.GetLocalPlayerController().myHud).bFadeStaminaBar = true;
	}
	bRecharge = !bRecharge;

	if (bPlayingOutOfBreathSound){
		TimeBeforeNextBreath -= 0.05;
		if (TimeBeforeNextBreath <= 0.000000){
			bPlayingOutOfBreathSound = false;
			TimeBeforeNextBreath = OutOfBreath.Duration + 0.1;
		}

	}else if (Stamina <= 0){

		bPlayingOutOfBreathSound = true;

		//Play heavy breathing sound

		PlayOwnedSound(OutOfBreath,,153);
	}



}

function bool CanRun()
{
	return bCanRun;
}

function StartRunning()
{

	AsylumHUD(Level.GetLocalPlayerController().myHud).ShowStaminaBar();
	if(!bCanRun)
		return;
	GroundSpeed = 300;
	bIsRunning = true;
}

function StopRunning()
{


	bIsRunning = false;
	GroundSpeed = default.GroundSpeed;
	if(Stamina != MaxStamina) {
		AsylumHUD(Level.GetLocalPlayerController().myHud).bFadeStaminaBar = false;
	}
}

function bool CanDoubleJump()
{
	return false;
}

function bool CanMultiJump()
{
	return false;
}

// Player has no squad so override NotifyKilled() with an empty function
function NotifyKilled(Controller Killer, Controller Killed, pawn KilledPawn)
{
}

/*
function SaveGame()
{
	local Object obj;
	local int value;
	local string msg;

	foreach Level.Game.AllDataObjects(class'Object', obj, "Package") {
		value = obj.ObjectFlags & RF_Public;
		if(value != 0)
			msg = "RF_Public";
		else
			msg = "NOT RF_Public";
		Log("SaveGame(): " @ obj.Class @ msg @ obj.Name);
	}

}
*/

function AddDefaultInventory()
{
}

defaultproperties
{
	 OutOfBreath = Sound'AsylumSounds.PersonSound.pant_x'
	 bPlayingOutOfBreathSound = false
	 TimeBeforeNextBreath = OutOfBreath.Duration + 0.1


     RagImpactSounds(0)=Sound'GeneralImpacts.Wet.Breakbone_01'
     RagImpactSounds(1)=Sound'GeneralImpacts.Wet.Breakbone_02'
     RagImpactSounds(2)=Sound'GeneralImpacts.Wet.Breakbone_03'
     RagImpactSounds(3)=Sound'GeneralImpacts.Wet.Breakbone_04'

	 WalkSoundInterval=1.0
	 RunSoundInterval=0.4

	 //Default
	 //SoundFootsteps(0)=Sound'GeneralImpacts.Wet.Breakbone_01'
	 //Rock
	 SoundFootsteps(1)=Sound'PlayerSounds.Final.FootstepRock'
	 //Dirt
	 SoundFootsteps(2)=Sound'PlayerSounds.Final.FootstepDirt'
	 //Metal
	 SoundFootsteps(3)=Sound'PlayerSounds.Final.FootstepMetal'
	 //Wood
	 SoundFootsteps(4)=Sound'PlayerSounds.Final.FootstepWood'
	 //Plant
	 SoundFootsteps(5)=Sound'PlayerSounds.Final.FootstepPlant'
	 //Flesh
	 SoundFootsteps(6)=Sound'PlayerSounds.Final.FootstepFlesh'
	 //Ice
	 SoundFootsteps(7)=Sound'PlayerSounds.Final.FootstepIce'
	 //Snow
	 SoundFootsteps(8)=Sound'PlayerSounds.Final.FootstepSnow'
	 //Water
	 SoundFootsteps(9)=Sound'PlayerSounds.Final.FootstepWater'
	 //Glass
	 SoundFootsteps(10)=Sound'PlayerSounds.Final.FootstepGlass'

     TauntAnims(0)="gesture_point"
     TauntAnims(1)="gesture_beckon"
     TauntAnims(2)="gesture_halt"
     TauntAnims(3)="gesture_cheer"
     TauntAnims(4)="PThrust"
     TauntAnims(5)="AssSmack"
     TauntAnims(6)="ThroatCut"
     TauntAnims(7)="Specific_1"
     Skins(0)=Texture'PlayerSkins.JuggMaleABodyA'
     Skins(1)=Texture'PlayerSkins.JuggMaleAHeadA'
     bCanPickupInventory=false
     // Normal ground speed is 600, walking pct 30%
     GroundSpeed=150.0
     MaxStamina=127.0
     Stamina=127.0
     bIsRunning=false

     bCanRun=true
     bCanDodgeDoubleJump=false
     bRecharge=false
     bCanBoostDodge=false
	bCanDoubleJump=false
	bRealtimeShadows=false
}
