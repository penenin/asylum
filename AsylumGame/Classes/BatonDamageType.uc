//==============================================================================
//
//       Class Name:  	BatonDamageType
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class BatonDamageType extends WeaponDamageType;

defaultproperties
{
     WeaponClass=Class'asylumgame.Baton'
     DeathString="%k ripped a new hole in %o."
     FemaleSuicide="%o ended it all."
     MaleSuicide="%o ended it all."
     DamageWeaponName="Baton"
     bFastInstantHit=True
     SurfaceType=EST_Wood
     CollisionRadius=1.000000
     CollisionHeight=4.000000
     bCollideActors=True
     bUseCylinderCollision=True
     ForceType=FT_DragAlong
     ForceRadius=10.000000
     ForceNoise=0.750000
     bDirectional=True
}
