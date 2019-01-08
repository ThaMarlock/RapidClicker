#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 50

;First the Variable declaration
vSleepTime = 10

Gui 1:+AlwaysOnTop
Gui 1:Add, Text, y10 w100 vActive, Active
Gui 1:Add, Text, x+5 y10 w100 vDelayStatus, %vSleepTime%

Gui 1:Show
Return

GuiEscape:
GuiClose:
ExitApp

;All Button Functions
F6::
    vSleepTime += 1
    GuiControl,Text, DelayStatus, %vSleepTime%
    Return
F7::
    vSleepTime := vSleepTime - 1
    GuiControl,Text, DelayStatus, %vSleepTime%
    Return
F5::
    Suspend, off
    GuiControl,Text, Active, Active
    Return
F8::
    Suspend, on
    GuiControl,Text, Active, Deactive
    Return
LButton::
    Loop
    {
        SetMouseDelay %vSleepTime%
        Click
        If (GetKeyState("LButton","P")=0)
            Break
    }
    Return
