//==============================================================================
//
//       Class Name:  	AsylumSettings_Footer
//      Description:	
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
// Modified version of GUI2K4.UT2K4Settings_Footer
//==============================================================================

class AsylumSettings_Footer extends ButtonFooter;

var automated GUIButton b_Back, b_Defaults;
var AsylumSettingsPage SettingsPage;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController,MyOwner);
    SettingsPage = AsylumSettingsPage(MyOwner);
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==b_Back)
    	SettingsPage.BackButtonClicked();

    else if (Sender==b_Defaults)
    	SettingsPage.DefaultsButtonClicked();

	return true;
}

defaultproperties
{
     Begin Object Class=GUIButton Name=BackB
         Caption="BACK"
         StyleName="FooterButton"
         Hint="Return to the previous menu"
         WinTop=0.085678
         WinHeight=0.036482
         //RenderWeight=2.000000
         TabOrder=1
         bBoundToParent=True
         OnClick=AsylumSettings_Footer.InternalOnClick
         OnKeyEvent=BackB.InternalOnKeyEvent
     End Object
     b_Back=AsylumGame.AsylumSettings_Footer.BackB

     Begin Object Class=GUIButton Name=DefaultB
         Caption="DEFAULTS"
         StyleName="FooterButton"
         Hint="Reset all settings on this page to their default values"
         WinTop=0.085678
         WinLeft=0.885352
         WinWidth=0.114648
         WinHeight=0.036482
         //RenderWeight=2.000000
         TabOrder=0
         bBoundToParent=True
         OnClick=AsylumSettings_Footer.InternalOnClick
         OnKeyEvent=DefaultB.InternalOnKeyEvent
     End Object
     b_Defaults=AsylumGame.AsylumSettings_Footer.DefaultB

}
