//==============================================================================
//
//       Class Name:  	FlashlightPickup
//      Description:  	Adds the Flashlight to our inventory
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class FlashlightPickup extends AsylumWeaponPickup placeable;

#exec OBJ LOAD FILE="..\StaticMeshes\AsylumStaticMeshes.usx"

function ChangeInventoryPicture(int itemNumber)
{
	switch(itemNumber) {
	case 1:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon1.WidgetTexture = Texture'AsylumTextures.HUD.Flashlight';
		break;
	case 2:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon2.WidgetTexture = Texture'AsylumTextures.HUD.Flashlight';
		break;
	case 3:
		AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon3.WidgetTexture = Texture'AsylumTextures.HUD.Flashlight';
		break;
	}
	Super.ChangeInventoryPicture(itemNumber);
}

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'AsylumStaticMeshes.Weapons.Flashlight');
}

defaultproperties
{
     MaxDesireability=0.700000
     InventoryType=Class'AsylumGame.Flashlight'
     PickupMessage="You got the Flashlight."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="FlashlightPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'AsylumStaticMeshes.Weapons.Flashlight'
     DrawScale=0.750000
}
