class AsylumWeapon extends Weapon;

var ESurfaceTypes WallSurfaceType;

event ZoneChange( ZoneInfo NewZone ){
	

	if (NewZone.IsA('AsylumZoneInfo')){
		Log("Got AsylumZoneInfo");
		WallSurfaceType = AsylumZoneInfo(NewZone).WallSurfaceType;
		
	}else{
		WallSurfaceType = EST_Default;
	}

	
}


simulated function ESurfaceTypes GetWallSurfaceType(){
	return(WallSurfaceType);
}

defaultproperties{
	WallSurfaceType = EST_Default
}