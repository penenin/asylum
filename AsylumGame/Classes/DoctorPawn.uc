//==============================================================================
//
//       Class Name:	DoctorPawn
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class DoctorPawn extends AsylumMonsterPawn;

defaultproperties
{
    HealthMax=10
	ControllerClass=class'AsylumGame.DoctorController'
	Mesh=SkeletalMesh'AsylumCharacters.Doctor'
	//Skins(0)=Texture'AsylumTextures.Characters.generalpop1'
}
