//==============================================================================
//
//       Class Name:	AsylumMenuMenu
//      Description:
//
//	Copyright (C) 2004 Team Asylum
//
//==============================================================================

class AsylumMainMenu extends UT2K4GUIPage;

#exec OBJ LOAD FILE="..\Asylum\Textures\AsylumTextures.utx"

var automated BackgroundImage i_BkChar;
var automated BackgroundImage i_Background;
var automated GUIImage i_AsylumLogo;
var automated GUIImage i_Asylum_Menu_Text;
var automated GUIButton b_NewGame;
var automated GUIButton b_ResumeGame;
var automated GUIButton b_Settings;
var automated GUIButton b_Credits;
var automated GUIButton b_Quit;

var bool bAllowClose;
var GUIButton Selected;
var() bool bNoInitDelay;
var() config string MenuSong;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
		Super.InitComponent(MyController, MyOwner);
}

event Timer()
{
	bNoInitDelay = true;
    if (!Controller.bQuietMenu)
	    PlayerOwner().PlaySound(SlideInSound,SLOT_None);
}

//function MenuIn_OnArrival(GUIComponent Sender, EAnimationType Type);

event Opened(GUIComponent Sender)
{
	if ( bDebugging )
		log(Name$".Opened()   Sender:"$Sender,'Debug');

    if ( Sender != None && PlayerOwner().Level.IsPendingConnection() )
    	PlayerOwner().ConsoleCommand("CANCEL");

    Super.Opened(Sender);

    Selected = none;
}

function MenuIn_Done(GUIComponent Sender, EAnimationType Type)
{
	Sender.OnArrival = none;
    PlayPopSound(Sender,Type);
}

function PlayPopSound(GUIComponent Sender, EAnimationType Type)
{
    if (!Controller.bQuietMenu)
		PlayerOwner().PlaySound(PopInSound);
}

function MainReopened()
{
	if ( !PlayerOwner().Level.IsPendingConnection() )
	{
		Opened(none);
		Timer();
	}
}

function InternalOnOpen()
{
    if (bNoInitDelay)
    	Timer();
    else
	    SetTimer(0.5,false);

	Controller.PerformRestore();
    PlayerOwner().ClientSetInitialMusic(MenuSong,MTRAN_Segue);
}

function OnClose(optional Bool bCancelled)
{
}

function bool MyKeyEvent(out byte Key,out byte State,float delta)
{
	if(Key == 0x1B && state == 1)	// Escape pressed
		bAllowClose = true;

	return false;
}

function bool CanClose(optional bool bCancelled)
{
	if(bAllowClose)
		ButtonClick(b_Quit);

	bAllowClose = False;
	return PlayerOwner().Level.IsPendingConnection();
}


function MoveOn()
{
	switch (Selected)
	{
		case b_NewGame:
			Profile("NewGame");
			//Controller.OpenMenu(AsylumGUIController(Controller).GetNewGamePage());
			PlayerOwner().ConsoleCommand("map floor1");
			Profile("NewGame");
			return;

		case b_ResumeGame:
			Profile("ResumeGame");
			//Controller.OpenMenu(AsylumGUIController(Controller).GetResumeGamePage());
			Profile("ResumeGame");
			return;

		case b_Settings:
			Profile("Settings");
			Controller.OpenMenu(AsylumGUIController(Controller).GetSettingsPage());
			Profile("Settings");
			return;

		case b_Credits:
			Profile("Credits");
			//Controller.OpenMenu(AsylumGUIController(Controller).GetCreditsPage());
			Profile("Credits");
			return;

		case b_Quit:
			Profile("Quit");
			Controller.OpenMenu(AsylumGUIController(Controller).GetQuitPage());
			Profile("Quit");
			return;

		default:
			StopWatch(True);
	}
}

function bool ButtonClick(GUIComponent Sender)
{
	if (GUIButton(Sender) != None)
		Selected = GUIButton(Sender);

	if (Selected==None)
    	return false;

    MoveOn();

    return true;
}

function MenuOut_Done(GUIComponent Sender, EAnimationType Type)
{
	Sender.OnArrival = none;
	if ( bAnimating )
		return;

    MoveOn();
}

event bool NotifyLevelChange()
{
	if ( bDebugging )
		log(Name@"NotifyLevelChange  PendingConnection:"$PlayerOwner().Level.IsPendingConnection());

	return PlayerOwner().Level.IsPendingConnection();
}

function bool BkCharDraw(Canvas Canvas)
{
 	return false;
}

