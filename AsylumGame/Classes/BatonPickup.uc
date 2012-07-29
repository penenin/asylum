//==============================================================================
//
//       Class Name:  	BatonPickup
//      Description:  	Adds Baton to our inventory
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class BatonPickup extends AsylumWeaponPickup placeable;

function ChangeInventoryPicture(int itemNumber)
{
	switch(itemNumber) {
	case 1:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon1.WidgetTexture = Texture'AsylumTextures.HUD.Baton';
		break;
	case 2:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon2.WidgetTexture = Texture'AsylumTextures.HUD.Baton';
		break;
	case 3:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon3.WidgetTexture = Texture'AsylumTextures.HUD.Baton';
		break;
	}
	Super.ChangeInventoryPicture(itemNumber);
}

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     MaxDesireability=0.700000
     InventoryType=Class'AsylumGame.Baton'
     PickupMessage="You got the Baton."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="BatonPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkGunPickup'
     DrawScale=0.750000
}
