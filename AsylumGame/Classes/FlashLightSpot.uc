//==============================================================================
//
//       Class Name:  	FlashlightSpot
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class FlashlightSpot extends ShadowLight;

defaultproperties
{
     Texture=Texture'AsylumTextures.Weapons.FlashlightPic'
     ShadowCastRadius=2000.000000
     ShadowMinTraceDistance=2000.000000
     LightBrightness=50.000000
     LightRadius=20.000000
     bStatic=False
     bNoDelete=False
     bDynamicLight=True
     bMovable=True
}
