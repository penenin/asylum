//==============================================================================
//
//       Class Name:  	BatonAttachment
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class BatonAttachment extends BioAttachment;

event HitWall( vector HitNormal, actor HitWall ){
	Log("Player hit a wall");
}
event Bump( Actor Other ){
	Log("Baton bumped something.");
}

event Touch( Actor Other ){
	Log("Baton attachment touched something.");
	Log(Other.Name);
	Log(Other.Texture);
	Log(Other.Texture.SurfaceType);
	Log(Other.SurfaceType);
	

}
event bool EncroachingOn( actor Other ){
	Log("Baton Encroached something");
	return true;	

}
simulated event ThirdPersonEffects()
{
    local Rotator R;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
    {
        if (MuzFlash3rd == None)
        {
            MuzFlash3rd = Spawn(class'XEffects.RocketMuzFlash3rd');
            MuzFlash3rd.bHidden = false;
            AttachToBone(MuzFlash3rd, 'tip');
        }
        if (MuzFlash3rd != None)
        {
            R.Roll = Rand(65536);
            SetBoneRotation('Bone_Flash', R, 0, 1.0);
            MuzFlash3rd.mStartParticles++;
        }
    }

    Super.ThirdPersonEffects();
}

defaultproperties
{
	bCollideActors=true
     Mesh=SkeletalMesh'Weapons.ShieldGun_3rd'
}
