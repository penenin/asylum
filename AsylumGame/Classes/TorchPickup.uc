//==============================================================================
//
//       Class Name:  	TorchPickup
//      Description:	Add the torch to our inventory
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class TorchPickup extends AsylumWeaponPickup;

function ChangeInventoryPicture(int itemNumber)
{
	switch(itemNumber) {
	case 1:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon1.WidgetTexture = Texture'AsylumTextures.HUD.TwoByFourFire';
		break;	
	case 2:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon2.WidgetTexture = Texture'AsylumTextures.HUD.TwoByFourFire';	
		break;
	case 3:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon3.WidgetTexture = Texture'AsylumTextures.HUD.TwoByFourFire';	
		break;
	}
	Super.ChangeInventoryPicture(itemNumber);
}

defaultproperties
{
     MaxDesireability=0.700000
     InventoryType=Class'asylumgame.Torch'
     PickupMessage="You got the Torch."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="TorchPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkGunPickup'
     DrawScale=0.750000
}
