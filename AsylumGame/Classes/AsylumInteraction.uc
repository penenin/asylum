//==============================================================================
//
//       Class Name:  	InventoryInteraction
//      Description:	This class controls the display and operation of the
//			inventory based on player input
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class AsylumInteraction extends Interaction;

function Initialize()
{
}

// Process key stroke/mouse click
// Returning true from this function stops further processing of the key stroke
// Returning false passes the key event on to Unreal
function bool KeyEvent(EInputKey Key, EInputAction Action, FLOAT Delta)
{
	local bool bInventoryUp;

	bInventoryUp = AsylumPlayerController(ViewportOwner.Actor).bInventoryUp;
	if(!bInventoryUp)
		return false;
	else {
		if(Action == IST_Press) {
			if(Key == IK_LeftMouse) {
				AsylumHUD(ViewportOwner.Actor.myHUD).HideInventory();
				AsylumPlayerController(ViewportOwner.Actor).SwitchToCurrentItem();
				return true;
			}
		}
	}
}

defaultproperties
{
}