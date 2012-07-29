//==============================================================================
//
//       Class Name:	LittleGirlController
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class LittleGirlController extends AsylumMonsterController;

var AsylumPlayerPawn playerPawn;

function SetInitialState()
{
	GoToState('LittleGirlIdle');
}

event SeePlayer(Pawn SeenPlayer)
{
    if(SeenPlayer.IsA('AsylumPlayerPawn'))
    {
		enemy = SeenPlayer;
        bEnemyIsVisible = true;
	}
}

state LittleGirlIdle
{
	function BeginState()
	{
		Log("Entering CopIdle Begin State");
		Enable('Timer');
	}

	function Timer()
	{
		Log("Checking For Enemey");
		SeePlayer(playerPawn);
		if(bEnemyIsVisible)
		{
			Log("Enemy Found!");
			LittleGirlPawn(Pawn).SetAnimAction('beckon');
		}
	}
}

defaultproperties
{
	PawnClass=Class'AsylumGame.LittleGirlPawn'
}
