class Effect_TacLightCorona3rd extends Light
	notplaceable;

simulated function ShowCorona()
{
	MinCoronaSize = Default.MinCoronaSize;
	MaxCoronaSize = Default.MaxCoronaSize;
}

simulated function HideCorona()
{
	MinCoronaSize = 0.0;
	MaxCoronaSize = 0.0;
}

defaultproperties
{
     MinCoronaSize=10.000000
     MaxCoronaSize=700.000000
     LightBrightness=0.000000
     Physics=PHYS_Trailer
     bCorona=True
     bStatic=False
     bNoDelete=False
     bOnlyDrawIfAttached=True
     bTrailerSameRotation=True
     bHardAttach=True
     DrawScale=0.110000
     Skins(0)=Texture'jwDecemberArchitecture.Coronas.Corona1'
     bMovable=True
     bOwnerNoSee=True
     bDirectional=True
}
