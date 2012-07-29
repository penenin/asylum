//==============================================================================
//
//       Class Name:	AsylumMonsterPawn
//      Description:	Base class for all enemy pawns
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumMonsterPawn extends Monster
	abstract;

var Effect_ShadowController RealtimeShadow;
var bool bRealtimeShadows;

simulated function PostBeginPlay()
{
	Super(UnrealPawn).PostBeginPlay();
	AssignInitialPose();

	if(bActorShadows && bPlayerShadows && (Level.NetMode != NM_DedicatedServer))
	{
		if(!bRealtimeShadows)
		{
			PlayerShadow = Spawn(class'ShadowProjector',self,'',Location);
			PlayerShadow.ShadowActor = self;
			PlayerShadow.bBlobShadow = bBlobShadow;
			PlayerShadow.LightDirection = Normal(vect(1,1,3));
			PlayerShadow.LightDistance = 320;
			PlayerShadow.MaxTraceDistance = 350;
			PlayerShadow.InitShadow();
		}
		else
		{
			RealtimeShadow = Spawn(class'Effect_ShadowController',self,'',Location);
			RealtimeShadow.Instigator = self;
			RealtimeShadow.Initialize();
		}
	}
}

simulated function StartDeRes()
{
}

function RosterEntry GetPlacedRoster()
{
	return None;
}

function ChangeName()
{
}

simulated event SetAnimAction(name NewAction)
{
    AnimAction = NewAction;
	if (!bWaitForAnim)
	{
	   if ( AnimAction == 'Weapon_Switch' )
	   {
	   }
	   else if ( (Physics == PHYS_None)
		  || ((Level.Game != None) && Level.Game.IsInState('MatchOver')) )
	   {
	       PlayAnim(AnimAction,,0.1);
	       AnimBlendToAlpha(1,0.0,0.05);
        }
	    else if ( (Physics == PHYS_Falling) || ((Physics == PHYS_Walking) && (Velocity.Z != 0)) )
        {
            if ( CheckTauntValid(AnimAction) )
            {
		      if (FireState == FS_None || FireState == FS_Ready)
		      {
		          AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
		          PlayAnim(NewAction,, 0.1, 1);
	                FireState = FS_Ready;
	           }
            }
			else if ( PlayAnim(AnimAction) )
			{
		      if ( Physics != PHYS_None )
		          bWaitForAnim = true;
			}
		}
	    else if (bIsIdle && !bIsCrouched && (Bot(Controller) == None) ) // standing taunt
	    {
	        PlayAnim(AnimAction,,0.1);
			AnimBlendToAlpha(1,0.0,0.05);
	    }
	    else // running taunt
        {
            if (FireState == FS_None || FireState == FS_Ready)
            {
	           AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
	           PlayAnim(NewAction,, 0.1, 1);
                FireState = FS_Ready;
            }
	    }
	}
}

defaultproperties
{
    RagdollLifeSpan=0
    GibGroupClass=class'AsylumGame.AsylumPawnGibGroup'
	bRealtimeShadows=false
}
