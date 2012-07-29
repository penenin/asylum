//==============================================================================
//
//       Class Name:  	FlashlightProjectorTerrain
//      Description:  	Defines our mod's game type
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class FlashlightProjectorTerrain extends FlashlightProjector;

simulated event Touch( Actor Other )
{

}

defaultproperties
{
     //MaterialBlendingOp=PB_None
     MaxTraceDistance=20000
     bProjectBSP=true //was false
     bProjectStaticMesh=False
     bProjectParticles=False
     bProjectActor=False
     bClipStaticMesh=True
     bProjectOnUnlit=true
     bProjectOnAlpha=False
     bProjectOnParallelBSP=False
     
     

}
