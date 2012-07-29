//==============================================================================
//
//       Class Name:  	AsylumWeaponPickup
//      Description:  	Base class for all weapon pickups
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumWeaponPickup extends UTWeaponPickup;

// Items should not respond so I destroy myself
function SetRespawn()
{
	Destroy();
}

// Show the inventory on the HUD and make the selected item brighter
function HighlightItemOne()
{
	AsylumHUD(Level.GetLocalPlayerController().myHUD).ShowInventory();
	AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon1.Tints[0].A = 255;
	AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon1.Tints[1].A = 255;
}

function HighlightItemTwo()
{
	AsylumHUD(Level.GetLocalPlayerController().myHUD).ShowInventory();
	AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon2.Tints[0].A = 255;
	AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon2.Tints[1].A = 255;
}

function HighlightItemThree()
{
	AsylumHUD(Level.GetLocalPlayerController().myHUD).ShowInventory();
	AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon3.Tints[0].A = 255;
	AsylumHUD(Level.GetLocalPlayerController().myHUD).Weapon3.Tints[1].A = 255;
}

function ChangeInventoryPicture(int itemNumber)
{
	switch(itemNumber) {
	case 1:
		HighlightItemOne();
		break;
	case 2:
		HighlightItemTwo();
		break;
	case 3:
		HighlightItemThree();
		break;
	}
	AsylumHUD(Level.GetLocalPlayerController().myHUD).HideInventory();
}

// Modified from state Pickup in Engine.Pickup
auto state Pickup
{
    function bool ReadyToPickup(float MaxWait)
    {
        return true;
    }

    function Touch( actor Other )
    {
        local Inventory Copy;
		local int OpenSlot;

        if(AsylumPlayerController(Pawn(Other).Controller).bPickup != 0)
            Pawn(Other).bCanPickupInventory = true;

        // If touched by a player pawn, let him pick this up.
        if(ValidTouch(Other))
        {
            Copy = SpawnCopy(Pawn(Other));
            AnnouncePickup(Pawn(Other));
            SetRespawn();
            if ( Copy != None ) {
				Copy.PickupFunction(Pawn(Other));
				AsylumPlayerController(Pawn(Other).Controller).numItems++;
				OpenSlot = AsylumPlayerController(Pawn(Other).Controller).GetOpenSlot();
				AsylumPlayerController(Pawn(Other).Controller).Items[OpenSlot] = Copy;
	    		ChangeInventoryPicture(OpenSlot);
			}
		}
	   Pawn(Other).bCanPickupInventory = false;
    }

function bool ValidTouch( actor Other )
{
	if(!Other.IsA('AsylumPlayerPawn'))
		return false;

	// The player can only hold 3 items at a time
	if(AsylumPlayerController(Pawn(Other).Controller).numItems >= 3)
		return false;

	if(Pawn(Other).bCanPickupInventory == false)
	   return false;


    // make sure not touching through wall
    if ( !FastTrace(Other.Location, Location) )
        return false;

    TriggerEvent(Event, self, Pawn(Other));
    return true;
}

    // Make sure no pawn already touching (while touch was disabled in sleep).
    function CheckTouching()
    {
        local Pawn P;

        ForEach TouchingActors(class'Pawn', P)
            Touch(P);
    }

    function Timer()
    {
        if ( bDropped )
            GotoState('FadeOut');
    }

    function Tick(float Delta)
    {
        CheckTouching();
    }

    function BeginState()
    {
        if ( bDropped )
        {
            AddToNavigation();
            SetTimer(8, false);
        }
    }

    function EndState()
    {
        if ( bDropped )
            RemoveFromNavigation();
    }

Begin:
    CheckTouching();
}

defaultproperties
{
	RotationRate=(Yaw=0)
	DesiredRotation=(Yaw=0)
}
