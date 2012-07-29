//==============================================================================
//
//       Class Name:  	ShadowProjectorOverride
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off the wiki, original version by Inio
//-----------------------------------------------------------
//-----------------------------------------------------------
//  And we ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class ShadowProjectorOverride extends ShadowProjector;

var int masterDisable;

function PostBeginPlay() {
	masterDisable = 0;
	Super.PostBeginPlay();
}

function UpdateShadow() {
	if(masterDisable==0)
		Super.UpdateShadow();
}

function DisableShadow() {
	if (masterDisable == 0)
		DetachProjector(true);
	masterDisable++;
	log(Name$" disabled to level "$masterDisable);
}

function EnableShadow() {
	masterDisable--;
	log(Name$" enabled to level "$masterDisable);
	if (masterDisable < 0) {
		masterDisable = 0;
	}
}

defaultproperties
{
}
