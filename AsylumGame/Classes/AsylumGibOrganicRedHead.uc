//==============================================================================
//
//       Class Name:	AsylumGibOrganicRedHead
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGibOrganicRedHead extends AsylumGibHead;

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'xEffects.GibOrganicHead');
}

defaultproperties
{
    DrawType=DT_StaticMesh
    DrawScale=0.3
    StaticMesh=StaticMesh'xEffects.GibOrganicHead'
    Skins=(Texture'xEffects.GibOrganicRed')

    TrailClass=class'AsylumGame.AsylumBloodJet'

    CollisionHeight=5.0
    CollisionRadius=6.0
}
