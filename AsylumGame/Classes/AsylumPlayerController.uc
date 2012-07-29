//==============================================================================
//
//       Class Name:  	AsylumPlayerController
//      Description:  	The controller attached to the player's pawn
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumPlayerController extends xPlayer;

var int itemNumber;
var bool bInventoryUp;
var int numItems;
var Inventory Items[4];
var Effect_TacLightProjector flashlight;
var input byte bPickup;

// Hook in our interaction to process input
event InitInputSystem()
{
    super.InitInputSystem();
    Player.interactionMaster.AddInteraction("AsylumGame.AsylumInteraction", Player);
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	// Cannot actually call ClientSetMusic() here because
	// whatever object it accesses is not created yet
	Level.Song = "opening";
	SetTimer(64, true);
}

function Timer()
{
	ClientSetMusic( "constant", MTRAN_Fade );
}

function HandleWalking()
{
	if (Pawn != None) {
		if(bRun == 1)
			AsylumPlayerPawn(Pawn).StartRunning();
		else
			AsylumPlayerPawn(Pawn).StopRunning();
	}
}

exec function SelectItemOne()
{
	if(numItems == 0)
		return;
	bInventoryUp = true;
	AsylumHUD(myHUD).ShowInventory();
	AsylumHUD(myHUD).Weapon1.Tints[0].A = 255;
	AsylumHUD(myHUD).Weapon1.Tints[1].A = 255;
	itemNumber = 1;
}

exec function SelectItemTwo()
{
	if(numItems == 0)
		return;
	bInventoryUp = true;
	AsylumHUD(myHUD).ShowInventory();
	AsylumHUD(myHUD).Weapon2.Tints[0].A = 255;
	AsylumHUD(myHUD).Weapon2.Tints[1].A = 255;
	itemNumber = 2;
}

exec function SelectItemThree()
{
	if(numItems == 0)
		return;
	bInventoryUp = true;
	AsylumHUD(myHUD).ShowInventory();
	AsylumHUD(myHUD).Weapon3.Tints[0].A = 255;
	AsylumHUD(myHUD).Weapon3.Tints[1].A = 255;
	itemNumber = 3;
}

exec function NextItem()
{
	//Log("AsylumPlayerController(): exec NextItem");
	if(numItems == 0)
		return;

	// Look for the next occupied item slot
	do {
		itemNumber++;
		If(itemNumber > 3)
			itemNumber = 1;
	}until(Items[itemNumber] != None);

	// Highlight the item
	switch(itemNumber) {
	case 1:
		SelectItemOne();
		break;
	case 2:
		SelectItemTwo();
		break;
	case 3:
		SelectItemThree();
		break;
	}
}

exec function PrevItem()
{
	if(numItems == 0)
		return;

	// Look for the next occupied item slot
	do {
		itemNumber--;
		If(itemNumber < 1)
			itemNumber = 3;
	}until(Items[itemNumber] != None);

	// Highlight the item
	switch(itemNumber) {
	case 1:
		SelectItemOne();
		break;
	case 2:
		SelectItemTwo();
		break;
	case 3:
		SelectItemThree();
		break;
	}
}

exec function DropItem()
{
	switch(itemNumber) {
	case 1:
		AsylumHUD(myHUD).Weapon1.WidgetTexture = Texture'AsylumTextures.HUD.NoItem';
		break;
	case 2:
		AsylumHUD(myHUD).Weapon2.WidgetTexture = Texture'AsylumTextures.HUD.NoItem';
		break;
	case 3:
		AsylumHUD(myHUD).Weapon3.WidgetTexture = Texture'AsylumTextures.HUD.NoItem';
		break;
	}
	Items[itemNumber] = None;
	numItems--;
	bInventoryUp = false;
	AsylumHUD(myHUD).HideInventory();
}

// Find the first open inventory slot and return its index
function int GetOpenSlot()
{
	local int i;

	for(i = 1; i <= 3; i++) {
		if(Items[i] == None)
			return i;
	}
}

function SwitchToCurrentItem()
{
	ToggleLight();
    Pawn.Weapon = Weapon(Items[itemNumber]);
	Pawn.Weapon.Reselect();
	bInventoryUp = false;
	AsylumHUD(myHUD).HideInventory();
}

exec function ToggleLight()
{
	if(Pawn.Weapon != None && Pawn.Weapon.IsA('Flashlight'))
		Flashlight(Pawn.Weapon).SpecialFire();
}

defaultproperties
{
     PawnClass=Class'AsylumGame.AsylumPlayerPawn'
	 Items[0]=None
     Items[1]=None
     Items[2]=None
     Items[3]=None
	 numItems=0
}
