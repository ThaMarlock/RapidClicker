#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 1000

;-------------VARIABLEN----------------
;bool
bVar_Status := False
bVar_Random := False
bVar_Burst := False
;--------------------------------------

;-------------HOTKEY DE-/ACTIVE--------
Hotkey, LButton, Off
;--------------------------------------

;-------------INITFILE-----------------
;read config.ini file
inifile = config.ini
;read all keys
IniRead, kVar_SwitchOnOff, %inifile%, KeyList, ActivSwitch
IniRead, kVar_DelayPlus, %inifile%, KeyList, DelayPlus
IniRead, kVar_DelayMinus, %inifile%, KeyList, DelayMinus
IniRead, kVar_RandomOnOff, %inifile%, KeyList, RandomDuration
IniRead, kVar_BurstOnOff, %inifile%, KeyList, BurstSwitch
IniRead, kVar_BurstDurationPlus, %inifile%, KeyList, BurstDurationPlus
IniRead, kVar_BurstDurationMinus, %inifile%, KeyList, BurstDurationMinus
IniRead, kVar_BurstTickPlus, %inifile%, KeyList, BurstTickPlus
IniRead, kVar_BurstTickMinus, %inifile%, KeyList, BurstTickMinus
;read all values
;int
IniRead, iVar_MinDelay, %inifile%, Default, MinTimeDelay
IniRead, iVar_MaxDelay, %inifile%, Default, MaxTimeDelay
IniRead, iVar_MinRandomTime, %inifile%, Default, MinRandomTime
IniRead, iVar_MaxRandomTime, %inifile%, Default, MaxRandomTime
IniRead, iVar_Delay, %inifile%, Default, DelayTime
IniRead, iVar_BurstDuration, %inifile%, Default, BurstDurationTime
IniRead, iVar_BurstTicks, %inifile%, Default, BurstTicks
;--------------------------------------

;-------------METHODEN CALL------------
Hotkey, %kVar_SwitchOnOff%, F_SwitchOnOff
Hotkey, %kVar_DelayPlus%, F_DelayPlus
Hotkey, %kVar_DelayMinus%, F_DelayMinus
Hotkey, %kVar_RandomOnOff%, F_RandomOnOff
Hotkey, %kVar_BurstOnOff%, F_BurstOnOff
Hotkey, %kVar_BurstDurationPlus%, F_BurstDurationPlus
Hotkey, %kVar_BurstDurationMinus%, F_BurstDurationMinus
Hotkey, %kVar_BurstTickPlus%, F_BurstTickPlus
Hotkey, %kVar_BurstTickMinus%, F_BurstTickMinus
;--------------------------------------

;-------------UI-----------------------
Gui 1:+AlwaysOnTop
Gui 1:Add, Text, x5 y10 w80 h20, Status:
Gui 1:Add, Text, y+5 w80 h20, Random:
Gui 1:Add, Text, y+5 w80 h20, Burst:
Gui 1:Add, Text, x+5 y10 w80 h20 vGUI_Status, False
Gui 1:Add, Text, y+5 w80 h20 vGUI_RandomStatus, False
Gui 1:Add, Text, y+5 w80 h20 vGUI_BurstStatus, False
Gui 1:Add, Text, x+5 y10 h20 w80 vGUI_Delay, %iVar_Delay%
Gui 1:Add, Text, y+30 h20 w80 vGUI_BurstDuration, %iVar_BurstDuration%
Gui 1:Add, Text, x+5 h20 w80 vGUI_BurstTick, %iVar_BurstTicks%

Gui 1:Show
Return

GuiEscape:
GuiClose:
ExitApp
;--------------------------------------

;-------------METHODEN-----------------
F_SwitchOnOff:
    If (bVar_Status) {
        bVar_Status := False
        Hotkey,LButton,Off
        GuiControl, Text, GUI_Status, False
    } Else {
        bVar_Status := True
        Hotkey,Lbutton,On
        GuiControl, Text, GUI_Status, True
    }
Return

F_DelayPlus:
    iVar_Delay += 1
    GuiControl, Text, GUI_Delay, %iVar_Delay%
Return

F_DelayMinus:
    iVar_Delay -= 1
    GuiControl, Text, GUI_Delay, %iVar_Delay%
Return

F_RandomOnOff:
    If (bVar_Random) {
        bVar_Random := False
        GuiControl, Text, GUI_RandomStatus, False
    } Else {
        bVar_Random := True
        GuiControl, Text, GUI_RandomStatus, True
    }
Return

F_BurstOnOff:
    If (bVar_Burst) {
        bVar_Burst := False
        GuiControl, Text, GUI_BurstStatus, False
    } Else {
        bVar_Burst := True
        GuiControl, Text, GUI_BurstStatus, True
    }
Return

F_BurstDurationPlus:
    iVar_BurstDuration += 1
    GuiControl, Text, GUI_BurstDuration, %iVar_BurstDuration%
Return

F_BurstDurationMinus:
    iVar_BurstDuration -= 1
    GuiControl, Text, GUI_BurstDuration, %iVar_BurstDuration%
Return

F_BurstTickPlus:
    iVar_BurstTicks += 1
    GuiControl, Text, GUI_BurstTick, %iVar_BurstTicks%
Return

F_BurstTickMinus:
    iVar_BurstTicks -= 1
    GuiControl, Text, GUI_BurstTick, %iVar_BurstTicks%
Return
;--------------------------------------

;-------------HOTKEYS FUNCTION---------
LButton::
    If (bVar_Burst) {
        If (bVar_Random) {
            Loop {
                Random, iTemp_Delay, iVar_MinRandomTime, iVar_MaxRandomTime
                SetMouseDelay, %iTemp_Delay%
                Loop %iVar_BurstTicks% {
                    Click
                    Sleep, %iVar_BurstDuration%
                }
                If (GetKeyState("LButton", "P")=0) {
                    Break
                }
            }
        } Else {
            Loop {
                SetMouseDelay, %iVar_Delay%
                Loop, %iVar_BurstTicks% {
                    Click
                    Sleep, %iVar_BurstDuration%
                }
                If (GetKeyState("LButton", "P")=0) {
                    Break
                }
            }
        }
    } Else {
        If (bVar_Random) {
            Loop {
                Random, iTemp_Delay, iVar_MinRandomTime, iVar_MaxRandomTime
                SetMouseDelay, %iVar_Delay%
                Click
                If (GetKeyState("LButton", "P")=0) {
                    Break
                }
            }
        } Else {
            Loop {
                SetMouseDelay, %iVar_Delay%
                Click
                If (GetKeyState("LButton", "P")=0) {
                    Break
                }
            }
        }
    }
Return
;--------------------------------------
;-------------END OF SCRIPT------------
;--------------------------------------