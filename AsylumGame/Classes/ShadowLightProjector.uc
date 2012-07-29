//==============================================================================
//
//       Class Name:  	ShadowLightProjector
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

class ShadowLightProjector extends ShadowProjector;

var ShadowCaster sourceLight;
var() float MaxShadowDepth;

var vector ShadowVector;
var byte ShadowDarkness;
var float ShadowDepth;

var bool bUseShadowLight;

var float ActorRadius;

function InitShadow()
{
	if(ShadowActor == None) {
		Log(Name$".InitShadow: No actor");
		Destroy();
		return;
	}

	ShadowTexture = ShadowBitmapMaterial(
			Level.ObjectPool.AllocateObject(class'ShadowBitmapMaterial'));

	ProjTexture = ShadowTexture;

	if (ShadowTexture == None) {
		Log(Name$".InitShadow: Failed to allocate texture");
		Destroy();
		return;
	}

	ShadowTexture.bBlobShadow = bBlobShadow;
	ShadowTexture.ShadowActor = ShadowActor;
    ShadowTexture.CullDistance = CullDistance; // sjs

	ActorRadius = ShadowActor.GetRenderBoundingSphere().W;
	Enable('Tick');
	UpdateShadow();
/*		FOV = Atan(BoundingSphere.W * 2 + 160, LightDistance) * 180 / PI;


		ProjTexture = ShadowTexture;

		if(ShadowTexture != None)
		{
			SetDrawScale(LightDistance * tan(0.5 * FOV * PI / 180) / (0.5 * ShadowTexture.USize));

			ShadowTexture.Invalid = False;
			ShadowTexture.bBlobShadow = bBlobShadow;
			ShadowTexture.ShadowActor = ShadowActor;
			ShadowTexture.LightDirection = Normal(LightDirection);
			ShadowTexture.LightDistance = LightDistance;
			ShadowTexture.LightFOV = FOV;
            ShadowTexture.CullDistance = CullDistance; // sjs

			Enable('Tick');
			UpdateShadow();
		}
		else
			Log(Name$".InitShadow: Failed to allocate texture");
	}
	else*/

}

function GenerateShadow(out vector dir, out float darkness, out float depth) {
	if (bUseShadowLight) {
		sourceLight.GenerateShadow(ShadowActor, dir, darkness, depth);
		if (depth > MaxShadowDepth)
			depth = MaxShadowDepth;
	} else {
		dir = ShadowVector;
		darkness = ShadowDarkness;
		depth = ShadowDepth;
	}
}

function UpdateShadow()
{
	local coords C;
	local vector direction;
	local float darkness;
//	local float distance;
	local float depth;

	DetachProjector(true);

	if ((ShadowActor == None) || ShadowActor.bHidden || !bShadowActive ||
			(Level.TimeSeconds - ShadowActor.LastRenderTime > 4)) {
		return;
	}

	if ((ShadowTexture == None) || ShadowTexture.Invalid) {
		Destroy();
		return;
	}

	GenerateShadow(direction, darkness, depth);

	if (darkness > 1)
		darkness = 1;


//	if (Level.bDropDetail) {
		//	turn up minimum shadow darkness
//		darkness = darkness*(4.0/3.0) - 0.25;
//	}

	if (darkness < 0)
		return;

	LightDistance = VSize(direction);
	LightDirection = Normal(direction);
	MaxTraceDistance = depth;

	//	keep the FOV reasonable
	if (LightDistance < ActorRadius*1.4)
		LightDistance = ActorRadius*1.4;

	// This fits tighter than the FOV calc from ShadowProjector for small FOVs,
	// and doesn't clip polygons close to the light for wide FOVs.  The extra .1
	// is to gurantee some transparent pixels on the edge.
	FOV = 2.1* Asin(ActorRadius/LightDistance ) * 180 / PI;

	if(RootMotion && ShadowActor.DrawType == DT_Mesh && ShadowActor.Mesh != None)
	{
		C = ShadowActor.GetBoneCoords('');
		SetLocation(C.Origin);
	}
	else
		SetLocation(ShadowActor.Location + vect(0,0,1));

	MaxTraceDistance  = 2048;

	SetRotation(Rotator(Normal(-LightDirection)));



	ShadowTexture.LightDistance = LightDistance;
	ShadowTexture.LightDirection = LightDirection;
	ShadowTexture.LightFOV = FOV;
	ShadowTexture.ShadowDarkness= 255*darkness;
	ShadowTexture.Dirty = true;
//	if ( Level.bDropDetail )
//		ShadowTexture.CullDistance = 0.7 * CullDistance;
//	else
		ShadowTexture.CullDistance = CullDistance;

//	log("Casting shadow: "$LightDistance$";"$LightDirection$";"$FOV);

    AttachProjector();
}

defaultproperties
{
}
