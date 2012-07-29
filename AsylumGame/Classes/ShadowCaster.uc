//==============================================================================
//
//       Class Name:  	ShadowCaster
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

class ShadowCaster extends Light placeable;

var(Shadow)	float	ShadowMinTraceDistance;
var(Shadow) float	ShadowMaxDarkness;
var(Shadow) float	ShadowMaxImportance;
var(Shadow) float	ShadowChangeFadeDist;

simulated function GenerateShadow(
	Actor to,
	out  vector dir,
	out float darkness,
	out float maxdepth);

simulated function float GetImportance(Actor to, out float gradient);

defaultproperties
{
     ShadowMinTraceDistance=150.000000
     ShadowMaxDarkness=1.000000
     ShadowMaxImportance=10.000000
     ShadowChangeFadeDist=32.000000
}
