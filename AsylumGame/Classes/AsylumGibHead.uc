//==============================================================================
//
//       Class Name:  	AsylumGibHead
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class AsylumGibHead extends AsylumGib;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	if ( Instigator != None )
	{
		SetDrawScale(Instigator.HeadScale * DrawScale);
		SetCollisionSize(CollisionRadius * Instigator.HeadScale, CollisionHeight * Instigator.HeadScale);
	}
}
