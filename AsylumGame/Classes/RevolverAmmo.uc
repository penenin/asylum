//==============================================================================
//
//       Class Name:  	RevolverAmmo
//      Description:	Bullets for our revolver
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class RevolverAmmo extends Ammunition;

defaultproperties
{
     MaxAmmo=50
     InitialAmount=20
     PickupClass=Class'asylumgame.RevolverAmmoPickup'
     IconMaterial=Texture'InterfaceContent.HUD.SkinA'
     IconCoords=(X1=545,Y1=75,X2=644,Y2=149)
     ItemName="Revolver Bullets"
}
