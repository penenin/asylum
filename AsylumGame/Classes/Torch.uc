//==============================================================================
//
//       Class Name:  	Torch
//      Description:	A weapon
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class Torch extends AsylumWeapon;
var TorchEmitter FlameEmitter;
var name TipName;
simulated function BringUp(optional Weapon PrevWeapon){

	FlameEmitter = Spawn(class'TorchEmitter', self, , GetBoneCoords(TipName).origin, GetBoneRotation(TipName));
	AttachToBone(FlameEmitter, TipName);
}
simulated function PostBeginPlay()
{
	
	//SetPhysics(PHYS_Trailer);
	//FlameEmitter = Spawn(class'FireEmitter', self, , GetBoneCoords(TipName).origin, GetBoneRotation(TipName));
	//AttachToBone(FlameEmitter, TipName);
	Super.PostBeginPlay();
	
 
}
defaultproperties
{
	 TipName="bone_light"
     FireModeClass(0)=Class'asylumgame.TorchFire'
     FireModeClass(1)=Class'asylumgame.TorchFire'
     DrawScale=1.5;
     IdleAnimRate=0.030000
     SelectSound=Sound'WeaponSounds.LinkGun.SwitchToLinkGun'
     SelectForce="SwitchToLinkGun"
     AIRating=0.680000
     CurrentRating=0.680000
     bMeleeWeapon=True
     bMatchWeapons=True
     bCanThrow=False
     EffectOffset=(X=100.000000,Y=25.000000,Z=-3.000000)
     DisplayFOV=60.000000
     DefaultPriority=5
     InventoryGroup=5
     PickupClass=Class'asylumgame.TorchPickup'
     PlayerViewOffset=(X=0.000000,Y=-7.000000,Z=7.000000)
     //PlayerViewPivot=(Yaw=500)
     BobDamping=1.575000
     AttachmentClass=Class'asylumgame.TorchAttachment'
     IconMaterial=Texture'InterfaceContent.HUD.SkinA'
     IconCoords=(X1=200,Y1=190,X2=321,Y2=280)
     ItemName="Torch"
     Mesh=SkeletalMesh'AsylumWeapons.Flashlight'
     UV2Texture=Shader'XGameShaders.WeaponShaders.WeaponEnvShader'
     IdleAnim="flashlight_idle"
	 PutDownAnim="flashlight_putdown"
	 SelectAnim="flashlight_pickup"
}
