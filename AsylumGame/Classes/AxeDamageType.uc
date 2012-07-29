//==============================================================================
//
//       Class Name:  	AxeDamageType
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class AxeDamageType extends WeaponDamageType;

defaultproperties
{
     WeaponClass=Class'AsylumGame.Axe'
     DeathString="%k ripped a new hole in %o."
     FemaleSuicide="%o ended it all."
     MaleSuicide="%o ended it all."
     DamageWeaponName="Axe"
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
