//==============================================================================
//
//       Class Name:  	ShadowStaticMeshActor
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
//-----------------------------------------------------------
//  Ninja'd this code off of the Infection mod
//-----------------------------------------------------------

class ShadowStaticMeshActor extends StaticMeshActor
placeable;

var ShadowProjector PlayerShadow;


simulated function Destroyed()
{
    if( PlayerShadow != None )
        PlayerShadow.Destroy();
}


simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    PlayerShadow = Spawn(class'ShadowProjector',Self,'',Location);
    PlayerShadow.ShadowActor = self;
    PlayerShadow.bBlobShadow = false;
    PlayerShadow.LightDirection = Normal(vect(0,0,1));
    PlayerShadow.LightDistance = 320;
    PlayerShadow.MaxTraceDistance = 350;
    PlayerShadow.InitShadow();


}

defaultproperties
{
}
