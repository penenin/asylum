//==============================================================================
//
//       Class Name:  	AsylumGameType
//      Description:  	Defines our mod's game type
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumGameType extends Deathmatch;

function PreBeginPlay()
{
	Super.PreBeginPlay();
	Level.MaxRagdolls = 100;
}

function RestartPlayer( Controller aPlayer )
{
	if( aPlayer.isA( 'AsylumPlayerController' ) )
		Super.RestartPlayer(aPlayer);
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn)
{
}

function bool AddBot(optional string botName)
{
	return true;
}

static function bool AllowMutator(string MutatorClassName)
{
	if(MutatorClassName == Default.MutatorClass)
		return true;

	return false;
}

function ChangeName(Controller Other, string S, bool bNameChange)
{
}

defaultproperties
{
     bQuickStart=True
     CountDown=0
     TimeLimit=0
     GoalScore=0
     HUDType="AsylumGame.AsylumHUD"
     PlayerControllerClass=Class'AsylumGame.AsylumPlayerController'
     PlayerControllerClassName="AsylumGame.AsylumPlayerController"
     DefaultEnemyRosterClass="AsylumGame.AsylumRoster"
     DefaultPlayerClassName="AsylumGame.AsylumPlayerPawn"
}
