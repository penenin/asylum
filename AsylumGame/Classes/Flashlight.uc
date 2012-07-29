//==============================================================================
//
//       Class Name:  	Flashlight
//      Description:  	A weapon
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class Flashlight extends Weapon;

// taclight projector
var Effect_TacLightSpawner TacLight;

// taclight corona
var Effect_TacLightCorona TacLightCorona;

// infrared for the stalker model
var bool bInfrared;

// when turning on the infrared
var int ZoomNoise;
var() Sound InfraredSound;
var() Sound InfrastopSound;

// the locally spawned light
var Effect_InfraGlow InfraGlow;

var bool bTurnLightBackOn;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSetTacLight;
}

event AnimEnd(int Channel)
{
	/*if(bTurnLightBackOn) {
		TacLight.bLightOn = true;
		bTurnLightBackOn = false;
	}*/
	if(TacLight != None)
	   TacLight.TacLight.bIsAnimating = false;
}

function Tick(float Delta)
{
	if(TacLight != None && IsAnimating())
		TacLight.TacLight.bIsAnimating = true;
}

simulated function Fire(float F)
{
	/*if(TacLight.bLightOn) {
		TacLight.bLightOn = false;
		bTurnLightBackOn = true;
	}*/
}

simulated function AltFire(float F)
{
	SpecialFire();
}

simulated function SpecialFire()
{
	ServerSetTacLight();
	if (TacLightCorona == None)
	{
		TacLightCorona = spawn(class'Effect_TacLightCorona');
		AttachToBone(TacLightCorona,'bone_light');
		TacLightCorona.SetRelativeLocation(vect(0, 0, 0));
	}
	else
		TacLightCorona.Destroy();
}

function ServerSetTacLight(optional bool bForceDestroy)
{
	if (bForceDestroy)
	{
		if (TacLight != None)
		{
			TacLight.bLightOn = false;
			TacLight.Destroy();
		}
		return;
	}
	if (TacLight == None)
	{
		TacLight = Instigator.spawn(class'Effect_TacLightSpawner', None,, Instigator.Location + (vect(16, 0, 16) >> Instigator.Rotation), Instigator.Rotation);
		TacLight.LightPawn = Instigator;
		TacLight.bLightOn = true;
		TacLight.SetLight();
		TacLight.TacLight.parent = self;
	}
	else {
		TacLight.bLightOn = !TacLight.bLightOn;
		if(TacLight.bLightOn)
			TacLight.TacLight.AmbientLight.LightBrightness = TacLight.TacLight.AmbientLight.default.LightBrightness;
		else
			TacLight.TacLight.AmbientLight.LightBrightness = 0;
	}
}

simulated function SpawnGlow()
{
	local Pawn DynamicPawn;

	if (InfraGlow == None)
		InfraGlow = spawn(class'Effect_InfraGlow',Instigator,, Instigator.Location + (vect(16, 0, -5) >> Instigator.Rotation), Instigator.Rotation);

	foreach DynamicActors(class'Pawn',DynamicPawn)
	{
		DynamicPawn.AmbientGlow = 254;
		DynamicPawn.ScaleGlow = 10.0;
	}
}

simulated function Destroyed()
{
	local Pawn DynamicPawn;

	if (TacLight != None)
		TacLight.Destroy();
	if (TacLightCorona != None)
		TacLightCorona.Destroy();
	if (InfraGlow != None)
		InfraGlow.Destroy();
	foreach DynamicActors(class'Pawn',DynamicPawn)
	{
		if (Level.NetMode != NM_DedicatedServer)
		{
			DynamicPawn.AmbientGlow = DynamicPawn.Default.AmbientGlow;
			DynamicPawn.ScaleGlow = DynamicPawn.Default.ScaleGlow;
		}
	}
	Super.Destroyed();
}

simulated function bool PutDown()
{
	if (Instigator.Controller.IsA('PlayerController') && Instigator.IsLocallyControlled())
	{
		ServerSetTaclight(true);
		if (TacLightCorona != None)
			TacLightCorona.Destroy();
	}
	if (Super.PutDown())
	{
		return true;
	}
	return false;
}

defaultproperties
{
     AIRating=0.800000
     CurrentRating=0.800000
     bShowChargingBar=True
     bCanThrow=False
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=70.000000
     Priority=1
     DefaultPriority=1
     InventoryGroup=0
     //PlayerViewOffset=(X=2.5,Y=-7.5,Z=-5.0)
     //PlayerViewPivot(Yaw=0,Roll=0)
     BobDamping=1.700000
     Mesh=SkeletalMesh'AsylumWeapons.Flashlight'
     DrawScale=1.5;
     UV2Texture=Shader'XGameShaders.WeaponShaders.WeaponEnvShader'
     FireModeClass(0)=Class'AsylumGame.FlashlightFire'
     FireModeClass(1)=Class'AsylumGame.FlashlightAltFire'
     SelectSound=Sound'WeaponSounds.LinkGun.SwitchToLinkGun'
     SelectForce="SwitchToLinkGun"
     bMeleeWeapon=True
     bMatchWeapons=True
     PickupClass=Class'AsylumGame.FlashlightPickup'
     AttachmentClass=Class'AsylumGame.FlashlightAttachment'
     IconMaterial=Texture'AsylumTextures.HUD.Flashlight'
     IconCoords=(X1=200,Y1=190,X2=321,Y2=280)
     ItemName="Flashlight"
	 IdleAnim="flashlight_idle"
	 PutDownAnim="flashlight_putdown"
	 SelectAnim="flashlight_pickup"
	 bTurnLightBackOn=false
}
