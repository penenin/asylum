//==============================================================================
//
//       Class Name:  	RevolverPickup
//      Description:	Put the revolver in our inventory
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class RevolverPickup extends AsylumWeaponPickup;

function ChangeInventoryPicture(int itemNumber)
{
	switch(itemNumber) {
	case 1:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon1.WidgetTexture = Texture'AsylumTextures.HUD.Revolver';
		break;	
	case 2:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon2.WidgetTexture = Texture'AsylumTextures.HUD.Revolver';	
		break;
	case 3:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon3.WidgetTexture = Texture'AsylumTextures.HUD.Revolver';	
		break;
	}
	Super.ChangeInventoryPicture(itemNumber);
}

defaultproperties
{
     MaxDesireability=0.700000
     InventoryType=Class'asylumgame.Revolver'
     PickupMessage="You got the Revolver."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="RevolverPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkGunPickup'
     DrawScale=0.750000
}
