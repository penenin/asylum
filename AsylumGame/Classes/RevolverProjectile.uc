//==============================================================================
//
//       Class Name:  	RevolverProjectile
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class RevolverProjectile extends FlakChunk;
simulated function HitWall(vector HitNormal, actor Wall){
	
	//Super.HitWall(HitNormal, Wall);

}
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();	

	Trail.mRegen = false;
	//Trail.Destroy();
    
}

defaultproperties
{

	MaxSpeed = 50000.0
	Speed = 50000.0
	Damage= 5
	DrawScale = 6.0
	LifeSpan = 10.0
	//bBounce=false
	//bounces = 0
	MomentumTransfer=10000
    MyDamageType=Class'asylumgame.RevolverDamageType'
}

