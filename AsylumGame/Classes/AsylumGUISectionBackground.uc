 //==============================================================================
//
//       Class Name:  	AsylumGUISectionBackground
//      Description:	
//           
//	Copyright (C) 2004 Team Asylum	
//
//==============================================================================
// Modified version of GUI2K4.GUISectionBackground
//==============================================================================

class AsylumGUISectionBackground extends GUISectionBackground;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    if (CaptionStyleName!="")
        CaptionStyle = Controller.GetStyle(CaptionStyleName,FontScale);

}

event SetVisibility(bool bIsVisible)
{
    local int i;

    Super.SetVisibility(bIsVisible);

    for (i=0;i<AlignStack.Length;i++)
        AlignStack[i].SetVisibility(bIsVisible);
}


// Components that are manage by the section background are auto aligned and placed
function bool ManageComponent(GUIComponent Component)
{
    local int i;

    if ( Component == None )
        return false;

    i = FindComponentIndex(Component);
    if ( i == -1 )
    {
        if ( bRemapStack )
        {
            for (i=0;i<AlignStack.Length;i++)
            {
                if (AlignStack[i].TabOrder > Component.TabOrder)
                    break;
            }
        }
        else i = AlignStack.Length;

        AlignStack.Insert(i, 1);
        AlignStack[i]=Component;

        return true;
    }

    return false;
}

function bool UnmanageComponent( GUIComponent Comp )
{
    local int i;

    i = FindComponentIndex(Comp);
    if ( i != -1 && i >= 0 && i < AlignStack.Length )
    {
        AlignStack.Remove(i,1);
        return true;
    }

    return false;
}

function int FindComponentIndex( GUIComponent Comp )
{
    local int i;

    if ( Comp == None )
        return -1;

    for ( i = 0; i < AlignStack.Length; i++ )
        if ( AlignStack[i] == Comp )
            return i;

    return -1;
}

function Reset()
{
    AlignStack.Remove( 0, AlignStack.Length );
    bInit = true;
}

function bool InternalPreDraw(Canvas C)
{
    local float AL, AT, AW, AH, LPad, RPad, TPad, BPad;

    if ( AlignStack.Length == 0 )
        return false;

    AL = ActualLeft();
    AT = ActualTop();
    AW = ActualWidth();
    AH = ActualHeight();

    LPad = (LeftPadding   * AW) + ImageOffset[0];
    TPad = (TopPadding    * AH) + ImageOffset[1];
    RPad = (RightPadding  * AW) + ImageOffset[2];
    BPad = (BottomPadding * AH) + ImageOffset[3];

    if ( Style != none )
    {
        LPad += BorderOffsets[0];
        TPad += BorderOffsets[1];
        RPad += BorderOffsets[2];
        BPad += BorderOffsets[3];
    }

    AutoPosition( AlignStack,
        AL, AT, AL + AW, AT + AH,
        LPad, TPad, RPad, BPad,
        NumColumns, ColPadding );

    return false;
}

event ResolutionChanged(int ResX, int ResY)
{
    Super.ResolutionChanged(ResX, ResY);
    bInit = True;
}

function SetPosition( float NewLeft, float NewTop, float NewWidth, float NewHeight, optional bool bRelative )
{
    Super.SetPosition(NewLeft,NewTop,NewWidth,NewHeight,bRelative);
    bInit = true;
}

defaultproperties
{
    OnPreDraw=InternalPreDraw
    CaptionStyleName="TextLabel"
    FontScale=FNS_Small 
    HeaderTop=material'AsylumTextures.GUI_OPTIONS.Asylum_settings_tickBlur'	//ComboTickFocused
    HeaderBar=material'AsylumTextures.GUI_OPTIONS.Asylum_settings_sliderempty'
    HeaderBase=material'AsylumTextures.GUI_OPTIONS.Asylum_settings_bg_gui'		//asylum_settings_switch2
    TopPadding=0
    LeftPadding=0.05
    RightPadding=0.05
   BottomPadding=0
    ColPadding=0.05

    ImageOffset(0)=16
    ImageOffset(1)=44
    ImageOffset(2)=16
    ImageOffset(3)=18

    NumColumns=1
    bFillClient=false
    RenderWeight=0.09
    bRemapStack=True
}