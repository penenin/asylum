//==============================================================================
//
//       Class Name:  	FlashlightProjector
//      Description:  	Defines our mod's game type
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class FlashlightProjector extends DynamicProjector;

#exec OBJ LOAD FILE="..\Asylum\Textures\AsylumTextures.utx"

// Empty tick here - do detach/attach in Weapon
function Tick(float Delta)
{

}

defaultproperties
{
     MaterialBlendingOp=PB_Modulate
     FrameBufferBlendingOp=PB_Add
     ProjTexture=Texture'AsylumTextures.Weapons.FlashlightProjector'
     FOV=10
     MaxTraceDistance=20000
     bClipBSP=True
     bProjectOnUnlit=True
     //bProjectOnActor=True
     //bProjectOnStatic=True
     bGradient=True
     bProjectOnAlpha=True
     bProjectOnParallelBSP=True
     bLightChanged=True
     bHardAttach=True
     DrawScale=0.300000
}
