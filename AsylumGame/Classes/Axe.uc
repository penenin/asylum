//==============================================================================
//
//       Class Name:  	Axe
//      Description:  	A weapon
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class Axe extends Weapon;

defaultproperties
{
	 
     
     IdleAnim=Idle
	 IdleAnimRate=0.30000
	 
     FireModeClass(0)=Class'AsylumGame.AxeFire'
     FireModeClass(1)=Class'AsylumGame.AxeFire'
     //PutDownAnim="PutDown"
     
     SelectSound=Sound'WeaponSounds.LinkGun.SwitchToLinkGun'
     SelectForce="SwitchToLinkGun"
     AIRating=0.680000
     CurrentRating=0.680000
     bMeleeWeapon=True
     bMatchWeapons=True
     bCanThrow=False
     
     EffectOffset=(X=20.000000,Y=-25.000000,Z=-12.000000)
     DisplayFOV=60.000000
     DefaultPriority=5
     InventoryGroup=5
     PickupClass=Class'AsylumGame.AxePickup'

     //Don't put spaces *anywhere* between the parenthesis'
     //+X moves it forward
     //+Z moves it up
     //+Y moves it right
     //PlayerViewOffset=(X=30.000000,Y=5.000000,Z=-10.000000)
     //PlayerViewPivot=(Yaw=-92000,Pitch=3000,Roll=15000)
     
     PlayerViewOffset=(X=0.000000,Y=0.000000,Z=-3.000000)
     PlayerViewPivot=(Yaw=2000,Pitch=0,Roll=0)
 

     BobDamping=3.0
     AttachmentClass=Class'AsylumGame.AxeAttachment'
     IconMaterial=Texture'InterfaceContent.HUD.SkinA'
     IconCoords=(X1=200,Y1=190,X2=321,Y2=280)
     ItemName="Axe"
     Mesh=SkeletalMesh'AsylumWeapons.Axe'
     UV2Texture=Shader'XGameShaders.WeaponShaders.WeaponEnvShader'
	 DrawScale=0.4
}
