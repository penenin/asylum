//==============================================================================
//
//       Class Name:	GeneralPopulationController
//      Description:	Base class for all enemy AI
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class GeneralPopulationController extends AsylumMonsterController;

var AsylumPlayerPawn playerPawn;
var int rn;

function SetInitialState()
{
	GoToState('GenPopIdle');
}

event SeePlayer(Pawn SeenPlayer)
{
    if(SeenPlayer.IsA('AsylumPlayerPawn'))
    {
		enemy = SeenPlayer;
        bEnemyIsVisible = true;
	}
}

state GenPopIdle
{
	function BeginState()
	{
		//Log("Entering CopIdle Begin State");
		Enable('Timer');
	}

	function Timer()
	{
		//Log("Checking For Enemey");
		SeePlayer(playerPawn);
		if(bEnemyIsVisible)
		{
			//Log("Enemy Found!");
			GoToState('MoveToEnemy');
		}
	}
}

state MoveToEnemy
{
	function BeginState()
	{
		Enable('Timer');
	}

	function Timer()
	{
		GoToState('MoveToEnemy', 'Moving');
	}

Moving:
		//Log("Moving Toward Enemy");
		MoveToward(enemy, , 50);
		GoToState('Charging', 'Begin');

}

state Sleeping
{
Begin:
	rn = rand(2);
	rn++;
	sleep(rn);
	GoToState('MoveToEnemy', 'Moving');
}

defaultproperties
{
PawnClass=Class'AsylumGame.GeneralPopulationPawn'
}
