//==============================================================================
//
//       Class Name:  	DynamicShadowVolume
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

class DynamicShadowVolume extends Volume;

var(ShadowDefault) vector ShadowDirection;
var(ShadowDefault) int ShadowDistance;
var(ShadowDefault) int ShadowDepth;
var(ShadowDefault) float ShadowDarkness;
var(ShadowDefault) float ShadowImportance;
var(Shadow) bool bUseShadowLights;
var(Shadow) bool bUseCustomDefaultShadow;
var(Shadow) bool bHideDefaultShadowWhenActive;
var(Shadow) bool bPlayerSeesShadow;

var array<ShadowCaster> Lights;
var actor spawnedPawn;
var array<DSVShadowProjector> Shadows;

var float effectRadius;

simulated event PostBeginPlay()
{
	local ShadowCaster light;
	local actor A;
	foreach AllActors(class'ShadowCaster',light,tag)
    {
		Lights.Length = Lights.Length+1;
		Lights[Lights.Length-1] = light;
		//log("checking light "$light.tag);
	}
	log(Name$": Includes "$Lights.Length$" Lights");

	// get actors that are initially touching volume
	foreach AllActors(class'Actor',A,)
    {
         If (A.IsInVolume(self) )
         {
              Touch(a);
         }
	}
	Super.PostBeginPlay();
}

simulated function bool IsShadowing(actor p) {
	local int i;

	for(i=0 ; i<Shadows.Length ; i++) {
		if (Shadows[i].ShadowActor == p)
			return true;
	}
	return false;
}

simulated function RemoveShadow(DSVShadowProjector s) {
	local int i;

	for(i=0 ; i<Shadows.Length ; i++) {
		if (Shadows[i] == s) {
			Shadows.Remove(i,1);
			return;
		}
	}
}

simulated event touch(Actor A) {
	//local StaticTicker ticker;
	local actor player;
//	local vector dir;
	local ShadowProjector oldShadow;
	local ShadowProjectorOverride newShadow;
	local DSVShadowProjector liveShadow;

    //log("------------------------------------------>DSV's touch");

    player = a;

	// make sure its the proper kinda actor

    if(player == none)
        return;

//    log(player.IsA('xpawn'));
//    log(player.IsA('ShadowStaticMeshActor'));
//    log( !(player.IsA('xpawn') || player.IsA('ShadowStaticMeshActor')) );

	if (  !(player.IsA('xpawn') || player.IsA('ShadowStaticMeshActor'))  )
        return;

    //log("------------------------------------------>Got here");

	if (IsShadowing(player))
		return;

    //log("------------------------------------------>Got here1");

	if (ShadowStaticMeshActor(player).PlayerShadow == None && 
	    xpawn(player).PlayerShadow == None)
    {

		return;
    }

    //log("------------------------------------------>Got here2");
    if (player.IsA('ShadowStaticMeshActor') )
	   oldShadow = ShadowStaticMeshActor(player).PlayerShadow;
	else
       oldShadow = xpawn(player).PlayerShadow;

	newShadow = ShadowProjectorOverride(oldShadow);

	if (newShadow == None) {
		newShadow = Spawn(class'ShadowProjectorOverride',player,'',player.Location);
                newShadow.ShadowActor = oldShadow.ShadowActor ;
                newShadow.bBlobShadow = oldShadow.bBlobShadow ;
                newShadow.LightDirection = oldShadow.LightDirection ;
                newShadow.LightDistance = oldShadow.LightDistance ;
                newShadow.MaxTraceDistance = oldShadow.MaxTraceDistance ;
                newShadow.bShadowActive= oldShadow.bShadowActive;
		newShadow.bOwnerNoSee = bPlayerSeesShadow;
                newShadow.InitShadow();
		oldShadow.DetachProjector(true);
		oldShadow.Destroy();

		if (player.IsA('ShadowStaticMeshActor') )
    	                ShadowStaticMeshActor(player).PlayerShadow = newShadow;
    	        else
                        xpawn(player).PlayerShadow = newShadow;
	}

	log(Name$" Creating Shadow");
	liveShadow = Spawn(class'DSVShadowProjector',player,'',player.Location);
        liveShadow.ShadowActor = newShadow.ShadowActor ;
	liveShadow.bBlobShadow = newShadow.bBlobShadow ;
	liveShadow.DSV = self;
	liveShadow.originalShadow = newShadow;
	liveShadow.InitShadow();
	Shadows.Length = Shadows.Length+1;
	Shadows[Shadows.Length-1] = liveShadow;
}

simulated event untouch(Actor A) {
// shadows remove themselves when their pawn leaves the zone
}

// actually called by VolumeTicker
//simulated event Tick(float d) {
//	if (spawnedPawn != None) {
//		touch(spawnedPawn);
//	}
//}

defaultproperties
{
     effectRadius=10.000000
}
