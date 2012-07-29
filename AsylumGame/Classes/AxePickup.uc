//==============================================================================
//
//       Class Name:  	AxePickup
//      Description:  	Adds Baton to our inventory
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AxePickup extends AsylumWeaponPickup
	placeable;

#exec OBJ LOAD FILE="..\StaticMeshes\AsylumStaticMeshes.usx"

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
    Level.AddPrecacheStaticMesh(StaticMesh'AsylumStaticMeshes.Weapons.Axe');
}

defaultproperties
{
     MaxDesireability=0.700000
     InventoryType=Class'AsylumGame.Axe'
     PickupMessage="You got the Axe."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="AxePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'AsylumStaticMeshes.Weapons.Axe'
     DrawScale=0.750000
}
