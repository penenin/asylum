//==============================================================================
//
//       Class Name:	AsylumGibOrganicRedTorso
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGibOrganicRedTorso extends AsylumGib;

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'xEffects.GibOrganicTorso');
}

defaultproperties
{
    DrawType=DT_StaticMesh
    DrawScale=0.27
    StaticMesh=StaticMesh'xEffects.GibOrganicTorso'
    Skins=(Texture'xEffects.GibOrganicRed')

    TrailClass=class'AsylumGame.AsylumBloodJet'

    CollisionHeight=10.0
    CollisionRadius=10.0
}
