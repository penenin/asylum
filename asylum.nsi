; Asylum.nsi

; MODERN UI
!include "MUI.nsh" 
!include "LogicLib.nsh"

!define AsylumVersion "ALPHA1b" ; defines the constant "AsylumVersion"

Name "Asylum"                       ; Name (e.g. in title of window)
OutFile "Asylum-${AsylumVersion}.exe" ; Will Output "Asylum100.exe"
SetCompressor LZMA                 ; We will use LZMA for best compression
InstallDir "C:\UT2004"
InstallDirRegKey HKLM "Software\Unreal Technology\Installed Apps\UT2004" "Folder"

; INTERFACE SETTINGS 
; The MODERN UI needs this 
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_ABORTWARNING

; PAGES
; The pages the setup will have.
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; LANGUAGES
!insertmacro MUI_LANGUAGE "English"

; SECTIONS
Section "Asylum" Asylum

ReadINIStr $R0 "$INSTDIR\System\UT2004.ini" "FirstRun" "FirstRun"
DetailPrint "Detected UT Version:"
DetailPrint $R0

${Switch} $R0

  ${Case} "3186"
  ${Case} "3197"
  ${Case} "3200"
  ${Case} "3203"
  ${Case} "3204"
  ${Case} "3223"
  ${Case} "3227"
  ${Case} "3229"
  ${Case} "3233"
  ${Case} "3236"
	Messagebox MB_YESNO|MB_ICONINFORMATION \
	"Your UT Version is outdated! Update now?" \
	IDYES patch IDNO nopatch
	${Break}
  ${Case} "3270"
	Messagebox MB_OK|MB_ICONINFORMATION \
	"UT2004 version check successfull."
	${Break}	
  ${Case} "0"
	Messagebox MB_OK|MB_ICONINFORMATION \
	"No Version Information (Version 0 reported). You should start UT2004 at least once before installing Asylum."
	${Break}
  ${Case} ""
	Messagebox MB_OK|MB_ICONINFORMATION \
	"No UT version detected! (Could not find UT2004.ini)"
	${Break}
  ${Default}
	Messagebox MB_OK|MB_ICONINFORMATION \
	"Unknown UT2004 Version. Install anyway, if there is trouble check for an Asylum update."	

${EndSwitch}

Goto nopatch

  patch: 
  ; This will download the 3270 patch (if neccessary) from yoururl.com
  ; You have to provide a direct download mirror here. 
    NSISdl::download http://iadfillvip.xlontech.net/100083/games/unrealtourn2k4/ut2004-winpatch3270.exe ut2004-winpatch3270.exe
    ; Setup will wait until patching is done and then continue
    ExecWait "ut2004-winpatch3270.exe"
    Goto nopatch
  nopatch:

SetOutPath "$INSTDIR\Asylum\Animations"
File .\Animations\AsylumWeapons.ukx
File .\Animations\AsylumCharacters.ukx
SetOutPath "$INSTDIR\Asylum\Help"
File .\Help\AsylumLogo.bmp
SetOutPath "$INSTDIR\Asylum\Maps"
File .\Maps\floor1.ut2
SetOutPath "$INSTDIR\Asylum\Music"
File .\Music\Background.ogg
File .\Music\constant.ogg
File .\Music\fight.ogg
File .\Music\nice.ogg
File .\Music\opening.ogg
File .\Music\phil.ogg
File .\Music\what.ogg
File .\Music\word.ogg
SetOutPath "$INSTDIR\Asylum\Sounds"
File .\Sounds\AsylumSounds.uax
SetOutPath "$INSTDIR\Asylum\StaticMeshes"
File .\StaticMeshes\AsylumPossibles.usx
File .\StaticMeshes\AsylumStaticMeshes.usx
SetOutPath "$INSTDIR\Asylum\System"
File .\System\AsylumGame.u
File .\System\AsylumGame.ucl
File .\System\default.ini
File .\System\defuser.ini
SetOutPath "$INSTDIR\Asylum\Textures"
File .\Textures\AsylumHeartbeat.utx
File .\Textures\AsylumTextures.utx
SetOutPath "$INSTDIR\Asylum\"
File .\Asylum.exe
File .\UT2K4Mod.ini
SectionEnd

Section "" Main
CreateDirectory "$SMPROGRAMS\Asylum"
CreateShortCut "$SMPROGRAMS\Asylum\Asylum.lnk"  "$INSTDIR\Asylum\Asylum.exe"
CreateShortCut "$SMPROGRAMS\Asylum\Uninstall.lnk"  "$INSTDIR\Asylum\Uninstall.exe"
; Uninstaller
WriteUninstaller "$INSTDIR\Asylum\Uninstall.exe"  
SectionEnd

LangString DESC_Asylum ${LANG_ENGLISH} "Asylum Core (required) - The files you need to play Asylum."

  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Asylum} $(DESC_Asylum)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "Uninstall"
RMDir /r "$INSTDIR\Asylum"    ; removes the installation directory and files recursively.
RMDIR /r "$SMPROGRAMS\Asylum" ; removes the start menu directory and files recursively.
SectionEnd