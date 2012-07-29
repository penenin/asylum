//==============================================================================
//
//       Class Name:	AsylumGibOrganicRedForearm
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGibOrganicRedForearm extends AsylumGib;

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'xEffects.GibOrganicForearm');
}

defaultproperties
{
    DrawType=DT_StaticMesh
    DrawScale=1.3
    StaticMesh=StaticMesh'xEffects.GibOrganicForearm'
    Skins=(Texture'xEffects.GibOrganicRed')

    TrailClass=class'AsylumGame.AsylumBloodJet'

    CollisionHeight=6.0
    CollisionRadius=6.0
}
