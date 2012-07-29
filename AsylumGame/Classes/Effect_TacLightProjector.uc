//=============================================================================
// Frag.Ops © 2003 Matt 'SquirrelZero' Farber
//=============================================================================
// "UT2k3 Ultimate Flashlight"
// I wrote this using _both_ a dynamic projector and a dynamic light, with the 
// dynamic projector as the focal point and lightsource providing general 
// ambient illumination.  Either one by itself is pretty dull, but combine the 
// two and you've got yourself a really nice effect if done correctly.
//=============================================================================
class Effect_TacLightProjector extends DynamicProjector;

// add a light too, there seems to be a problem with the projector darkening terrain sometimes
var Effect_TacLightGlow TacLightGlow;

var bool bShowProjector;
var rotator ControllerRotation;

var int Range;
var FlashlightSpot AmbientLight;
var FlashlightShadowVolume FlashlightDSV;
var bool bIsAnimating;
var Flashlight parent;

// setup the pawn and controller variables, spawn the dynamic light
simulated function PostBeginPlay()
{
	if (bProjectActor)
		SetCollision(True, False, False);

	TacLightGlow = spawn(class'Effect_TacLightGlow');
	if (AmbientLight == none)
	{
        	AmbientLight =  spawn(class'FlashLightSpot', self, 'FlashlightShadowVolume', Instigator.Location );
	        AmbientLight.tag='FlashlightShadowVolume';
        }
	if (FlashlightDSV == none)
        	FlashlightDSV =  spawn(class'FlashlightShadowVolume', Instigator, 'FlashlightShadowVolume', Instigator.Location );
	
	AmbientLight.LightBrightness = 15;
}

// updates the taclight projector and dynamic light positions
simulated function UpdateLight(float DeltaTime)
{
	local vector StartTrace,EndTrace,X,Y,Z,HitLocation,HitNormal;
	local actor SurfaceActor;
	local float BeamLength;

	// we're changing its location and rotation, so detach it
	DetachProjector();

	// fallback
	if (TacLightGlow == None)
	{
		if (TacLightGlow != None)
			TacLightGlow.bDynamicLight = false;
		return;
	}

	GetAxes(ControllerRotation,X,Y,Z);

	// ok, first we need to get a location directly in front of the player
	if(!bIsAnimating)
		StartTrace = Instigator.Location + Instigator.EyePosition() + X*(Instigator.CollisionRadius*0.55);
	else
		StartTrace = parent.GetBoneCoords('bone_light').Origin;

	// not too far out
	EndTrace = StartTrace + 900*vector(ControllerRotation);
	SurfaceActor = Trace(HitLocation,HitNormal,EndTrace,StartTrace,true);
	if(SurfaceActor == None)
		HitLocation = EndTrace;

	// find out how far the first hit was
	BeamLength = VSize(StartTrace-HitLocation);

	// clear the base, we're going to be doing some adjustments
	if (Base != None);
		SetBase(none);

	// this makes a neat focus effect when you get close to a wall
	if (BeamLength <= 100)
	{
		SetLocation(StartTrace+vector(ControllerRotation)*Max((0.2*BeamLength), 1));
		SetBase(Instigator);
		SetRotation(ControllerRotation);
		SetDrawScale(FMax(0.02,(BeamLength/90))*Default.DrawScale);
	}
	// else we project it normally, positioning slightly in front of the player
	else 
	{
	
		SetLocation(StartTrace+vector(ControllerRotation)*100);
		SetBase(Instigator);
		SetRotation(ControllerRotation);
		SetDrawScale(Default.DrawScale);
	}

	// reattach it, unless this taclight is not owned by this player
	if (bShowProjector)
		AttachProjector();

	// turns the dynamic light on if it's off
	if (!TacLightGlow.bDynamicLight)
		TacLightGlow.bDynamicLight = true;

	TacLightGlow.SetLocation(HitLocation);
	TacLightGlow.SetRotation(rotator(HitLocation-StartTrace));
	TacLightGlow.LightBrightness = (((Range - BeamLength) / Range) * TacLightGlow.default.LightBrightness);
	TacLightGlow.LightRadius = ((BeamLength / Range) * TacLightGlow.default.LightRadius);
	
	AmbientLight.SetLocation(HitLocation);
}

// override completely
simulated function Tick(float delta)
{}

simulated function Destroyed()
{
	if (TacLightGlow != None)
		TacLightGlow.Destroy();
}

defaultproperties
{
     MaterialBlendingOp=PB_Modulate
     FrameBufferBlendingOp=PB_Add
     FOV=5
     MaxTraceDistance=1600
     bClipBSP=True
     bProjectOnUnlit=True
     bGradient=True
     bProjectOnAlpha=True
     bProjectOnParallelBSP=True
     DrawScale=0.350000
     bUnlit=True
     bGameRelevant=True
     Range=1000
}
