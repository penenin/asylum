class DelayedInstantFire extends InstantFire;


var float TimeBeforeTrace;
var sound DelayedFireSound;

enum ESurfaceTypes // also defined in actor class and texture class
{
	EST_Default,
	EST_Rock,
	EST_Dirt,
	EST_Metal,
	EST_Wood,
	EST_Plant,
	EST_Flesh,
    EST_Ice,
    EST_Snow,
    EST_Water,
    EST_Glass,
    EST_Custom00,
    EST_Custom01,
    EST_Custom02,
    EST_Custom03,
    EST_Custom04,
    EST_Custom05,
    EST_Custom06,
    EST_Custom07,
    EST_Custom08,
    EST_Custom09,
    EST_Custom10,
    EST_Custom11,
    EST_Custom12,
    EST_Custom13,
    EST_Custom14,
    EST_Custom15,
    EST_Custom16,
    EST_Custom17,
    EST_Custom18,
    EST_Custom19,
    EST_Custom20,
    EST_Custom21,
    EST_Custom22,
    EST_Custom23,
    EST_Custom24,
    EST_Custom25,
    EST_Custom26,
    EST_Custom27,
    EST_Custom28,
    EST_Custom29,
    EST_Custom30,
    EST_Custom31,
};


simulated function PlayHitSound(ESurfaceTypes Surface);
simulated function PlayWallHitSound(){
	PlayHitSound(ESurfaceTypes(AsylumWeapon(Weapon).GetWallSurfaceType()));
}
simulated function ProcessHit(Actor Other){
	
	if (Other.IsA('ZoneInfo')){

		PlayWallHitSound();
		

	}
	
	if (Other.IsA('StaticMeshActor')){
		Log("Hit a Static Mesh");
		

		Log(Other.UV2Texture.SurfaceType);
		PlayHitSound(ESurfaceTypes(Other.UV2Texture.SurfaceType));
	}
	



}
function DoTrace(Vector Start, Rotator Dir)
{
    local Vector X, End, HitLocation, HitNormal, RefNormal;
    local Actor Other;
    local int Damage;
    local bool bDoReflect;
    local int ReflectNum;

	MaxRange();

    ReflectNum = 0;
    while (true)
    {
        bDoReflect = false;
        X = Vector(Dir);
        End = Start + TraceRange * X;

        Other = Weapon.Trace(HitLocation, HitNormal, End, Start, true);

        if ( Other != None && (Other != Instigator || ReflectNum > 0) )
        {
			ProcessHit(Other);
            if (bReflective && Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, DamageMin*0.25))
            {
                bDoReflect = true;
                HitNormal = Vect(0,0,0);
            }
            else if ( !Other.bWorldGeometry )
            {
				Damage = DamageMin;
				if ( (DamageMin != DamageMax) && (FRand() > 0.5) )
					Damage += Rand(1 + DamageMax - DamageMin);
                Damage = Damage * DamageAtten;

				// Update hit effect except for pawns (blood) other than vehicles.
               	if ( Other.IsA('Vehicle') || (!Other.IsA('Pawn') && !Other.IsA('HitScanBlockingVolume')) )
					WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other, HitLocation, HitNormal);

               	Other.TakeDamage(Damage, Instigator, HitLocation, Momentum*X, DamageType);
                HitNormal = Vect(0,0,0);
            }
            else if ( WeaponAttachment(Weapon.ThirdPersonActor) != None )
				WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other,HitLocation,HitNormal);
        }
        else
        {
            HitLocation = End;
            HitNormal = Vect(0,0,0);
			WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other,HitLocation,HitNormal);
        }

        SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);

        if (bDoReflect && ++ReflectNum < 4)
        {
            //Log("reflecting off"@Other@Start@HitLocation);
            Start = HitLocation;
            Dir = Rotator(RefNormal); //Rotator( X - 2.0*RefNormal*(X dot RefNormal) );
        }
        else
        {
            break;
        }
    }
}

function DoFireEffect()
{


	SetTimer(TimeBeforeTrace, false);
	
}
event Timer(){

	
	Super.DoFireEffect();
	Weapon.PlaySound(DelayedFireSound);
	

}

defaultproperties
{
	TimeBeforeTrace=0.5
	DelayedFireSound = Sound'WeaponSounds.PBioRifleGoo2.P1BioRifleGoo2'
	
}