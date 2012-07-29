class GeneralPopulationPawn extends AsylumMonsterPawn
    abstract;

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
    HealthMax=10
	ControllerClass=class'AsylumGame.GeneralPopulationController'
	MovementAnims(0)=Run
	MovementAnims(1)=Run
	MovementAnims(2)=Run
	MovementAnims(3)=Run
	WalkAnims(0)=Walk
	WalkAnims(1)=Walk
	WalkAnims(2)=Walk
	WalkAnims(3)=Walk
	IdleRestAnim=Stand_Idle
	IdleCrouchAnim=Curled_idle
}
