//==============================================================================
//
//       Class Name:	AsylumGibOrganicRedCalf
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGibOrganicRedCalf extends AsylumGib;

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'xEffects.GibOrganicCalf');
}

defaultproperties
{
    DrawType=DT_StaticMesh
    DrawScale=0.2
    StaticMesh=StaticMesh'xEffects.GibOrganicCalf'
    Skins=(Texture'xEffects.GibOrganicRed')

    TrailClass=class'AsylumGame.AsylumBloodJet'

    CollisionHeight=6.0
    CollisionRadius=6.0
}
