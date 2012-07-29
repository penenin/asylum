//==============================================================================
//
//       Class Name:  	AsylumHUD
//      Description:  	HUD Definition
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumHUD extends HudBase;

#exec OBJ LOAD FILE="..\Textures\AsylumHeartbeat.utx"
#exec OBJ LOAD FILE="..\Textures\AsylumTextures.utx"

struct Frameset {
	var Texture frame[73];
};

var() SpriteWidget HeartMonitor;
var() SpriteWidget Heartbeat;
var() SpriteWidget Weapon1;
var() SpriteWidget Weapon2;
var() SpriteWidget Weapon3;
var() SpriteWidget StaminaFull;
var() SpriteWidget StaminaEmpty;
var float StaminaBarLevel;
var int set;
var int frame;
var float seconds;
var Frameset beatFrames[10];
var bool bDoHideInventory;
var bool bFadeStaminaBar;
var bool bDisplayPickupMessage;

simulated function UpdateHud();

function DrawHud(Canvas c)
{
	super.DrawHud(c);
	DrawSpriteWidget (c, HeartMonitor);
	DrawSpriteWidget (c, Heartbeat);
	DrawSpriteWidget (c, Weapon1);
	DrawSpriteWidget (c, Weapon2);
	DrawSpriteWidget (c, Weapon3);
	DrawSpriteWidget (c, StaminaFull);
	DrawSpriteWidget (c, StaminaEmpty);
	// FIXME : doesn't seem to work
	if(bDisplayPickupMessage)
	   c.DrawText("Press the \"Pickup\" key to pick up this item.");
}

// Empty function surpresses console messages
function DisplayMessages(Canvas c)
{
}

function ShowPickupMessage()
{
    bDisplayPickupMessage = true;
}

function HidePickupMessage()
{
    bDisplayPickupMessage = false;
}

// Make the inventory visible
function ShowInventory()
{
		bDoHideInventory = false;
		Weapon1.Tints[0].A = 153;
		Weapon1.Tints[1].A = 153;
		Weapon2.Tints[0].A = 153;
		Weapon2.Tints[1].A = 153;
		Weapon3.Tints[0].A = 153;
		Weapon3.Tints[1].A = 153;
}

// Make inventory fade away
function HideInventory()
{
	bDoHideInventory = true;
}

function UpdateStaminaBar()
{
	StaminaFull.TextureCoords.Y2=StaminaBarLevel;
}

function ShowStaminaBar()
{
	StaminaFull.Tints[0].A = 255;
	StaminaFull.Tints[1].A = 255;
	StaminaEmpty.Tints[0].A = 255;
	StaminaEmpty.Tints[1].A = 255;
}

function FadeStaminaBar()
{
	if(StaminaFull.Tints[0].A > 0) {
		StaminaFull.Tints[0].A -= 5;
	}
	if(StaminaFull.Tints[1].A > 0) {
		StaminaFull.Tints[1].A -= 5;
	}

	if(StaminaEmpty.Tints[0].A > 0) {
		StaminaEmpty.Tints[0].A -= 5;
	}
	if(StaminaEmpty.Tints[1].A > 0) {
		StaminaEmpty.Tints[1].A -= 5;
	}

	if(StaminaFull.Tints[0].A == 0 &&
	   StaminaFull.Tints[1].A == 0 &&
	   StaminaEmpty.Tints[0].A == 0 &&
           StaminaEmpty.Tints[1].A == 0) {
		bFadeStaminaBar = false;
	}


}

// Fade the item icons
function DoHideInventory()
{
	if(Weapon1.Tints[0].A > 0) {
		Weapon1.Tints[0].A -= 5;
		if(Weapon1.Tints[0].A > 250) {
			Weapon1.Tints[0].A = 0;
		}
	}
	if(Weapon1.Tints[1].A > 0) {
		Weapon1.Tints[1].A -= 5;
		if(Weapon1.Tints[1].A > 250) {
			Weapon1.Tints[1].A = 0;
		}
	}
	if(Weapon2.Tints[0].A > 0) {
		Weapon2.Tints[0].A -= 5;
		if(Weapon2.Tints[0].A > 250) {
			Weapon2.Tints[0].A = 0;
		}
	}
	if(Weapon2.Tints[1].A > 0) {
		Weapon2.Tints[1].A -= 5;
		if(Weapon2.Tints[1].A > 250) {
			Weapon2.Tints[1].A = 0;
		}
	}
	if(Weapon3.Tints[0].A > 0) {
		Weapon3.Tints[0].A -= 5;
		if(Weapon3.Tints[0].A > 250) {
			Weapon3.Tints[0].A = 0;
		}
	}
	if(Weapon3.Tints[1].A > 0) {
		Weapon3.Tints[1].A -= 5;
		if(Weapon3.Tints[1].A > 250) {
			Weapon3.Tints[1].A = 0;
		}
	}

	if(Weapon1.Tints[0].A == 0 &&
		Weapon1.Tints[1].A == 0 &&
		Weapon2.Tints[0].A == 0 &&
		Weapon2.Tints[1].A == 0 &&
		Weapon3.Tints[0].A == 0 &&
		Weapon3.Tints[1].A == 0) {
			bDoHideInventory = false;
	}

}

// Called whenever time passes.
function Tick( float DeltaTime )
{
	// Needed for damage indicators to fade away
	super.Tick(DeltaTime);

	// If I am hiding the inventory, reduce the items' alpha channel by 5
	// every 1/30th of a second
	if(bDoHideInventory)
		if((Level.TimeSeconds - seconds) >= (1.0 / 30.0))
			DoHideInventory();

	UpdateStaminaBar();

	if(bFadeStaminaBar)
		if((Level.TimeSeconds - seconds) >= (1.0 / 30.0))
			FadeStaminaBar();

	// Select which heartbeat to display based on the player's health
	if(PawnOwner != None) {
		if(PawnOwner.Health == 100) {
			set = 0;
		}
		else if(PawnOwner.Health <= 99 && PawnOwner.Health >= 90) {
			set = 1;
		}
		else if(PawnOwner.Health <= 89 && PawnOwner.Health >= 80) {
			set = 2;
		}
		else if(PawnOwner.Health <= 79 && PawnOwner.Health >= 70) {
			set = 3;
		}
		else if(PawnOwner.Health <= 69 && PawnOwner.Health >= 60) {
			set = 4;
		}
		else if(PawnOwner.Health <= 59 && PawnOwner.Health >= 50) {
			set = 5;
		}
		else if(PawnOwner.Health <= 49 && PawnOwner.Health >= 40) {
			set = 6;
		}
		else if(PawnOwner.Health <= 39 && PawnOwner.Health >= 30) {
			set = 7;
		}
		else if(PawnOwner.Health <= 29 && PawnOwner.Health > 0) {
			set = 8;
		}
		else { // PawnOwner.Health == 0
			set = 9;
			ScoreBoard = None;
		}
	}

	// Every 1/30th of a second, display the next frame in the animation
	// If we have reached the end, loop
	if((Level.TimeSeconds - seconds) >= (1.0 / 30.0)) {
		seconds = Level.TimeSeconds;
		frame++;
		if((set == 0 && frame > 38) ||
		   (set == 1 && frame > 44) ||
		   (set == 2 && frame > 49) ||
		   (set == 3 && frame > 55) ||
		   (set == 4 && frame > 60) ||
		   (set == 5 && frame > 66) ||
		   (set == 6 && frame > 69) ||
		   (set == 7 && frame > 72) ||
		   (set == 8 && frame > 68) ||
		   (set == 9 && frame > 35)) {
			frame = 0;
		}
		Heartbeat.WidgetTexture = beatFrames[set].frame[frame];
	}
}

