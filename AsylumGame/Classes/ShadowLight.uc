//==============================================================================
//
//       Class Name:  	ShadowLight
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

class ShadowLight extends ShadowCaster;

var(Shadow) float	ShadowCastRadius;

simulated event PostBeginPlay() {
	if(ShadowCastRadius== 0)
		ShadowCastRadius= 32*LightRadius;
}

simulated function GenerateShadow(
	Actor to,
	out  vector dir,
	out float darkness,
	out float maxdepth)
{
	dir = Location - to.Location;
	darkness = ShadowMaxDarkness*(1-VSize(dir)/ShadowCastRadius);
	maxdepth = ShadowCastRadius-VSize(dir);
	if (maxDepth < ShadowMinTraceDistance)
       maxDepth = ShadowMinTraceDistance;
//	log("generated light "$dir$";"$darkness$";"$maxdepth);
}

simulated function float GetImportance(Actor to, out float gradient) {
	local float distance;
    distance = VSize(Location - to.Location);
    gradient = ShadowMaxImportance/ShadowCastRadius;
    return ShadowMaxImportance - gradient*distance;
}

defaultproperties
{
     ShadowCastRadius=800.000000
}
