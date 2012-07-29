//==============================================================================
//
//       Class Name:  	AsylumTab_DetailSettings
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================
// Modified version of GUI2K4.UT2K4MainPage
//==============================================================================
class AsylumMainPage extends UT2K4GUIPage;

var automated GUITabControl     c_Tabs;

var automated GUIHeader         t_Header;
var automated GUIButton			d_Display;
var automated GUIButton			a_audio;

var automated GUIImage			i_SettingsMenu;
var automated GUIButton			i_DisplayTab;
var automated GUIButton			i_AudioTab;

var automated ButtonFooter      t_Footer;
var automated BackgroundImage   i_Background;

/** file where the higscores are stored */
var string HighScoreFile;
var private globalconfig string TotalUnlockedCharacters;

var array<string>               PanelClass;
var localized array<string>     PanelCaption;
var localized array<string>     PanelHint;



function InitComponent(GUIController MyC, GUIComponent MyO)
{
    Super.InitComponent(MyC, MyO);

    c_Tabs.MyFooter = t_Footer;
    t_Header.DockedTabs = c_Tabs;
}

function InternalOnChange(GUIComponent Sender);

event Opened(GUIComponent Sender)
{
    Super.Opened(Sender);

    if ( bPersistent && c_Tabs != None && c_Tabs.FocusedControl == None )
        c_Tabs.SetFocus(None);
}


function HandleParameters(string Param1, string Param2)
{
    if ( Param1 != "" )
    {
        if ( c_Tabs != none )
            c_Tabs.ActivateTabByName(Param1, True);
    }
}

function bool GetRestoreParams( out string Param1, out string Param2 )
{
    if ( c_Tabs != None && c_Tabs.ActiveTab != None )
    {
      Param1 = c_Tabs.ActiveTab.Caption;
        return True;
    }

    return False;
}

static function bool UnlockCharacter( string CharName )
{
    local int i;
    local array<string> Unlocked;

    if ( CharName == "" )
        return false;

    Split(default.TotalUnlockedCharacters, ";", Unlocked);
    for ( i = 0; i < Unlocked.Length; i++ )
        if ( Unlocked[i] ~= CharName )
            return false;

    Unlocked[Unlocked.Length] = CharName;

    default.TotalUnlockedCharacters = JoinArray(Unlocked, ";", True);
    StaticSaveConfig();
    return true;
}

// Caution: you must verify that the specified CharName is a locked character by default, before calling this function
static function bool IsUnlocked( string CharName )
{
    return CharName != "" && (InStr(";" $ Caps(default.TotalUnlockedCharacters) $ ";", ";" $ Caps(CharName) $ ";") != -1);
}

defaultproperties
{

    Begin Object Class=GUITabControl Name=PageTabs
        WinWidth=0.5      //0.98
        WinLeft=0.01
        WinTop=0.0
        WinHeight=0.04
        TabHeight=0.04
        TabOrder=3
        RenderWeight=0.49
        bFillSpace=False
        bAcceptsInput=True
        bDockPanels=True
        OnChange=InternalOnChange
        BackgroundStyleName="TabBackground"
    End Object

	Begin Object Class=GUIImage Name=SettingsMenu
		Image=material'AsylumTextures.GUI_OPTIONS.Asylum_settings_bg_gui'
		ImageStyle=ISTY_Normal
		X1=0
		Y1=0
		X2=1024
		Y2=768
		//WinWidth=1
		//WinHeight=1
		WinTop=0.01
		//WinLeft=0
		RenderWeight=0.02
	End Object

/*
	Begin Object Class=GUIButton Name=DisplayTab
		Caption="      "
		Hint="Switch tab to Display"
		WinLeft=2
		WinTop=0.8
		WinWidth=0.15
		WinHeight=0.560000
		//OnClick=LoadMap?
		StyleName="AsylumTabButton"
	End Object
	Controls(0)=GUIButton'DisplayTab'
*/
    Begin Object Class=BackgroundImage Name=PageBackground
        ImageStyle=ISTY_Scaled
        Image=Material'AsylumTextures.GUI_OPTIONS.Asylum_settings_bg'
        ImageRenderStyle=MSTY_Alpha
        X1=0
        Y1=0
        X2=1024
        Y2=1024
    End Object

    WinWidth=1.0
    WinHeight=1.0
    WinLeft=0.0
    WinTop=0.0

    bRenderWorld=False
    bRequire640x480=True
    bPersistent=True
    bRestorable=True

    Background=none
    i_SettingsMenu=SettingsMenu
    i_Background=PageBackground
    c_Tabs=PageTabs
    HighScoreFile="UT2004HighScores"
}

