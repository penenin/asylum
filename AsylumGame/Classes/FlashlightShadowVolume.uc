//==============================================================================
//
//       Class Name:  	FlashlightShadowVolume
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class FlashlightShadowVolume extends DynamicShadowVolume;


// touch is too slow, gonna use a timer
simulated event touch(Actor A)
{


}


simulated event PostBeginPlay()
{
    setTimer(0.1, true);
    super.PostBeginPlay();
}


// look for touching actors
function Timer()
{
    local actor A;

    foreach RadiusActors  ( class'Actor', A, effectRadius, location )
    {
        volTouch(A);
    }
}

simulated event volTouch(Actor A)
{
	local actor player;
	local ShadowProjector oldShadow;
	local ShadowProjectorOverride newShadow;
	local DSVShadowProjector liveShadow;

    player = a;

    // make sure its the proper kinda actor
    if(player == none)
        return;

     if (  !(player.IsA('AsylumMonsterPawn') || player.IsA('ShadowStaticMeshActor'))  )
        return;

     if (IsShadowing(player))
	return;

     if (ShadowStaticMeshActor(player).PlayerShadow == None &&
           AsylumMonsterPawn(player).PlayerShadow == None)
     {

	return;
     }

    if (player.IsA('ShadowStaticMeshActor') )
       oldShadow = ShadowStaticMeshActor(player).PlayerShadow;
    else if (player.IsA('AsylumMonsterPawn'))
       oldShadow = AsylumMonsterPawn(player).PlayerShadow;

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
    else if (player.IsA('AsylumMonsterPawn'))
           AsylumMonsterPawn(player).PlayerShadow = newShadow;
	}

	liveShadow = Spawn(class'DSVShadowProjector',player,'',player.Location);
        liveShadow.ShadowActor = newShadow.ShadowActor ;
	liveShadow.bBlobShadow = newShadow.bBlobShadow ;
	liveShadow.DSV = self;
	liveShadow.originalShadow = newShadow;
	liveShadow.InitShadow();
	Shadows.Length = Shadows.Length+1;
	Shadows[Shadows.Length-1] = liveShadow;
}

defaultproperties
{
     effectRadius=500.000000
     bStatic=False
     bNoDelete=False
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bCollideActors=False
}
