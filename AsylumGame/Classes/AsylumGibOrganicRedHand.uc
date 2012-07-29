//==============================================================================
//
//       Class Name:	AsylumGibOrganicRedHand
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGibOrganicRedHand extends AsylumGib;

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
    Level.AddPrecacheStaticMesh(StaticMesh'xEffects.GibOrganicHand');
}

defaultproperties
{
    DrawType=DT_StaticMesh
    DrawScale=1.3
    StaticMesh=StaticMesh'xEffects.GibOrganicHand'
    Skins=(Texture'xEffects.GibOrganicRed')

    TrailClass=class'AsylumGame.AsylumBloodJet'

    CollisionHeight=4.0
    CollisionRadius=4.0
}