defaultproperties
{
     Begin Object Class=BackgroundImage Name=ImgBkChar
         ImageColor=(A=160)
         ImageRenderStyle=MSTY_Normal
         X1=0
         Y1=0
         X2=1024
         Y2=768
         RenderWeight=0.040000
         Tag=0
         OnDraw=AsylumMainMenu.BkCharDraw
     End Object
     i_BkChar=AsylumGame.AsylumMainMenu.ImgBkChar

     Begin Object Class=BackgroundImage Name=PageBackground
         Image=Texture'AsylumTextures.GUI.Asylum_GUI_BG'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Alpha
         X1=0
         Y1=0
         X2=1024
         Y2=768
     End Object
     i_Background=AsylumGame.AsylumMainMenu.PageBackground

	Begin Object Class=GUIImage Name=ImgAsylumLogo
         Image=Material'AsylumTextures.GUI.FB_ATL'
         ImageStyle=ISTY_Justified
         ImageAlign=IMGA_Left
         WinTop=0.05
         WinLeft=0.2
         WinWidth=0.6
         WinHeight=0.5
     End Object
     i_AsylumLogo=AsylumGame.AsylumMainMenu.ImgAsylumLogo

	Begin Object Class=GUIImage Name=ImgAsylumMenuText
		Image=Material'AsylumTextures.GUI.GUI_TextMenu1'
		ImageStyle=ISTY_Justified
		ImageAlign=IMGA_Center
		WinTop=0.008813
        WinLeft=0.095
        WinWidth=1024
        WinHeight=768
    End Object
    i_Asylum_Menu_Text=AsylumGame.AsylumMainMenu.ImgAsylumMenuText

	Begin Object Class=GUIButton Name=NewGameButton
         CaptionAlign=TXTA_Left
         CaptionEffectStyleName="AsylumTextButtonEffect"
         Caption="                                     "
         bUseCaptionHeight=True
         FontScale=FNS_Large
         StyleName="AsylumTextButton"
         Hint="Enter the Asylum if you dare..."
         WinTop=0.368813
         WinLeft=0.299
         WinWidth=0.715022
         WinHeight=0.075000
         TabOrder=0
         bFocusOnWatch=True
         OnClick=AsylumMainMenu.ButtonClick
         OnKeyEvent=NewGameButton.InternalOnKeyEvent
     End Object
     b_NewGame=AsylumGame.AsylumMainMenu.NewGameButton

	 Begin Object Class=GUIButton Name=ResumeGameButton
         CaptionAlign=TXTA_Left
         CaptionEffectStyleName="AsylumTextButtonEffect"
         Caption="                                     "
         bUseCaptionHeight=True
         FontScale=FNS_Large
         StyleName="AsylumTextButton"
         Hint="Resume the game from the last saved checkpoint"
         WinTop=0.449282
         WinLeft=0.299 //0.269246
         WinWidth=0.659899
         WinHeight=0.075000
         TabOrder=1
         bFocusOnWatch=True
         OnClick=AsylumMainMenu.ButtonClick
         OnKeyEvent=ResumeGameButton.InternalOnKeyEvent
     End Object
     b_ResumeGame=AsylumGame.AsylumMainMenu.ResumeGameButton

     Begin Object Class=GUIButton Name=SettingsButton
         CaptionAlign=TXTA_Left
         CaptionEffectStyleName="AsylumTextButtonEffect"
         Caption="                                     "
         bUseCaptionHeight=True
         FontScale=FNS_Large
         StyleName="AsylumTextButton"
         Hint="Change your controls and settings"
         WinTop=0.531000
         WinLeft=0.299
         WinWidth=0.659899
         WinHeight=0.075000
         TabOrder=2
         bFocusOnWatch=True
         OnClick=AsylumMainMenu.ButtonClick
         OnKeyEvent=SettingsButton.InternalOnKeyEvent
     End Object
     b_Settings=AsylumGame.AsylumMainMenu.SettingsButton

     Begin Object Class=GUIButton Name=CreditsButton
         CaptionAlign=TXTA_Left
         CaptionEffectStyleName="AsylumTextButtonEffect"
         Caption="                                     "
         bUseCaptionHeight=True
         FontScale=FNS_Large
         StyleName="AsylumTextButton"
         Hint="Find out who is responsible for all the horror"
         WinTop=0.600919
         WinLeft=0.299
         WinWidth=0.659899
         WinHeight=0.075000
         TabOrder=3
         bFocusOnWatch=True
         OnClick=AsylumMainMenu.ButtonClick
         OnKeyEvent=CreditsButton.InternalOnKeyEvent
     End Object
     b_Credits=AsylumGame.AsylumMainMenu.CreditsButton

     Begin Object Class=GUIButton Name=QuitButton
         CaptionAlign=TXTA_Left
         CaptionEffectStyleName="AsylumTextButtonEffect"
         Caption="                                     "
         bUseCaptionHeight=True
         FontScale=FNS_Large
         StyleName="AsylumTextButton"
         Hint="Exit the game"
         WinTop=0.659538
         WinLeft=0.299
         WinWidth=0.659899
         WinHeight=0.075000
         TabOrder=4
         bFocusOnWatch=True
         OnClick=AsylumMainMenu.ButtonClick
         OnKeyEvent=QuitButton.InternalOnKeyEvent
     End Object
     b_Quit=AsylumGame.AsylumMainMenu.QuitButton

     MenuSong="KR-UT2004-Menu"
     bDisconnectOnOpen=True
     bAllowedAsLast=True
     OnOpen=AsylumMainMenu.InternalOnOpen
     OnReOpen=AsylumMainMenu.MainReopened
     OnCanClose=AsylumMainMenu.CanClose
     WinTop=0.000000
     WinHeight=1.000000
     bDebugging=True
     OnKeyEvent=AsylumMainMenu.MyKeyEvent
}
