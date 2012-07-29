//==============================================================================
//
//       Class Name:  	FlashlightAttachment
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class FlashlightAttachment extends BioAttachment;

// taclight
var name LightBone;
var vector LightOffset; 

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
     Mesh=SkeletalMesh'Weapons.ShieldGun_3rd'
}
