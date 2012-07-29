//==============================================================================
//
//       Class Name:	AsylumGibOrganicRedUpperArm
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGibOrganicRedUpperArm extends AsylumGib;

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'xEffects.GibOrganicUpperArm');
}

defaultproperties
{
    DrawType=DT_StaticMesh
    DrawScale=0.13
    StaticMesh=StaticMesh'xEffects.GibOrganicUpperArm'
    Skins=(Texture'xEffects.GibOrganicRed')

    TrailClass=class'AsylumGame.AsylumBloodJet'

    CollisionHeight=6.0
    CollisionRadius=6.0
}