simulated function UpdatePrecacheMaterials()
{
    Super.UpdatePrecacheMaterials();
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.A.beat0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.B.beatB0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.C.beatC0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0050');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0051');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0052');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0053');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0054');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.D.beatD0055');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0050');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0051');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0052');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0053');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0054');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0055');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0056');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0057');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0058');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0059');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.E.beatE0060');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0050');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0051');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0052');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0053');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0054');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0055');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0056');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0057');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0058');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0059');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0060');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0061');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0062');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0063');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0064');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0065');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.F.beatF0066');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0050');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0051');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0052');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0053');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0054');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0055');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0056');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0057');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0058');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0059');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0060');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0061');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0062');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0063');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0064');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0065');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0066');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0067');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0068');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.G.beatG0069');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0050');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0051');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0052');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0053');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0054');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0055');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0056');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0057');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0058');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0059');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0060');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0061');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0062');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0063');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0064');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0065');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0066');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0067');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0068');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0069');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0070');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0071');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.H.beatH0072');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0035');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0036');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0037');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0038');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0039');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0040');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0041');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0042');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0043');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0044');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0045');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0046');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0047');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0048');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0049');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0050');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0051');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0052');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0053');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0054');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0055');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0056');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0057');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0058');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0059');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0060');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0061');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0062');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0063');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0064');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0065');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0066');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0067');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.i.beatI0068');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0000');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0001');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0002');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0003');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0004');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0005');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0006');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0007');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0008');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0009');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0010');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0011');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0012');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0013');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0014');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0015');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0016');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0017');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0018');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0019');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0020');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0021');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0022');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0023');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0024');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0025');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0026');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0027');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0028');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0029');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0030');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0031');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0032');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0033');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0034');
    Level.AddPrecacheMaterial(Texture'AsylumHeartbeat.j.beatJ0035');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.Baton');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.BroomHandle');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.Flashlight');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.GlassShard');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.HeartMonitor');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.LeadPipe');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.NoItem');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.Revolver');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.Shotgun');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.staminaempty');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.staminafull');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.TwoByFour');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.TwoByFourFire');
    Level.AddPrecacheMaterial(Texture'AsylumTextures.HUD.Wrench');
}

