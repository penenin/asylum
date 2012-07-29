//==============================================================================
//
//       Class Name:  	InfiniteAmmo
//      Description:	An unlimited supply of munitions
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class InfiniteAmmo extends Ammunition;

//This function normally would subtract the amount of ammo used per shot
//but we want infinate ammo so we do nothing
function ProcessTraceHit(Weapon W, Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{

}

//We always have ammo
simulated function bool HasAmmo(){
          return true;
}

defaultproperties
{
     MaxAmmo=666
     InitialAmount=420
}
