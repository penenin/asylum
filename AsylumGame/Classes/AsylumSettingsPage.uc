//==============================================================================
//
//       Class Name:  	AsylumSettingsPage
//      Description:	
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
// Modified version of GUI2K4.UT2K4SettingsPage
//==============================================================================
class AsylumSettingsPage extends AsylumMainPage;

//#exec OBJ LOAD FILE=InterfaceContent.utx
#exec OBJ LOAD FILE="..\Asylum\Textures\AsylumTextures.utx"

var Automated GUIButton b_Back;
var Automated GUIButton b_Apply, b_Reset;

var() config bool                 bApplyImmediately;  // Whether to apply changes to setting immediately

var() editconst noexport float               SavedPitch;
var() string PageCaption;
var() GUIButton SizingButton;
var() Settings_Tabs ActivePanel;
var localized string InvalidStats;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local rotator PlayerRot;
    local int i;

    Super.InitComponent(MyController, MyOwner);
    PageCaption = t_Header.Caption;

    GetSizingButton();


    // Set camera's pitch to zero when menu initialised (otherwise spinny weap goes kooky)
    PlayerRot = PlayerOwner().Rotation;
    SavedPitch = PlayerRot.Pitch;
    PlayerRot.Pitch = 0;
    PlayerRot.Roll = 0;
    PlayerOwner().SetRotation(PlayerRot);

	for ( i = 0; i < PanelCaption.Length && i < PanelClass.Length && i < PanelHint.Length; i++ )
	{
		Profile("Settings_" $ PanelCaption[i]);
		c_Tabs.AddTab(PanelCaption[i], PanelClass[i],, PanelHint[i]);
		Profile("Settings_" $ PanelCaption[i]);
	}

}

function GetSizingButton()
{
    local int i;

    SizingButton = None;
    for (i = 0; i < Components.Length; i++)
    {
        if (GUIButton(Components[i]) == None)
            continue;

        if ( SizingButton == None || Len(GUIButton(Components[i]).Caption) > Len(SizingButton.Caption))
            SizingButton = GUIButton(Components[i]);
    }
}

function bool InternalOnPreDraw(Canvas Canvas)
{
    local int X, i;
    local float XL,YL;

    if (SizingButton == None)
        return false;

    SizingButton.Style.TextSize(Canvas, SizingButton.MenuState, SizingButton.Caption, XL, YL, SizingButton.FontScale);

    XL += 32;
    X = Canvas.ClipX - XL;
    for (i = Components.Length - 1; i >= 0; i--)
    {
        if (GUIButton(Components[i]) == None)
            continue;

        Components[i].WinWidth = XL;
        Components[i].WinLeft = X;
        X -= XL;
    }

    return false;
}

function bool InternalOnCanClose(optional bool bCanceled)
{
    return true;
}

function InternalOnClose(optional Bool bCanceled)
{
    local rotator NewRot;

    // Reset player
    NewRot = PlayerOwner().Rotation;
    NewRot.Pitch = SavedPitch;
    PlayerOwner().SetRotation(NewRot);

    Super.OnClose(bCanceled);
}

function InternalOnChange(GUIComponent Sender)
{
	Super.InternalOnChange(Sender);

	if ( c_Tabs.ActiveTab == None )
		ActivePanel = None;
	else ActivePanel = Settings_Tabs(c_Tabs.ActiveTab.MyPanel);
}

function BackButtonClicked()
{
	if ( InternalOnCanClose(False) )
	{
   	c_Tabs.ActiveTab.OnDeActivate();
        Controller.CloseMenu(False);
    }
}


function DefaultsButtonClicked()
{
	ActivePanel.ResetClicked();
}

function bool ButtonClicked(GUIComponent Sender)
{
    ActivePanel.AcceptClicked();
    return true;
}

event bool NotifyLevelChange()
{
	bPersistent = false;
	LevelChanged();
	return true;
}

defaultproperties
{
     bApplyImmediately=True
     InvalidStats="Invalid Stats Info"
     Begin Object Class=GUIHeader Name=SettingHeader
         Caption="Settings"
         RenderWeight=0.300000
     End Object
     t_Header=AsylumGame.AsylumSettingsPage.SettingHeader

     Begin Object Class=AsylumSettings_Footer Name=SettingFooter
         RenderWeight=0.300000
         TabOrder=4
         OnPreDraw=SettingFooter.InternalOnPreDraw
     End Object
     t_Footer=AsylumSettings_Footer'AsylumGame.AsylumSettingsPage.SettingFooter'
/*
     PanelClass(0)="AsylumGame.AsylumTab_DetailSettings"
     PanelClass(1)="AsylumGame.AsylumTab_AudioSettings"
     PanelClass(2)="AsylumGame.AsylumTab_IForceSettings"
     PanelCaption(0)="Display"
     PanelCaption(1)="Audio"
     PanelCaption(2)="Input"
     PanelHint(0)="Select your resolution or change your display and detail settings..."
     PanelHint(1)="Adjust your audio experience..."
     PanelHint(2)="Configure misc. input options..."
*/
     OnClose=AsylumSettingsPage.InternalOnClose
     OnCanClose=AsylumSettingsPage.InternalOnCanClose
     OnPreDraw=AsylumSettingsPage.InternalOnPreDraw
}
