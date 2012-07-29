//==============================================================================
//
//       Class Name:	MutiePawn
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class MutiePawn extends AsylumMonsterPawn;

function RangedAttack(Actor A)
{
	local float slpRange;
	if ( bShotAnim )
		return;
	if ( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius )
	{
		//Log("Attacking Player!");
		if ( MeleeDamageTarget(7, 1.0 * Normal(Controller.Target.Location - Location)) )
		{
			SetAnimAction('Attack');
			PlaySound(sound'pwhip1br', SLOT_Interact);
		}
	}
	else
	{
		//Log("Not Attacking - too far away!");
		SetAnimAction('Idle');
		Controller.GoToState('MoveToEnemy', 'Moving');
	}
	slpRange = VSize(Location - A.Location);
	//Log("stuff:"@slpRange);
	if (slpRange < 75)
	{
		Controller.GoToState('Sleeping', 'Begin');
	}

	Controller.bPreparingMove = true;
	Acceleration = vect(0, 0, 0);
	bShotAnim = true;
}

defaultproperties
{
    ControllerClass=Class'AsylumGame.MutieController'
    Mesh=SkeletalMesh'AsylumCharacters.Mutie'
    Skins(0)=AsylumTextures.Characters.mutietexture
     MovementAnims(0)="Run"
     MovementAnims(1)="Run"
     MovementAnims(2)="Run"
     MovementAnims(3)="Run"
     TurnLeftAnim="Turn_Left"
     TurnRightAnim="Turn_Right"
     WalkAnims(0)="Walk"
     WalkAnims(1)="Walk"
     WalkAnims(2)="Walk"
     WalkAnims(3)="Walk"
	TakeOffAnims(0)="Jump"
	TakeOffAnims(1)="Jump"
	TakeOffAnims(2)="Jump"
	TakeOffAnims(3)="Jump"
	AirAnims(0)="Jump_Mid"
	AirAnims(1)="Jump_Mid"
	AirAnims(2)="Jump_Mid"
	AirAnims(3)="Jump_Mid"
	LandAnims(0)="Jump_Land"
	LandAnims(1)="Jump_Land"
	LandAnims(2)="Jump_Land"
	LandAnims(3)="Jump_Land"
WalkingPct=0.0
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
    Health=15
}
