//==============================================================================
//
//       Class Name:  	Baton
//      Description:  	A weapon
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class Baton extends AsylumWeapon;

/*
event HitWall( vector HitNormal, actor HitWall ){
	Log("Player hit a wall");
}
event Bump( Actor Other ){
	Log("Baton bumped something.");
}

event Touch( Actor Other ){
	Log("Baton touched something.");
	Log(Other.Name);
	Log(Other.Texture);
	Log(Other.Texture.SurfaceType);
	Log(Other.SurfaceType);
}
event EncroachedBy( Actor Other ){
	Log("Baton encroached by something");
	Log(Other.Name);
}
event bool EncroachingOn( actor Other ){
	//Log("Baton Encroached something");
	//Log(Other.Name);
	//Log(Other.Texture);
	//Log(Other.Texture.SurfaceType);
	//Log(Other.SurfaceType);
	return true;	

}
*/
defaultproperties
{
     bCollideActors=true
     FireModeClass(0)=Class'asylumgame.BatonFire'
     FireModeClass(1)=Class'asylumgame.BatonAltFire'
     
     IdleAnim=Idle
     IdleAnimRate=0.30000
     
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
     PickupClass=Class'asylumgame.BatonPickup'
     //Don't put spaces *anywhere* between the parenthesis'
     //+X moves it forward
     //+Z moves it up
     //+Y moves it right
     PlayerViewOffset=(X=2.000000,Y=-2.000000,Z=2.000000)
     PlayerViewPivot=(Yaw=0,Pitch=0,Roll=0)
     BobDamping=3.0
     AttachmentClass=Class'asylumgame.BatonAttachment'
     IconMaterial=Texture'InterfaceContent.HUD.SkinA'
     IconCoords=(X1=200,Y1=190,X2=321,Y2=280)
     ItemName="Baton"
     Mesh=SkeletalMesh'AsylumWeapons.Baton'
     UV2Texture=Shader'XGameShaders.WeaponShaders.WeaponEnvShader'

}
