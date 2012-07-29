//==============================================================================
//
//       Class Name:	Dolly
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class LittleGirlPawn extends AsylumMonsterPawn;

defaultproperties
{
    ControllerClass=Class'AsylumGame.LittleGirlController'
    Mesh=Mesh'AsylumCharacters.LittleGirl'
    Skins(0)=AsylumTextures.Characters.littlegirl_body
    Skins(1)=AsylumTextures.Characters.littlegirl_head
     MovementAnims(0)="Run"
     MovementAnims(1)="Run"
     MovementAnims(2)="Run"
     MovementAnims(3)="Run"
     TurnLeftAnim="left_Turn"
     TurnRightAnim="right_Turn"
     WalkAnims(0)="Walk"
     WalkAnims(1)="Walk"
     WalkAnims(2)="Walk"
     WalkAnims(3)="Walk"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     Health=10
}
