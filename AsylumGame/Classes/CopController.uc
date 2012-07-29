//==============================================================================
//
//       Class Name:	CopController
//      Description:
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================

class CopController extends AsylumMonsterController;

var bool bIsWalking;
var bool bIsRunning;
var bool bIsTakingCover;
var bool bIsReloading;
var bool bIsRetreating;

auto state Initialize
{
	function BeginState()
	{
		Log("BEGIN STATE CALLED!");
		GotoState('Charging');
	}

	function Tick(float DeltaTime)
	{
		Log("TICK FUNCTION CALLED!");
		//Log("Checking for Enemy");
		
		//if( EnemyVisible() )
		//{
		//	Log("Enemy Found...Charging");
		//	GotoState('Charging');
		//}	
		
		if( Pawn.health < 20 )
		{
			Log("Low on health...retreating");
			GotoState('Retreating');
		}
		
		//if(bIsWalking)
		//	GotoState('Walking');
		
		//if(bIsRunning)
		//	GotoState('Running');
		
		//if(bIsTakingCover)
		//	GotoState('TakingCover');
	
		//if(bIsReloading)
		//	GotoState('Reloading');
		
		//if(bIsRetreating)
		//	GotoState('FallBack');
	}
}

event SeePlayer(Pawn SeenPlayer)
{
    if(SeenPlayer.IsA('AsylumPlayerPawn'))
    { 
        VisibleEnemy = SeenPlayer;
        EnemyVisibilityTime = Level.TimeSeconds;
        bEnemyIsVisible = true;
    }
}

event bool NotifyBump(actor Other)
{
	return false;
}

function HearNoise(float Loudness, Actor NoiseMaker)
{
    if ( ((ChooseAttackCounter < 2) || (ChooseAttackTime != Level.TimeSeconds)) )//&& Squad.SetEnemy(self,NoiseMaker.instigator) )
        WhatToDoNext(2);	
}

function DamageAttitudeTo(Pawn Other, float Damage)
{
    if ( (Pawn.health > 0) && (Damage > 0) )//&& Squad.SetEnemy(self,Other) )
        WhatToDoNext(5);
}

function NotifyKilled(Controller Killer, Controller Killed, pawn KilledPawn)
{
}    

function ExecuteWhatToDoNext()
{
}

function bool AssignSquadResponsibility()
{
	return false;
}

function PickDestination()
{
}

function RestFormation()
{
}

state Walking
{
	function BeginState()
	{
		Log("Entering Walking State");		
		//Enable('Timer');
	}
	
	//function Timer()
	//{
		//Log("Checking for Enemy");
		
		//if( EnemyVisible() )
		//{
		//	Log("Enemy Found...Attacking");
		//	GotoState('Attack');
		//}	
		
		//if( Pawn.HealthMax < 20 )
		//{
		//	Log("Low on health...retreating");
		//	GotoState('Retreating');
		//}
	//}
}

state Running
{
	function BeginState()
	{
		Log("Entering Running State");
	}
}

state TakingCover
{
	function BeginState()
	{
		Log("Entering TakingCover State");
	}
}

state Reloading
{
	function BeginState()
	{
		Log("Entering Reloading State");
	}
}

defaultproperties
{
	PawnClass=Class'AsylumGame.CopPawn'
	bIsWalking=true
	bIsRunning=false
	bIsTakingCover=false
	bIsReloading=false
	bIsRetreating=false
}