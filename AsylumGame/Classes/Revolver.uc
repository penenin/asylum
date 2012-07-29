//==============================================================================
//
//       Class Name:  	Revolver
//      Description:	A weapon
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class Revolver extends Weapon;

defaultproperties
{
     FireModeClass(0)=Class'asylumgame.RevolverFire'
     FireModeClass(1)=Class'asylumgame.RevolverFire'
     PutDownAnim="PutDown"
     IdleAnimRate=0.030000
     SelectSound=Sound'WeaponSounds.LinkGun.SwitchToLinkGun'
     SelectForce="SwitchToLinkGun"
     AIRating=0.680000
     CurrentRating=0.680000
     bMatchWeapons=True
     EffectOffset=(X=100.000000,Y=25.000000,Z=-3.000000)
     DisplayFOV=60.000000
     DefaultPriority=5
     InventoryGroup=5
     PickupClass=Class'asylumgame.RevolverPickup'
     PlayerViewOffset=(X=-2.000000,Y=-2.000000,Z=-3.000000)
     PlayerViewPivot=(Yaw=500)
     BobDamping=1.575000
     AttachmentClass=Class'asylumgame.RevolverAttachment'
     IconMaterial=Texture'InterfaceContent.HUD.SkinA'
     IconCoords=(X1=200,Y1=190,X2=321,Y2=280)
     ItemName="Revolver"
     Mesh=SkeletalMesh'Weapons.LinkGun_1st'
     UV2Texture=Shader'XGameShaders.WeaponShaders.WeaponEnvShader'
}
