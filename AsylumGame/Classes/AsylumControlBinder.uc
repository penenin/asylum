//==============================================================================
//
//       Class Name:  	AsylumControlBinder
//      Description:	
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
// Modified version of GUI2K4.ControlBinder
//==============================================================================

class AsylumControlBinder extends KeyBindMenu;

var localized string BindingLabel[150];

function LoadCommands()
{
	local int i;

	Super.LoadCommands();

	// Update the MultiColumnList's sortdata array to reflect the indexes of our Bindings array
    for (i = 0; i < Bindings.Length; i++)
    	li_Binds.AddedItem();
}

function MapBindings()
{
	LoadCustomBindings();
	Super.MapBindings();
}

protected function LoadCustomBindings()
{
	local int i;
	local array<string> KeyBindClasses;
    local class<GUIUserKeyBinding> CustomKeyBindClass;

    // Load custom keybinds from .int files
    PlayerOwner().GetAllInt("XInterface.GUIUserKeyBinding",KeyBindClasses);
	for (i = 0; i < KeyBindClasses.Length; i++)
	{
		CustomKeyBindClass = class<GUIUserKeyBinding>(DynamicLoadObject(KeyBindClasses[i],class'Class'));
		if (CustomKeyBindClass != None)
			AddCustomBindings( CustomKeyBindClass.default.KeyData );
    }
}

function AddCustomBindings( array<GUIUserKeyBinding.KeyInfo> KeyData )
{
	local int i;

	for ( i = 0; i < KeyData.Length; i++ )
		CreateAliasMapping( KeyData[i].Alias, KeyData[i].KeyLabel, KeyData[i].bIsSection );
}

function ClearBindings()
{
	local int i, max;

	Super.ClearBindings();
	Bindings = default.Bindings;
	max = Min(Bindings.Length, ArrayCount(BindingLabel));
	for ( i = 0; i < max; i++ )
	{
		if ( BindingLabel[i] != "" )
			Bindings[i].KeyLabel = BindingLabel[i];
	}
}

defaultproperties
{
     BindingLabel(0)="Movement"
	 BindingLabel(1)="Forward"
	 BindingLabel(2)="Backward"
	 BindingLabel(3)="Strafe Left"
	 BindingLabel(4)="Strafe Right"
	 BindingLabel(5)="Jump"
	 BindingLabel(6)="Run"
	 BindingLabel(7)="Crouch"
	 BindingLabel(8)="Strafe Toggle"
	 BindingLabel(9)="Looking"
	 BindingLabel(10)="Turn Left"
	 BindingLabel(11)="Turn Right"
	 BindingLabel(12)="Look Up"
	 BindingLabel(13)="Look Down"
	 BindingLabel(14)="Center View"
	 BindingLabel(15)="Inventory"
	 BindingLabel(16)="Fire"
	 BindingLabel(17)="Alt-Fire"
	 BindingLabel(18)="Item One"
	 BindingLabel(19)="Item Two"
	 BindingLabel(20)="Item Three"
	 BindingLabel(21)="Next Item"
	 BindingLabel(22)="Previous Item"
	 BindingLabel(23)="Pickup Item"
	 BindingLabel(24)="Drop Item"
	 BindingLabel(25)="Game"
	 BindingLabel(26)="Menu"
	 BindingLabel(27)="Pause"
	 BindingLabel(28)="Screenshot"
	 BindingLabel(29)="Quick Save"
	 BindingLabel(30)="Quick Load"
     Bindings(0)=(bIsSectionLabel=True,KeyLabel="Movement")
     Bindings(1)=(KeyLabel="Forward",Alias="MoveForward")
     Bindings(2)=(KeyLabel="Backward",Alias="MoveBackward")
     Bindings(3)=(KeyLabel="Strafe Left",Alias="StrafeLeft")
     Bindings(4)=(KeyLabel="Strafe Right",Alias="StrafeRight")
     Bindings(5)=(KeyLabel="Jump",Alias="Jump")
     Bindings(6)=(KeyLabel="Run",Alias="Walking")
     Bindings(7)=(KeyLabel="Crouch",Alias="Duck")
     Bindings(8)=(KeyLabel="Strafe Toggle",Alias="Strafe")
     Bindings(9)=(bIsSectionLabel=True,KeyLabel="Looking")
     Bindings(10)=(KeyLabel="Turn Left",Alias="TurnLeft")
     Bindings(11)=(KeyLabel="Turn Right",Alias="TurnRight")
     Bindings(12)=(KeyLabel="Look Up",Alias="LookUp")
     Bindings(13)=(KeyLabel="Look Down",Alias="LookDown")
     Bindings(14)=(KeyLabel="Center View",Alias="CenterView")
     Bindings(15)=(bIsSectionLabel=True,KeyLabel="Inventory")
     Bindings(16)=(KeyLabel="Fire",Alias="Fire")
     Bindings(17)=(KeyLabel="Alt-Fire",Alias="AltFire")
     Bindings(18)=(KeyLabel="Item One",Alias="SelectItemOne");
	 Bindings(19)=(KeyLabel="Item Two",Alias="SelectItemTwo");
	 Bindings(20)=(KeyLabel="Item Three",Alias="SelectItemThree");
	 Bindings(21)=(KeyLabel="Next Item",Alias="NextItem");
	 Bindings(22)=(KeyLabel="Previous Item",Alias="PrevItem");
	 Bindings(23)=(KeyLabel="Pickup Item",Alias="Use");
	 Bindings(24)=(KeyLabel="Drop Item",Alias="DropItem");
     Bindings(25)=(bIsSectionLabel=True,KeyLabel="Game")
	 Bindings(26)=(KeyLabel="Menu",Alias="ShowMenu")
     Bindings(27)=(KeyLabel="Pause",Alias="Pause")
     Bindings(28)=(KeyLabel="Screenshot",Alias="shot")
     Bindings(29)=(KeyLabel="Quick Save",Alias="QuickSave");
	 Bindings(30)=(KeyLabel="Quick Load",Alias="QuickLoad");
     Headings(0)="Action"
     PageCaption="Configure Keys"
}
