class Effect_InfraGlow extends Light
	notplaceable;

simulated function PostBeginPlay()
{
	if (Owner != None)
		SetBase(Owner);
}

defaultproperties
{
     LightEffect=LE_Sunlight
     LightBrightness=80.000000
     LightRadius=500.000000
     LightHue=80
     LightSaturation=100
     LightPeriod=0
     bStatic=False
     bNoDelete=False
     bDynamicLight=True
     RemoteRole=ROLE_None
     Texture=None
     bMovable=True
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bDirectional=True
}
