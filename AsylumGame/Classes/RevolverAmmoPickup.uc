//==============================================================================
//
//       Class Name:  	RevolverAmmoPickup
//      Description:	Put the bullets in our inventory
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class RevolverAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=20
     MaxDesireability=0.320000
     InventoryType=Class'asylumgame.RevolverAmmo'
     PickupMessage="You picked up some revolver shells"
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.BioAmmoPickup'
     CollisionHeight=8.250000
}