defaultproperties
{
     StaminaBarLevel=127
     bDoHideInventory=false
     bFadeStaminaBar=false
     HeartMonitor=(WidgetTexture=Texture'AsylumTextures.HUD.HeartMonitor',RenderStyle=STY_Alpha,TextureCoords=(Y1=120,X2=255,Y2=255),TextureScale=0.4,DrawPivot=DP_UpperMiddle,PosX=0.085,PosY=0.88,ScaleMode=SM_Right,Scale=1,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     Heartbeat=(WidgetTexture=Texture'AsylumHeartbeat.A.beat0001',RenderStyle=STY_Alpha,TextureCoords=(X1=5,X2=242,Y2=255),TextureScale=0.4,DrawPivot=DP_UpperMiddle,PosX=0.085,PosY=0.825,ScaleMode=SM_Right,Scale=1,Tints[0]=(G=255,A=150),Tints[1]=(G=255,A=150))
     Weapon1=(WidgetTexture=Texture'AsylumTextures.HUD.NoItem',RenderStyle=STY_Alpha,TextureCoords=(Y1=120,X2=255,Y2=255),TextureScale=0.3,DrawPivot=DP_UpperMiddle,PosX=0.68,PosY=0.91,Tints[0]=(B=255,G=255,R=255,A=0),Tints[1]=(B=255,G=255,R=255,A=0))
     Weapon2=(WidgetTexture=Texture'AsylumTextures.HUD.NoItem',RenderStyle=STY_Alpha,TextureCoords=(Y1=120,X2=255,Y2=255),TextureScale=0.3,DrawPivot=DP_UpperMiddle,PosX=0.81,PosY=0.91,Tints[0]=(B=255,G=255,R=255,A=0),Tints[1]=(B=255,G=255,R=255,A=0))
     Weapon3=(WidgetTexture=Texture'AsylumTextures.HUD.NoItem',RenderStyle=STY_Alpha,TextureCoords=(Y1=120,X2=255,Y2=255),TextureScale=1.0,DrawPivot=DP_UpperMiddle,PosX=0.94,PosY=0.91,Tints[0]=(B=255,G=255,R=255,A=0),Tints[1]=(B=255,G=255,R=255,A=0))
     StaminaFull=(WidgetTexture=Texture'AsylumTextures.HUD.StaminaFull',RenderStyle=STY_Alpha,TextureCoords=(x1=61,Y1=0,X2=70,Y2=127),TextureScale=0.40,DrawPivot=DP_LowerLeft,PosX=0.176,PosY=0.988,ScaleMode=SM_Right,Scale=1,Tints[0]=(B=255,G=255,R=255,A=0),Tints[1]=(B=255,G=255,R=255,A=0))
     StaminaEmpty=(WidgetTexture=Texture'AsylumTextures.HUD.StaminaEmpty',RenderStyle=STY_Alpha,TextureCoords=(x1=58,Y1=0,X2=73,Y2=127),TextureScale=0.40,DrawPivot=DP_LowerLeft,PosX=0.175,PosY=0.988,ScaleMode=SM_Right,Scale=1,Tints[0]=(B=255,G=255,R=255,A=0),Tints[1]=(B=255,G=255,R=255,A=0))
     beatFrames(0)=(frame[0]=Texture'AsylumHeartbeat.A.beat0000',frame[1]=Texture'AsylumHeartbeat.A.beat0001',frame[2]=Texture'AsylumHeartbeat.A.beat0002',frame[3]=Texture'AsylumHeartbeat.A.beat0003',frame[4]=Texture'AsylumHeartbeat.A.beat0004',frame[5]=Texture'AsylumHeartbeat.A.beat0005',frame[6]=Texture'AsylumHeartbeat.A.beat0006',frame[7]=Texture'AsylumHeartbeat.A.beat0007',frame[8]=Texture'AsylumHeartbeat.A.beat0008',frame[9]=Texture'AsylumHeartbeat.A.beat0009',frame[10]=Texture'AsylumHeartbeat.A.beat0010',frame[11]=Texture'AsylumHeartbeat.A.beat0011',frame[12]=Texture'AsylumHeartbeat.A.beat0012',frame[13]=Texture'AsylumHeartbeat.A.beat0013',frame[14]=Texture'AsylumHeartbeat.A.beat0014',frame[15]=Texture'AsylumHeartbeat.A.beat0015',frame[16]=Texture'AsylumHeartbeat.A.beat0016',frame[17]=Texture'AsylumHeartbeat.A.beat0017',frame[18]=Texture'AsylumHeartbeat.A.beat0018',frame[19]=Texture'AsylumHeartbeat.A.beat0019',frame[20]=Texture'AsylumHeartbeat.A.beat0020',frame[21]=Texture'AsylumHeartbeat.A.beat0021',frame[22]=Texture'AsylumHeartbeat.A.beat0022',frame[23]=Texture'AsylumHeartbeat.A.beat0023',frame[24]=Texture'AsylumHeartbeat.A.beat0024',frame[25]=Texture'AsylumHeartbeat.A.beat0025',frame[26]=Texture'AsylumHeartbeat.A.beat0026',frame[27]=Texture'AsylumHeartbeat.A.beat0027',frame[28]=Texture'AsylumHeartbeat.A.beat0028',frame[29]=Texture'AsylumHeartbeat.A.beat0029',frame[30]=Texture'AsylumHeartbeat.A.beat0030',frame[31]=Texture'AsylumHeartbeat.A.beat0031',frame[32]=Texture'AsylumHeartbeat.A.beat0032',frame[33]=Texture'AsylumHeartbeat.A.beat0033',frame[34]=Texture'AsylumHeartbeat.A.beat0034',frame[35]=Texture'AsylumHeartbeat.A.beat0035',frame[36]=Texture'AsylumHeartbeat.A.beat0036',frame[37]=Texture'AsylumHeartbeat.A.beat0037',frame[38]=Texture'AsylumHeartbeat.A.beat0038')
     beatFrames(1)=(frame[0]=Texture'AsylumHeartbeat.B.beatB0000',frame[1]=Texture'AsylumHeartbeat.B.beatB0001',frame[2]=Texture'AsylumHeartbeat.B.beatB0002',frame[3]=Texture'AsylumHeartbeat.B.beatB0003',frame[4]=Texture'AsylumHeartbeat.B.beatB0004',frame[5]=Texture'AsylumHeartbeat.B.beatB0005',frame[6]=Texture'AsylumHeartbeat.B.beatB0006',frame[7]=Texture'AsylumHeartbeat.B.beatB0007',frame[8]=Texture'AsylumHeartbeat.B.beatB0008',frame[9]=Texture'AsylumHeartbeat.B.beatB0009',frame[10]=Texture'AsylumHeartbeat.B.beatB0010',frame[11]=Texture'AsylumHeartbeat.B.beatB0011',frame[12]=Texture'AsylumHeartbeat.B.beatB0012',frame[13]=Texture'AsylumHeartbeat.B.beatB0013',frame[14]=Texture'AsylumHeartbeat.B.beatB0014',frame[15]=Texture'AsylumHeartbeat.B.beatB0015',frame[16]=Texture'AsylumHeartbeat.B.beatB0016',frame[17]=Texture'AsylumHeartbeat.B.beatB0017',frame[18]=Texture'AsylumHeartbeat.B.beatB0018',frame[19]=Texture'AsylumHeartbeat.B.beatB0019',frame[20]=Texture'AsylumHeartbeat.B.beatB0020',frame[21]=Texture'AsylumHeartbeat.B.beatB0021',frame[22]=Texture'AsylumHeartbeat.B.beatB0022',frame[23]=Texture'AsylumHeartbeat.B.beatB0023',frame[24]=Texture'AsylumHeartbeat.B.beatB0024',frame[25]=Texture'AsylumHeartbeat.B.beatB0025',frame[26]=Texture'AsylumHeartbeat.B.beatB0026',frame[27]=Texture'AsylumHeartbeat.B.beatB0027',frame[28]=Texture'AsylumHeartbeat.B.beatB0028',frame[29]=Texture'AsylumHeartbeat.B.beatB0029',frame[30]=Texture'AsylumHeartbeat.B.beatB0030',frame[31]=Texture'AsylumHeartbeat.B.beatB0031',frame[32]=Texture'AsylumHeartbeat.B.beatB0032',frame[33]=Texture'AsylumHeartbeat.B.beatB0033',frame[34]=Texture'AsylumHeartbeat.B.beatB0034',frame[35]=Texture'AsylumHeartbeat.B.beatB0035',frame[36]=Texture'AsylumHeartbeat.B.beatB0036',frame[37]=Texture'AsylumHeartbeat.B.beatB0037',frame[38]=Texture'AsylumHeartbeat.B.beatB0038',frame[39]=Texture'AsylumHeartbeat.B.beatB0039',frame[40]=Texture'AsylumHeartbeat.B.beatB0040',frame[41]=Texture'AsylumHeartbeat.B.beatB0041',frame[42]=Texture'AsylumHeartbeat.B.beatB0042',frame[43]=Texture'AsylumHeartbeat.B.beatB0043',frame[44]=Texture'AsylumHeartbeat.B.beatB0044')
     beatFrames(2)=(frame[0]=Texture'AsylumHeartbeat.C.beatC0000',frame[1]=Texture'AsylumHeartbeat.C.beatC0001',frame[2]=Texture'AsylumHeartbeat.C.beatC0002',frame[3]=Texture'AsylumHeartbeat.C.beatC0003',frame[4]=Texture'AsylumHeartbeat.C.beatC0004',frame[5]=Texture'AsylumHeartbeat.C.beatC0005',frame[6]=Texture'AsylumHeartbeat.C.beatC0006',frame[7]=Texture'AsylumHeartbeat.C.beatC0007',frame[8]=Texture'AsylumHeartbeat.C.beatC0008',frame[9]=Texture'AsylumHeartbeat.C.beatC0009',frame[10]=Texture'AsylumHeartbeat.C.beatC0010',frame[11]=Texture'AsylumHeartbeat.C.beatC0011',frame[12]=Texture'AsylumHeartbeat.C.beatC0012',frame[13]=Texture'AsylumHeartbeat.C.beatC0013',frame[14]=Texture'AsylumHeartbeat.C.beatC0014',frame[15]=Texture'AsylumHeartbeat.C.beatC0015',frame[16]=Texture'AsylumHeartbeat.C.beatC0016',frame[17]=Texture'AsylumHeartbeat.C.beatC0017',frame[18]=Texture'AsylumHeartbeat.C.beatC0018',frame[19]=Texture'AsylumHeartbeat.C.beatC0019',frame[20]=Texture'AsylumHeartbeat.C.beatC0020',frame[21]=Texture'AsylumHeartbeat.C.beatC0021',frame[22]=Texture'AsylumHeartbeat.C.beatC0022',frame[23]=Texture'AsylumHeartbeat.C.beatC0023',frame[24]=Texture'AsylumHeartbeat.C.beatC0024',frame[25]=Texture'AsylumHeartbeat.C.beatC0025',frame[26]=Texture'AsylumHeartbeat.C.beatC0026',frame[27]=Texture'AsylumHeartbeat.C.beatC0027',frame[28]=Texture'AsylumHeartbeat.C.beatC0028',frame[29]=Texture'AsylumHeartbeat.C.beatC0029',frame[30]=Texture'AsylumHeartbeat.C.beatC0030',frame[31]=Texture'AsylumHeartbeat.C.beatC0031',frame[32]=Texture'AsylumHeartbeat.C.beatC0032',frame[33]=Texture'AsylumHeartbeat.C.beatC0033',frame[34]=Texture'AsylumHeartbeat.C.beatC0034',frame[35]=Texture'AsylumHeartbeat.C.beatC0035',frame[36]=Texture'AsylumHeartbeat.C.beatC0036',frame[37]=Texture'AsylumHeartbeat.C.beatC0037',frame[38]=Texture'AsylumHeartbeat.C.beatC0038',frame[39]=Texture'AsylumHeartbeat.C.beatC0039',frame[40]=Texture'AsylumHeartbeat.C.beatC0040',frame[41]=Texture'AsylumHeartbeat.C.beatC0041',frame[42]=Texture'AsylumHeartbeat.C.beatC0042',frame[43]=Texture'AsylumHeartbeat.C.beatC0043',frame[44]=Texture'AsylumHeartbeat.C.beatC0044',frame[45]=Texture'AsylumHeartbeat.C.beatC0045',frame[46]=Texture'AsylumHeartbeat.C.beatC0046',frame[47]=Texture'AsylumHeartbeat.C.beatC0047',frame[48]=Texture'AsylumHeartbeat.C.beatC0048',frame[49]=Texture'AsylumHeartbeat.C.beatC0049')
     beatFrames(3)=(frame[0]=Texture'AsylumHeartbeat.D.beatD0000',frame[1]=Texture'AsylumHeartbeat.D.beatD0001',frame[2]=Texture'AsylumHeartbeat.D.beatD0002',frame[3]=Texture'AsylumHeartbeat.D.beatD0003',frame[4]=Texture'AsylumHeartbeat.D.beatD0004',frame[5]=Texture'AsylumHeartbeat.D.beatD0005',frame[6]=Texture'AsylumHeartbeat.D.beatD0006',frame[7]=Texture'AsylumHeartbeat.D.beatD0007',frame[8]=Texture'AsylumHeartbeat.D.beatD0008',frame[9]=Texture'AsylumHeartbeat.D.beatD0009',frame[10]=Texture'AsylumHeartbeat.D.beatD0010',frame[11]=Texture'AsylumHeartbeat.D.beatD0011',frame[12]=Texture'AsylumHeartbeat.D.beatD0012',frame[13]=Texture'AsylumHeartbeat.D.beatD0013',frame[14]=Texture'AsylumHeartbeat.D.beatD0014',frame[15]=Texture'AsylumHeartbeat.D.beatD0015',frame[16]=Texture'AsylumHeartbeat.D.beatD0016',frame[17]=Texture'AsylumHeartbeat.D.beatD0017',frame[18]=Texture'AsylumHeartbeat.D.beatD0018',frame[19]=Texture'AsylumHeartbeat.D.beatD0019',frame[20]=Texture'AsylumHeartbeat.D.beatD0020',frame[21]=Texture'AsylumHeartbeat.D.beatD0021',frame[22]=Texture'AsylumHeartbeat.D.beatD0022',frame[23]=Texture'AsylumHeartbeat.D.beatD0023',frame[24]=Texture'AsylumHeartbeat.D.beatD0024',frame[25]=Texture'AsylumHeartbeat.D.beatD0025',frame[26]=Texture'AsylumHeartbeat.D.beatD0026',frame[27]=Texture'AsylumHeartbeat.D.beatD0027',frame[28]=Texture'AsylumHeartbeat.D.beatD0028',frame[29]=Texture'AsylumHeartbeat.D.beatD0029',frame[30]=Texture'AsylumHeartbeat.D.beatD0030',frame[31]=Texture'AsylumHeartbeat.D.beatD0031',frame[32]=Texture'AsylumHeartbeat.D.beatD0032',frame[33]=Texture'AsylumHeartbeat.D.beatD0033',frame[34]=Texture'AsylumHeartbeat.D.beatD0034',frame[35]=Texture'AsylumHeartbeat.D.beatD0035',frame[36]=Texture'AsylumHeartbeat.D.beatD0036',frame[37]=Texture'AsylumHeartbeat.D.beatD0037',frame[38]=Texture'AsylumHeartbeat.D.beatD0038',frame[39]=Texture'AsylumHeartbeat.D.beatD0039',frame[40]=Texture'AsylumHeartbeat.D.beatD0040',frame[41]=Texture'AsylumHeartbeat.D.beatD0041',frame[42]=Texture'AsylumHeartbeat.D.beatD0042',frame[43]=Texture'AsylumHeartbeat.D.beatD0043',frame[44]=Texture'AsylumHeartbeat.D.beatD0044',frame[45]=Texture'AsylumHeartbeat.D.beatD0045',frame[46]=Texture'AsylumHeartbeat.D.beatD0046',frame[47]=Texture'AsylumHeartbeat.D.beatD0047',frame[48]=Texture'AsylumHeartbeat.D.beatD0048',frame[49]=Texture'AsylumHeartbeat.D.beatD0049',frame[50]=Texture'AsylumHeartbeat.D.beatD0050',frame[51]=Texture'AsylumHeartbeat.D.beatD0051',frame[52]=Texture'AsylumHeartbeat.D.beatD0052',frame[53]=Texture'AsylumHeartbeat.D.beatD0053',frame[54]=Texture'AsylumHeartbeat.D.beatD0054',frame[55]=Texture'AsylumHeartbeat.D.beatD0055')
     beatFrames(4)=(frame[0]=Texture'AsylumHeartbeat.E.beatE0000',frame[1]=Texture'AsylumHeartbeat.E.beatE0001',frame[2]=Texture'AsylumHeartbeat.E.beatE0002',frame[3]=Texture'AsylumHeartbeat.E.beatE0003',frame[4]=Texture'AsylumHeartbeat.E.beatE0004',frame[5]=Texture'AsylumHeartbeat.E.beatE0005',frame[6]=Texture'AsylumHeartbeat.E.beatE0006',frame[7]=Texture'AsylumHeartbeat.E.beatE0007',frame[8]=Texture'AsylumHeartbeat.E.beatE0008',frame[9]=Texture'AsylumHeartbeat.E.beatE0009',frame[10]=Texture'AsylumHeartbeat.E.beatE0010',frame[11]=Texture'AsylumHeartbeat.E.beatE0011',frame[12]=Texture'AsylumHeartbeat.E.beatE0012',frame[13]=Texture'AsylumHeartbeat.E.beatE0013',frame[14]=Texture'AsylumHeartbeat.E.beatE0014',frame[15]=Texture'AsylumHeartbeat.E.beatE0015',frame[16]=Texture'AsylumHeartbeat.E.beatE0016',frame[17]=Texture'AsylumHeartbeat.E.beatE0017',frame[18]=Texture'AsylumHeartbeat.E.beatE0018',frame[19]=Texture'AsylumHeartbeat.E.beatE0019',frame[20]=Texture'AsylumHeartbeat.E.beatE0020',frame[21]=Texture'AsylumHeartbeat.E.beatE0021',frame[22]=Texture'AsylumHeartbeat.E.beatE0022',frame[23]=Texture'AsylumHeartbeat.E.beatE0023',frame[24]=Texture'AsylumHeartbeat.E.beatE0024',frame[25]=Texture'AsylumHeartbeat.E.beatE0025',frame[26]=Texture'AsylumHeartbeat.E.beatE0026',frame[27]=Texture'AsylumHeartbeat.E.beatE0027',frame[28]=Texture'AsylumHeartbeat.E.beatE0028',frame[29]=Texture'AsylumHeartbeat.E.beatE0029',frame[30]=Texture'AsylumHeartbeat.E.beatE0030',frame[31]=Texture'AsylumHeartbeat.E.beatE0031',frame[32]=Texture'AsylumHeartbeat.E.beatE0032',frame[33]=Texture'AsylumHeartbeat.E.beatE0033',frame[34]=Texture'AsylumHeartbeat.E.beatE0034',frame[35]=Texture'AsylumHeartbeat.E.beatE0035',frame[36]=Texture'AsylumHeartbeat.E.beatE0036',frame[37]=Texture'AsylumHeartbeat.E.beatE0037',frame[38]=Texture'AsylumHeartbeat.E.beatE0038',frame[39]=Texture'AsylumHeartbeat.E.beatE0039',frame[40]=Texture'AsylumHeartbeat.E.beatE0040',frame[41]=Texture'AsylumHeartbeat.E.beatE0041',frame[42]=Texture'AsylumHeartbeat.E.beatE0042',frame[43]=Texture'AsylumHeartbeat.E.beatE0043',frame[44]=Texture'AsylumHeartbeat.E.beatE0044',frame[45]=Texture'AsylumHeartbeat.E.beatE0045',frame[46]=Texture'AsylumHeartbeat.E.beatE0046',frame[47]=Texture'AsylumHeartbeat.E.beatE0047',frame[48]=Texture'AsylumHeartbeat.E.beatE0048',frame[49]=Texture'AsylumHeartbeat.E.beatE0049',frame[50]=Texture'AsylumHeartbeat.E.beatE0050',frame[51]=Texture'AsylumHeartbeat.E.beatE0051',frame[52]=Texture'AsylumHeartbeat.E.beatE0052',frame[53]=Texture'AsylumHeartbeat.E.beatE0053',frame[54]=Texture'AsylumHeartbeat.E.beatE0054',frame[55]=Texture'AsylumHeartbeat.E.beatE0055',frame[56]=Texture'AsylumHeartbeat.E.beatE0056',frame[57]=Texture'AsylumHeartbeat.E.beatE0057',frame[58]=Texture'AsylumHeartbeat.E.beatE0058',frame[59]=Texture'AsylumHeartbeat.E.beatE0059',frame[60]=Texture'AsylumHeartbeat.E.beatE0060')
     beatFrames(5)=(frame[0]=Texture'AsylumHeartbeat.F.beatF0000',frame[1]=Texture'AsylumHeartbeat.F.beatF0001',frame[2]=Texture'AsylumHeartbeat.F.beatF0002',frame[3]=Texture'AsylumHeartbeat.F.beatF0003',frame[4]=Texture'AsylumHeartbeat.F.beatF0004',frame[5]=Texture'AsylumHeartbeat.F.beatF0005',frame[6]=Texture'AsylumHeartbeat.F.beatF0006',frame[7]=Texture'AsylumHeartbeat.F.beatF0007',frame[8]=Texture'AsylumHeartbeat.F.beatF0008',frame[9]=Texture'AsylumHeartbeat.F.beatF0009',frame[10]=Texture'AsylumHeartbeat.F.beatF0010',frame[11]=Texture'AsylumHeartbeat.F.beatF0011',frame[12]=Texture'AsylumHeartbeat.F.beatF0012',frame[13]=Texture'AsylumHeartbeat.F.beatF0013',frame[14]=Texture'AsylumHeartbeat.F.beatF0014',frame[15]=Texture'AsylumHeartbeat.F.beatF0015',frame[16]=Texture'AsylumHeartbeat.F.beatF0016',frame[17]=Texture'AsylumHeartbeat.F.beatF0017',frame[18]=Texture'AsylumHeartbeat.F.beatF0018',frame[19]=Texture'AsylumHeartbeat.F.beatF0019',frame[20]=Texture'AsylumHeartbeat.F.beatF0020',frame[21]=Texture'AsylumHeartbeat.F.beatF0021',frame[22]=Texture'AsylumHeartbeat.F.beatF0022',frame[23]=Texture'AsylumHeartbeat.F.beatF0023',frame[24]=Texture'AsylumHeartbeat.F.beatF0024',frame[25]=Texture'AsylumHeartbeat.F.beatF0025',frame[26]=Texture'AsylumHeartbeat.F.beatF0026',frame[27]=Texture'AsylumHeartbeat.F.beatF0027',frame[28]=Texture'AsylumHeartbeat.F.beatF0028',frame[29]=Texture'AsylumHeartbeat.F.beatF0029',frame[30]=Texture'AsylumHeartbeat.F.beatF0030',frame[31]=Texture'AsylumHeartbeat.F.beatF0031',frame[32]=Texture'AsylumHeartbeat.F.beatF0032',frame[33]=Texture'AsylumHeartbeat.F.beatF0033',frame[34]=Texture'AsylumHeartbeat.F.beatF0034',frame[35]=Texture'AsylumHeartbeat.F.beatF0035',frame[36]=Texture'AsylumHeartbeat.F.beatF0036',frame[37]=Texture'AsylumHeartbeat.F.beatF0037',frame[38]=Texture'AsylumHeartbeat.F.beatF0038',frame[39]=Texture'AsylumHeartbeat.F.beatF0039',frame[40]=Texture'AsylumHeartbeat.F.beatF0040',frame[41]=Texture'AsylumHeartbeat.F.beatF0041',frame[42]=Texture'AsylumHeartbeat.F.beatF0042',frame[43]=Texture'AsylumHeartbeat.F.beatF0043',frame[44]=Texture'AsylumHeartbeat.F.beatF0044',frame[45]=Texture'AsylumHeartbeat.F.beatF0045',frame[46]=Texture'AsylumHeartbeat.F.beatF0046',frame[47]=Texture'AsylumHeartbeat.F.beatF0047',frame[48]=Texture'AsylumHeartbeat.F.beatF0048',frame[49]=Texture'AsylumHeartbeat.F.beatF0049',frame[50]=Texture'AsylumHeartbeat.F.beatF0050',frame[51]=Texture'AsylumHeartbeat.F.beatF0051',frame[52]=Texture'AsylumHeartbeat.F.beatF0052',frame[53]=Texture'AsylumHeartbeat.F.beatF0053',frame[54]=Texture'AsylumHeartbeat.F.beatF0054',frame[55]=Texture'AsylumHeartbeat.F.beatF0055',frame[56]=Texture'AsylumHeartbeat.F.beatF0056',frame[57]=Texture'AsylumHeartbeat.F.beatF0057',frame[58]=Texture'AsylumHeartbeat.F.beatF0058',frame[59]=Texture'AsylumHeartbeat.F.beatF0059',frame[60]=Texture'AsylumHeartbeat.F.beatF0060')
     beatFrames(6)=(frame[0]=Texture'AsylumHeartbeat.G.beatG0000',frame[1]=Texture'AsylumHeartbeat.G.beatG0001',frame[2]=Texture'AsylumHeartbeat.G.beatG0002',frame[3]=Texture'AsylumHeartbeat.G.beatG0003',frame[4]=Texture'AsylumHeartbeat.G.beatG0004',frame[5]=Texture'AsylumHeartbeat.G.beatG0005',frame[6]=Texture'AsylumHeartbeat.G.beatG0006',frame[7]=Texture'AsylumHeartbeat.G.beatG0007',frame[8]=Texture'AsylumHeartbeat.G.beatG0008',frame[9]=Texture'AsylumHeartbeat.G.beatG0009',frame[10]=Texture'AsylumHeartbeat.G.beatG0010',frame[11]=Texture'AsylumHeartbeat.G.beatG0011',frame[12]=Texture'AsylumHeartbeat.G.beatG0012',frame[13]=Texture'AsylumHeartbeat.G.beatG0013',frame[14]=Texture'AsylumHeartbeat.G.beatG0014',frame[15]=Texture'AsylumHeartbeat.G.beatG0015',frame[16]=Texture'AsylumHeartbeat.G.beatG0016',frame[17]=Texture'AsylumHeartbeat.G.beatG0017',frame[18]=Texture'AsylumHeartbeat.G.beatG0018',frame[19]=Texture'AsylumHeartbeat.G.beatG0019',frame[20]=Texture'AsylumHeartbeat.G.beatG0020',frame[21]=Texture'AsylumHeartbeat.G.beatG0021',frame[22]=Texture'AsylumHeartbeat.G.beatG0022',frame[23]=Texture'AsylumHeartbeat.G.beatG0023',frame[24]=Texture'AsylumHeartbeat.G.beatG0024',frame[25]=Texture'AsylumHeartbeat.G.beatG0025',frame[26]=Texture'AsylumHeartbeat.G.beatG0026',frame[27]=Texture'AsylumHeartbeat.G.beatG0027',frame[28]=Texture'AsylumHeartbeat.G.beatG0028',frame[29]=Texture'AsylumHeartbeat.G.beatG0029',frame[30]=Texture'AsylumHeartbeat.G.beatG0030',frame[31]=Texture'AsylumHeartbeat.G.beatG0031',frame[32]=Texture'AsylumHeartbeat.G.beatG0032',frame[33]=Texture'AsylumHeartbeat.G.beatG0033',frame[34]=Texture'AsylumHeartbeat.G.beatG0034',frame[35]=Texture'AsylumHeartbeat.G.beatG0035',frame[36]=Texture'AsylumHeartbeat.G.beatG0036',frame[37]=Texture'AsylumHeartbeat.G.beatG0037',frame[38]=Texture'AsylumHeartbeat.G.beatG0038',frame[39]=Texture'AsylumHeartbeat.G.beatG0039',frame[40]=Texture'AsylumHeartbeat.G.beatG0040',frame[41]=Texture'AsylumHeartbeat.G.beatG0041',frame[42]=Texture'AsylumHeartbeat.G.beatG0042',frame[43]=Texture'AsylumHeartbeat.G.beatG0043',frame[44]=Texture'AsylumHeartbeat.G.beatG0044',frame[45]=Texture'AsylumHeartbeat.G.beatG0045',frame[46]=Texture'AsylumHeartbeat.G.beatG0046',frame[47]=Texture'AsylumHeartbeat.G.beatG0047',frame[48]=Texture'AsylumHeartbeat.G.beatG0048',frame[49]=Texture'AsylumHeartbeat.G.beatG0049',frame[50]=Texture'AsylumHeartbeat.G.beatG0050',frame[51]=Texture'AsylumHeartbeat.G.beatG0051',frame[52]=Texture'AsylumHeartbeat.G.beatG0052',frame[53]=Texture'AsylumHeartbeat.G.beatG0053',frame[54]=Texture'AsylumHeartbeat.G.beatG0054',frame[55]=Texture'AsylumHeartbeat.G.beatG0055',frame[56]=Texture'AsylumHeartbeat.G.beatG0056',frame[57]=Texture'AsylumHeartbeat.G.beatG0057',frame[58]=Texture'AsylumHeartbeat.G.beatG0058',frame[59]=Texture'AsylumHeartbeat.G.beatG0059',frame[60]=Texture'AsylumHeartbeat.G.beatG0060',frame[61]=Texture'AsylumHeartbeat.G.beatG0061',frame[62]=Texture'AsylumHeartbeat.G.beatG0062',frame[63]=Texture'AsylumHeartbeat.G.beatG0063',frame[64]=Texture'AsylumHeartbeat.G.beatG0064',frame[65]=Texture'AsylumHeartbeat.G.beatG0065',frame[66]=Texture'AsylumHeartbeat.G.beatG0066',frame[67]=Texture'AsylumHeartbeat.G.beatG0067',frame[68]=Texture'AsylumHeartbeat.G.beatG0068',frame[69]=Texture'AsylumHeartbeat.G.beatG0069')
     beatFrames(7)=(frame[0]=Texture'AsylumHeartbeat.H.beatH0000',frame[1]=Texture'AsylumHeartbeat.H.beatH0001',frame[2]=Texture'AsylumHeartbeat.H.beatH0002',frame[3]=Texture'AsylumHeartbeat.H.beatH0003',frame[4]=Texture'AsylumHeartbeat.H.beatH0004',frame[5]=Texture'AsylumHeartbeat.H.beatH0005',frame[6]=Texture'AsylumHeartbeat.H.beatH0006',frame[7]=Texture'AsylumHeartbeat.H.beatH0007',frame[8]=Texture'AsylumHeartbeat.H.beatH0008',frame[9]=Texture'AsylumHeartbeat.H.beatH0009',frame[10]=Texture'AsylumHeartbeat.H.beatH0010',frame[11]=Texture'AsylumHeartbeat.H.beatH0011',frame[12]=Texture'AsylumHeartbeat.H.beatH0012',frame[13]=Texture'AsylumHeartbeat.H.beatH0013',frame[14]=Texture'AsylumHeartbeat.H.beatH0014',frame[15]=Texture'AsylumHeartbeat.H.beatH0015',frame[16]=Texture'AsylumHeartbeat.H.beatH0016',frame[17]=Texture'AsylumHeartbeat.H.beatH0017',frame[18]=Texture'AsylumHeartbeat.H.beatH0018',frame[19]=Texture'AsylumHeartbeat.H.beatH0019',frame[20]=Texture'AsylumHeartbeat.H.beatH0020',frame[21]=Texture'AsylumHeartbeat.H.beatH0021',frame[22]=Texture'AsylumHeartbeat.H.beatH0022',frame[23]=Texture'AsylumHeartbeat.H.beatH0023',frame[24]=Texture'AsylumHeartbeat.H.beatH0024',frame[25]=Texture'AsylumHeartbeat.H.beatH0025',frame[26]=Texture'AsylumHeartbeat.H.beatH0026',frame[27]=Texture'AsylumHeartbeat.H.beatH0027',frame[28]=Texture'AsylumHeartbeat.H.beatH0028',frame[29]=Texture'AsylumHeartbeat.H.beatH0029',frame[30]=Texture'AsylumHeartbeat.H.beatH0030',frame[31]=Texture'AsylumHeartbeat.H.beatH0031',frame[32]=Texture'AsylumHeartbeat.H.beatH0032',frame[33]=Texture'AsylumHeartbeat.H.beatH0033',frame[34]=Texture'AsylumHeartbeat.H.beatH0034',frame[35]=Texture'AsylumHeartbeat.H.beatH0035',frame[36]=Texture'AsylumHeartbeat.H.beatH0036',frame[37]=Texture'AsylumHeartbeat.H.beatH0037',frame[38]=Texture'AsylumHeartbeat.H.beatH0038',frame[39]=Texture'AsylumHeartbeat.H.beatH0039',frame[40]=Texture'AsylumHeartbeat.H.beatH0040',frame[41]=Texture'AsylumHeartbeat.H.beatH0041',frame[42]=Texture'AsylumHeartbeat.H.beatH0042',frame[43]=Texture'AsylumHeartbeat.H.beatH0043',frame[44]=Texture'AsylumHeartbeat.H.beatH0044',frame[45]=Texture'AsylumHeartbeat.H.beatH0045',frame[46]=Texture'AsylumHeartbeat.H.beatH0046',frame[47]=Texture'AsylumHeartbeat.H.beatH0047',frame[48]=Texture'AsylumHeartbeat.H.beatH0048',frame[49]=Texture'AsylumHeartbeat.H.beatH0049',frame[50]=Texture'AsylumHeartbeat.H.beatH0050',frame[51]=Texture'AsylumHeartbeat.H.beatH0051',frame[52]=Texture'AsylumHeartbeat.H.beatH0052',frame[53]=Texture'AsylumHeartbeat.H.beatH0053',frame[54]=Texture'AsylumHeartbeat.H.beatH0054',frame[55]=Texture'AsylumHeartbeat.H.beatH0055',frame[56]=Texture'AsylumHeartbeat.H.beatH0056',frame[57]=Texture'AsylumHeartbeat.H.beatH0057',frame[58]=Texture'AsylumHeartbeat.H.beatH0058',frame[59]=Texture'AsylumHeartbeat.H.beatH0059',frame[60]=Texture'AsylumHeartbeat.H.beatH0060',frame[61]=Texture'AsylumHeartbeat.H.beatH0061',frame[62]=Texture'AsylumHeartbeat.H.beatH0062',frame[63]=Texture'AsylumHeartbeat.H.beatH0063',frame[64]=Texture'AsylumHeartbeat.H.beatH0064',frame[65]=Texture'AsylumHeartbeat.H.beatH0065',frame[66]=Texture'AsylumHeartbeat.H.beatH0066',frame[67]=Texture'AsylumHeartbeat.H.beatH0067',frame[68]=Texture'AsylumHeartbeat.H.beatH0068',frame[69]=Texture'AsylumHeartbeat.H.beatH0069',frame[70]=Texture'AsylumHeartbeat.H.beatH0070',frame[71]=Texture'AsylumHeartbeat.H.beatH0071',frame[72]=Texture'AsylumHeartbeat.H.beatH0072')
     beatFrames(8)=(frame[0]=Texture'AsylumHeartbeat.i.beatI0000',frame[1]=Texture'AsylumHeartbeat.i.beatI0001',frame[2]=Texture'AsylumHeartbeat.i.beatI0002',frame[3]=Texture'AsylumHeartbeat.i.beatI0003',frame[4]=Texture'AsylumHeartbeat.i.beatI0004',frame[5]=Texture'AsylumHeartbeat.i.beatI0005',frame[6]=Texture'AsylumHeartbeat.i.beatI0006',frame[7]=Texture'AsylumHeartbeat.i.beatI0007',frame[8]=Texture'AsylumHeartbeat.i.beatI0008',frame[9]=Texture'AsylumHeartbeat.i.beatI0009',frame[10]=Texture'AsylumHeartbeat.i.beatI0010',frame[11]=Texture'AsylumHeartbeat.i.beatI0011',frame[12]=Texture'AsylumHeartbeat.i.beatI0012',frame[13]=Texture'AsylumHeartbeat.i.beatI0013',frame[14]=Texture'AsylumHeartbeat.i.beatI0014',frame[15]=Texture'AsylumHeartbeat.i.beatI0015',frame[16]=Texture'AsylumHeartbeat.i.beatI0016',frame[17]=Texture'AsylumHeartbeat.i.beatI0017',frame[18]=Texture'AsylumHeartbeat.i.beatI0018',frame[19]=Texture'AsylumHeartbeat.i.beatI0019',frame[20]=Texture'AsylumHeartbeat.i.beatI0020',frame[21]=Texture'AsylumHeartbeat.i.beatI0021',frame[22]=Texture'AsylumHeartbeat.i.beatI0022',frame[23]=Texture'AsylumHeartbeat.i.beatI0023',frame[24]=Texture'AsylumHeartbeat.i.beatI0024',frame[25]=Texture'AsylumHeartbeat.i.beatI0025',frame[26]=Texture'AsylumHeartbeat.i.beatI0026',frame[27]=Texture'AsylumHeartbeat.i.beatI0027',frame[28]=Texture'AsylumHeartbeat.i.beatI0028',frame[29]=Texture'AsylumHeartbeat.i.beatI0029',frame[30]=Texture'AsylumHeartbeat.i.beatI0030',frame[31]=Texture'AsylumHeartbeat.i.beatI0031',frame[32]=Texture'AsylumHeartbeat.i.beatI0032',frame[33]=Texture'AsylumHeartbeat.i.beatI0033',frame[34]=Texture'AsylumHeartbeat.i.beatI0034',frame[35]=Texture'AsylumHeartbeat.i.beatI0035',frame[36]=Texture'AsylumHeartbeat.i.beatI0036',frame[37]=Texture'AsylumHeartbeat.i.beatI0037',frame[38]=Texture'AsylumHeartbeat.i.beatI0038',frame[39]=Texture'AsylumHeartbeat.i.beatI0039',frame[40]=Texture'AsylumHeartbeat.i.beatI0040',frame[41]=Texture'AsylumHeartbeat.i.beatI0041',frame[42]=Texture'AsylumHeartbeat.i.beatI0042',frame[43]=Texture'AsylumHeartbeat.i.beatI0043',frame[44]=Texture'AsylumHeartbeat.i.beatI0044',frame[45]=Texture'AsylumHeartbeat.i.beatI0045',frame[46]=Texture'AsylumHeartbeat.i.beatI0046',frame[47]=Texture'AsylumHeartbeat.i.beatI0047',frame[48]=Texture'AsylumHeartbeat.i.beatI0048',frame[49]=Texture'AsylumHeartbeat.i.beatI0049',frame[50]=Texture'AsylumHeartbeat.i.beatI0050',frame[51]=Texture'AsylumHeartbeat.i.beatI0051',frame[52]=Texture'AsylumHeartbeat.i.beatI0052',frame[53]=Texture'AsylumHeartbeat.i.beatI0053',frame[54]=Texture'AsylumHeartbeat.i.beatI0054',frame[55]=Texture'AsylumHeartbeat.i.beatI0055',frame[56]=Texture'AsylumHeartbeat.i.beatI0056',frame[57]=Texture'AsylumHeartbeat.i.beatI0057',frame[58]=Texture'AsylumHeartbeat.i.beatI0058',frame[59]=Texture'AsylumHeartbeat.i.beatI0059',frame[60]=Texture'AsylumHeartbeat.i.beatI0060',frame[61]=Texture'AsylumHeartbeat.i.beatI0061',frame[62]=Texture'AsylumHeartbeat.i.beatI0062',frame[63]=Texture'AsylumHeartbeat.i.beatI0063',frame[64]=Texture'AsylumHeartbeat.i.beatI0064',frame[65]=Texture'AsylumHeartbeat.i.beatI0065',frame[66]=Texture'AsylumHeartbeat.i.beatI0066',frame[67]=Texture'AsylumHeartbeat.i.beatI0067',frame[68]=Texture'AsylumHeartbeat.i.beatI0068')
     beatFrames(9)=(frame[0]=Texture'AsylumHeartbeat.j.beatJ0000',frame[1]=Texture'AsylumHeartbeat.j.beatJ0001',frame[2]=Texture'AsylumHeartbeat.j.beatJ0002',frame[3]=Texture'AsylumHeartbeat.j.beatJ0003',frame[4]=Texture'AsylumHeartbeat.j.beatJ0004',frame[5]=Texture'AsylumHeartbeat.j.beatJ0005',frame[6]=Texture'AsylumHeartbeat.j.beatJ0006',frame[7]=Texture'AsylumHeartbeat.j.beatJ0007',frame[8]=Texture'AsylumHeartbeat.j.beatJ0008',frame[9]=Texture'AsylumHeartbeat.j.beatJ0009',frame[10]=Texture'AsylumHeartbeat.j.beatJ0010',frame[11]=Texture'AsylumHeartbeat.j.beatJ0011',frame[12]=Texture'AsylumHeartbeat.j.beatJ0012',frame[13]=Texture'AsylumHeartbeat.j.beatJ0013',frame[14]=Texture'AsylumHeartbeat.j.beatJ0014',frame[15]=Texture'AsylumHeartbeat.j.beatJ0015',frame[16]=Texture'AsylumHeartbeat.j.beatJ0016',frame[17]=Texture'AsylumHeartbeat.j.beatJ0017',frame[18]=Texture'AsylumHeartbeat.j.beatJ0018',frame[19]=Texture'AsylumHeartbeat.j.beatJ0019',frame[20]=Texture'AsylumHeartbeat.j.beatJ0020',frame[21]=Texture'AsylumHeartbeat.j.beatJ0021',frame[22]=Texture'AsylumHeartbeat.j.beatJ0022',frame[23]=Texture'AsylumHeartbeat.j.beatJ0023',frame[24]=Texture'AsylumHeartbeat.j.beatJ0024',frame[25]=Texture'AsylumHeartbeat.j.beatJ0025',frame[26]=Texture'AsylumHeartbeat.j.beatJ0026',frame[27]=Texture'AsylumHeartbeat.j.beatJ0027',frame[28]=Texture'AsylumHeartbeat.j.beatJ0028',frame[29]=Texture'AsylumHeartbeat.j.beatJ0029',frame[30]=Texture'AsylumHeartbeat.j.beatJ0030',frame[31]=Texture'AsylumHeartbeat.j.beatJ0031',frame[32]=Texture'AsylumHeartbeat.j.beatJ0032',frame[33]=Texture'AsylumHeartbeat.j.beatJ0033',frame[34]=Texture'AsylumHeartbeat.j.beatJ0034',frame[35]=Texture'AsylumHeartbeat.j.beatJ0035')
	 DamageTime(0)=1.0;
	 DamageTime(1)=1.0;
	 DamageTime(2)=1.0;
	 DamageTime(3)=1.0;
}
