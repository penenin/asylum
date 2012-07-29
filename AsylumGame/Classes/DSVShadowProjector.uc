//==============================================================================
//
//       Class Name:  	DSVShadowProjector
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

class DSVShadowProjector extends ShadowLightProjector;

var DynamicShadowVolume DSV;
var ShadowProjectorOverride originalShadow;
var float darknessscale, deleteTimer, fadeInTimer;

function PostBeginPlay() {
	//log(Name$" Created");
	Super.PostBeginPlay();
	bShadowActive = false;
}

function Destroyed() {
	DSV.RemoveShadow(self);
	if (DSV.bHideDefaultShadowWhenActive && bShadowActive) {
		//log("enabling default on destruction for "$DSV);
		originalShadow.EnableShadow();
	}
	//log(Name$" Destroyed");
	Super.Destroyed();
}

function Tick(float d)
{
	local bool castingShadow;
	local float lightImportance;

    // fade shadows into view
    if (fadeInTimer < 1)
        fadeInTimer += d*2;

    //log("DVSShadowProjector.Tick 1");

    if ( (ShadowActor != none) && (DSV !=none) && (!ShadowActor.IsInVolume(DSV) && vsize(ShadowActor.Location - DSV.location) > DSV.effectRadius) )
    {
        //log("DVSShadowProjector.Tick 2");
	if (deleteTimer == 0)
        {
		deleteTimer = 1;
	}else{
		deleteTimer -= d;
		if (deleteTimer <= 0)
                {
			Destroy();
			//log(Name$" Exited");
		}
	}
    }else{
          deleteTimer = 0;
    }

    castingShadow = true;
    bUseShadowLight = true;
    //log("DVSShadowProjector.Tick 2.5");
    lightImportance = PickLight();
    //log("DVSShadowProjector.Tick 3");
    if (DSV.bUseCustomDefaultShadow && (lightImportance < DSV.ShadowImportance))
    {
        //log("DVSShadowProjector.Tick 4");
	ShadowVector = Normal(DSV.ShadowDirection)*DSV.ShadowDistance;
	ShadowDarkness = DSV.ShadowDarkness;
	ShadowDepth = DSV.ShadowDepth;
	bUseShadowLight = false;
	//log("DVSShadowProjector.Tick 5");

    }else if (lightImportance <= 0){
	castingShadow = false;
    }else{
	//log("drawing live shadow with "$sourceLight);
    }
    if (castingShadow && !bShadowActive)
    {
	bShadowActive = true;
	//log("DVSShadowProjector.Tick 6");
	if (DSV.bHideDefaultShadowWhenActive)
        {

		//log("disabling default for "$DSV);
		originalShadow.DisableShadow();
		//log("DVSShadowProjector.Tick 7");
	}
    }else if (!castingShadow && bShadowActive){
	bShadowActive = false;
	//log("DVSShadowProjector.Tick 8");
	if (DSV.bHideDefaultShadowWhenActive) {
		//log("enabling default for "$DSV);
		originalShadow.EnableShadow();
	}
    }
    Super.Tick(d);
}

function GenerateShadow(out  vector dir, out float darkness, out float depth) {
	Super.GenerateShadow(dir,darkness,depth);
	darkness *= darknessscale;
	if (deleteTimer != 0)
		darkness *= deleteTimer;

	if (fadeInTimer < 1)
		darkness *= fadeInTimer;
}

function float PickLight() {


	local float imp, imp2, grad, grad2;
	local float newimp, newgrad, dist;
	local int i;
	
       if (DSV == none)
           return 0.0;

	imp = 0;
	imp2 = 0;
        //if (DSV != none){
	   for(i=0 ; i<DSV.Lights.Length ; i++)
           {
		   newimp = DSV.Lights[i].GetImportance(ShadowActor, newgrad);
		   if (newimp > imp)
                   {
		      	      imp2 = imp;
			      grad2 = grad;
			      imp = newimp;
			      grad = newgrad;
			      sourceLight = DSV.Lights[i];
		    }
                    else if (newimp > imp2)
                    {
		            imp2 = newimp;
		            grad2 = newgrad;
		    }
            }
        //}

	darknessscale = 1;
	if ( (imp2 > 0) && (sourceLight != none) ){
		dist = (imp-imp2)/(grad+grad2);
		if (dist < sourceLight.ShadowChangeFadeDist) {
			darknessscale = dist/sourceLight.ShadowChangeFadeDist;
		}
	}

	return imp;
}

Function InitShadow() {
	bOwnerNoSee = DSV.bPlayerSeesShadow;
	Super.InitShadow();
	bShadowActive  = false;
}

defaultproperties
{
     CullDistance=2048.000000
}
