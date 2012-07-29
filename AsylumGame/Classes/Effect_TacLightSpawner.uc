//=============================================================================
// Frag.Ops © 2003 Matt 'SquirrelZero' Farber
//=============================================================================
// Master spawning class for the taclight.  Spawns then replicates the needed
// information to the projector.
//=============================================================================
class Effect_TacLightSpawner extends Effects;

// taclight projector
var Effect_TacLightProjector TacLight;

// taclight corona
var Effect_TacLightCorona3rd TacLightCorona3rd;

var rotator TacLightRotation;
var bool bLightOn;

// pawn controlling this taclight
var Pawn LightPawn;

/*
replication
{
	reliable if (bNetDirty && Role == ROLE_Authority)
		bLightOn, LightPawn;

	reliable if (!bNetOwner && bNetDirty && Role == ROLE_Authority)
		TacLightRotation;
}
*/

function SetLight()
{
	local FlashlightAttachment Attach3rd;

	if (Level.NetMode != NM_DedicatedServer && Role == ROLE_Authority)
	{
		// set our instigator
		Instigator = LightPawn;

		TacLight = spawn(class'Effect_TacLightProjector', None,, Location, Rotation);
		TacLight.bShowProjector = true;

		if (!AsylumPlayerController(Instigator.Controller).bBehindView)
			return;

		// attach a dynamic corona
		Attach3rd = FlashlightAttachment(AsylumPlayerPawn(LightPawn).WeaponAttachment);
		if (Attach3rd != None)
		{
			TacLightCorona3rd = spawn(class'Effect_TacLightCorona3rd', None,, Location, Rotation);
			if (TacLightCorona3rd != None)
				Attach3rd.AttachToBone(TacLightCorona3rd, Attach3rd.LightBone);
		}
	}
}

/*
simulated function PostNetBeginPlay()
{
	local FlashlightAttachment Attach3rd;
	
	if (Level.NetMode == NM_DedicatedServer || TacLight != None)
		return;

	// set our instigator
	Instigator = LightPawn;

	// spawn the light
	TacLight = spawn(class'Effect_TacLightProjector', None,, Location, Rotation);
	if (TacLight != None)
		TacLight.bShowProjector = true;

	// attach a dynamic corona
	Attach3rd = FlashlightAttachment(AsylumPlayerPawn(LightPawn).WeaponAttachment);
	if (Attach3rd != None)
	{
		TacLightCorona3rd = spawn(class'Effect_TacLightCorona3rd', None,, Location, Rotation);
		if (TacLightCorona3rd != None)
			Attach3rd.AttachToBone(TacLightCorona3rd, Attach3rd.LightBone);
	}
}
*/

simulated function Tick(float delta)
{
	if (LightPawn == None)
		return;
	
	if (LightPawn.Health <= 0)
	{
		Destroy();
		Disable('Tick');
		return;
	}

	if (Role == ROLE_Authority)
		TacLightRotation = LightPawn.GetViewRotation();
	if (TacLight != None)
	{
		if (!bLightOn)
		{
			TacLight.DetachProjector();
			TacLight.TacLightGlow.bDynamicLight = false;
			if (TacLightCorona3rd != None)
				TacLightCorona3rd.HideCorona();
			return;
		}
		if (TacLightCorona3rd != None)
			TacLightCorona3rd.ShowCorona();
		TacLight.ControllerRotation = TacLightRotation;
		TacLight.UpdateLight(delta);
	}
}

simulated function Destroyed()
{
	Super.Destroyed();
	if (TacLight != None)
		TacLight.Destroy();
	if (TacLightCorona3rd != None)
		TacLightCorona3rd.Destroy();
}

defaultproperties
{
     bHidden=True
     bNetTemporary=False
     bAlwaysRelevant=True
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     NetUpdateFrequency=150.000000
     NetPriority=3.000000
     bDirectional=True
}
