//=============================================================================
// © 2003 Matt 'SquirrelZero' Farber
//=============================================================================
class Effect_TacLightGlow extends Light;

function PostBeginPlay()
{
    SetTimer(1.0,True);
}

// makes bots "see" the light when it's on
function Timer()
{
    MakeNoise(0.3);
}

defaultproperties
{
    Texture=S_Light
    LightType=LT_Steady
    LightEffect=LE_None
    LightBrightness=120
    LightSaturation=255
    LightRadius=7
    LightPeriod=34
    CollisionRadius=+0005.000000
    CollisionHeight=+0005.000000
    bHidden=true
    bStatic=false
    bNoDelete=false
    bMovable=true
    bDynamicLight=true
    bDirectional=true
    RemoteRole=ROLE_SimulatedProxy
    LightCone=256
}