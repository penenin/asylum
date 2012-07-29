//==============================================================================
//
//       Class Name:  	BatonFire
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class BatonFire extends DelayedInstantFire;
simulated function PlayHitSound(ESurfaceTypes Surface){
	
	switch(Surface){
		case EST_Default:
			break;
		case EST_Rock:
			break;
		case EST_Dirt:
			break;
		case EST_Metal:
			break;
		case EST_Wood:
			break;
		case EST_Plant:
			break;
		case EST_Flesh:
			Weapon.PlaySound(Sound'GeneralImpacts.Wet.Breakbone_01');
			break;
		case EST_Ice:
			break;
		case EST_Snow:
			break;
		case EST_Water:
			break;
		case EST_Glass:
			break;
		case EST_Custom00:
			break;
		case EST_Custom01:
			break;
		case EST_Custom02:
			break;
		case EST_Custom03:
			break;
		case EST_Custom04:
			break;
		case EST_Custom05:
			break;
		case EST_Custom06:
			break;
		case EST_Custom07:
			break;
		case EST_Custom08:
			break;
		case EST_Custom09:
			break;
		case EST_Custom10:
			break;
		case EST_Custom11:
			break;
		case EST_Custom12:
			break;
		case EST_Custom13:
			break;
		case EST_Custom14:
			break;
		case EST_Custom15:
			break;
		case EST_Custom16:
			break;
		case EST_Custom17:
			break;
		case EST_Custom18:
			break;
		case EST_Custom19:
			break;
		case EST_Custom20:
			break;
		case EST_Custom21:
			break;
		case EST_Custom22:
			break;
		case EST_Custom23:
			break;
		case EST_Custom24:
			break;
		case EST_Custom25:
			break;
		case EST_Custom26:
			break;
		case EST_Custom27:
			break;
		case EST_Custom28:
			break;
		case EST_Custom29:
			break;
		case EST_Custom30:
			break;
		case EST_Custom31:
			break;
		default:
			break;
	}
}
//simulated function PlayWallHitSound(){
//	Log("Playing Wall Hit Sound");
//	Log(AsylumWeapon(Weapon).GetWallSurfaceType());
//
//	PlayHitSound(AsylumWeapon(Weapon).GetWallSurfaceType());
	
//}
defaultproperties
{
     DamageMin=5
     DamageMax=10
     FireAnim=Attack
	 
     FireEndAnim=None
     FireRate=1.4
	
	 TimeBeforeTrace=0.5
	 DelayedFireSound = Sound'WeaponSounds.PGrenFloor1.P1GrenFloor1'
     TraceRange= 45.000000

     Momentum=20.000000
	 bInstantHit = True
	 AmmoPerFire=0
     AmmoClass=Class'AsylumGame.InfiniteAmmo'
	 DamageType=Class'SkaarjPack.MeleeDamage'
}
