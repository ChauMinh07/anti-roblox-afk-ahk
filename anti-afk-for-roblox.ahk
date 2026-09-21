;Creator: https://www.facebook.com/cbmchau07/
#Requires AutoHotkey v2.0

;Change this to the button you want to press when switching tabs
;Search codenames for button: https://www.autohotkey.com/docs/v2/KeyList.htm
global button := "="

;Time per checking in miliseconds
global timeToCheck := 1190000 ; miliseconds (1000ms = 1s)

;Processing time when execute the macro (Do not recommend change it)
;Increase it if your game icon is blinking orange in the taskbar
;or simply turn off option "Show flashing on taskbar apps" in Windows Taskbar Settings
global processingTime := 15 ; miliseconds (1000ms = 1s)

;Block any input from your Keyboard and Mouse when checking? and then it will unblock
;true if argee
;false if disagree
;This feature only work if you run script with "Run as administrator" (even with true)
global tempBlockInput := true

;This will ignore tempBlockInput feature when you activating roblox but still send button to prevent afk
;It will not interrupt your experience when you are PvP or when you are gaming on Roblox
;true if argee
;false if disagree
global ignoreTempBlockInput := true

;Move mouse to Roblox windows when checking? and then it will go back
;true if argee
;false if disagree
global moveMouse := false

;Fast close by using hotkey
;Search codenames for button: https://www.autohotkey.com/docs/v2/KeyList.htm
global closeHotkey := "+!5"

























































































































































































































RealRobloxName := "ahk_exe RobloxPlayerBeta.exe"

;if robloxPlatform == "MS" {
;    RealRobloxName := "ahk_exe applicationframehost.exe"
;}
CheckingAdministrator()
CheckingSaveValueForEXE()

AntiAFK() ;demo task
SetTimer(AntiAFK, timeToCheck)

ExitSoftware(*) {
    SaveValue
    ExitApp
}

CheckingAdministrator() {
    if (tempBlockInput && !A_IsAdmin) {
        MsgBox(
            "Cuz you have turned on tempBlockInput feature so please run script with 'Run as administrator'.`n`nTo do that:`n1. Right click on this script`n2. Click 'Run as administrator'",
            "Are you goldfish?")
        ExitApp
    }
}

; Luoi` lam`
CheckingSaveValueForEXE(*) {
    global hGUI := Gui()

    global button
    global timeToCheck
    global tempBlockInput
    global ignoreTempBlockInput
    global moveMouse
    global closeHotkey
    global processingTime

    if A_IsCompiled {

        if !FileExist(A_ScriptDir "\anti-afk-for-roblox-settings.ini") {
            IniWrite button, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "button"
            IniWrite timeToCheck, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "timeToCheck"
            IniWrite processingTime, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "processingTime"
            IniWrite tempBlockInput, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "tempBlockInput"
            IniWrite ignoreTempBlockInput, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "ignoreTempBlockInput"
            IniWrite moveMouse, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "moveMouse"
            IniWrite closeHotkey, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "closeHotkey"

            SaveCheckTimeValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "timeToCheck")
            SaveProcessingTimeValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "processingTime")
            SaveButtonValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "button")
            SaveBlockInputValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "tempBlockInput")
            SaveMoveMouseValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "moveMouse")
            SaveCloseHotkeyValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "closeHotkey")
        } else {
            SaveCheckTimeValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "timeToCheck")
            SaveProcessingTimeValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "processingTime")
            SaveButtonValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "button")
            SaveBlockInputValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "tempBlockInput")
            SaveMoveMouseValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "moveMouse")
            SaveCloseHotkeyValue := IniRead(A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
                "closeHotkey")

            button := SaveButtonValue
            timeToCheck := SaveCheckTimeValue
            processingTime := SaveProcessingTimeValue
            tempBlockInput := SaveBlockInputValue
            moveMouse := SaveMoveMouseValue
            closeHotkey := SaveCloseHotkeyValue
        }
        hGUI.Add("Text", "x0 y5 w200 h20 +BackgroundTrans +Center +cPurple", "Roblox Anti-AFK is Running")

        hGUI.Add("Text", "x22 y30 w190 h25 +BackgroundTrans", "Check Time")
        CheckTimeDescription := hGUI.Add("Button", "x5 y29 w15 h15 +BackgroundTrans", "?")
        global CheckTimeValue := hGUI.Add("Edit", "x110 y28 w65 h18 +Number", SaveCheckTimeValue)
        ;unit value
        hGUI.Add("Text", "x180 y30 w50 h25 +BackgroundTrans", "ms")

        hGUI.Add("Text", "x22 y55 w190 h25 +BackgroundTrans", "Process Time")
        processingTimeDescription := hGUI.Add("Button", "x5 y54 w15 h15 +BackgroundTrans", "?")
        global processingTimeValue := hGUI.Add("Edit", "x110 y53 w65 h18 +Number", SaveProcessingTimeValue)
        ;unit value
        hGUI.Add("Text", "x180 y55 w50 h25 +BackgroundTrans", "ms")

        hGUI.Add("Text", "x22 y80 w190 h25 +BackgroundTrans", "Button")
        ButtonDescription := hGUI.Add("Button", "x5 y79 w15 h15 +BackgroundTrans", "?")
        global ButtonValue := hGUI.Add("Hotkey", "x110 y77 w85 h18", SaveButtonValue)

        hGUI.Add("Text", "x22 y105 w190 h25 +BackgroundTrans", "Block Input")
        BlockInputDescription := hGUI.Add("Button", "x5 y104 w15 h15 +BackgroundTrans", "?")
        global BlockInputValue := hGUI.Add("DropDownList", "x110 y102 w85 h105", [true, false])
        BlockInputValue.Text := SaveBlockInputValue

        hGUI.Add("Text", "x22 y130 w190 h25 +BackgroundTrans", "Move Mouse")
        MoveMouseDescription := hGUI.Add("Button", "x5 y129 w15 h15 +BackgroundTrans", "?")
        global MoveMouseValue := hGUI.Add("DropDownList", "x110 y127 w85 h105", [true, false])
        MoveMouseValue.Text := SaveMoveMouseValue

        CheckTimeValue.OnEvent("Change", SaveValue)
        processingTimeValue.OnEvent("Change", SaveValue)
        ButtonValue.OnEvent("Change", SaveValue)
        BlockInputValue.OnEvent("Change", SaveValue)
        MoveMouseValue.OnEvent("Change", SaveValue)

        CheckTimeDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "CheckTimeDescription"))
        processingTimeDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "processingTimeDescription"))
        ButtonDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "ButtonDescription"))
        BlockInputDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "BlockInputDescription"))
        MoveMouseDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "MoveMouseDescription"))

        global outside := hGUI.Add("Button", "x5 y160 w190 h25 +BackgroundTrans +Center", "Move Roblox off the screen")
        global inside := hGUI.Add("Button", "x5 y190 w190 h25 +BackgroundTrans +Center", "Move Roblox back to the screen")
        global minimizeGui := hGUI.Add("Button", "x5 y220 w190 h25 +BackgroundTrans +Center", "Minimize Gui to system tray")

        tip := hGUI.Add("Text", "x5 y250 w190 h25 +BackgroundTrans +Center", "Delete file settings.ini to reset value")

        global closeHotkeyValue := hGUI.Add("Hotkey", "x20 y275 w90 h18", SaveCloseHotkeyValue)
        tip2 := hGUI.Add("Text", "x100 y276 w90 h18 +BackgroundTrans +Center", " to close app")

        closeHotkeyValue.OnEvent("Change", SaveValue)

        outside.Focus()

        hGUI.Show("w200 h300")
    } else {
        hGUI.Add("Text", "x0 y10 w200 h20 +BackgroundTrans +Center", "Roblox Anti-AFK is Running")

        global outside := hGUI.Add("Button", "x5 y30 w190 h25 +BackgroundTrans +Center", "Move Roblox off the screen")
        global inside := hGUI.Add("Button", "x5 y58 w190 h25 +BackgroundTrans +Center", "Move Roblox back to the screen")
        global minimizeGui := hGUI.Add("Button", "x5 y86 w190 h25 +BackgroundTrans +Center", "Minimize Gui to system tray")
        
        hGUI.Show("w200 h116")
    }

    outside.OnEvent("Click", MoveOutside)
    inside.OnEvent("Click", MoveInside)
    minimizeGui.OnEvent("Click", (*) => hGUI.Hide())
    hGUI.OnEvent("Close", ExitSoftware)

    A_TrayMenu.Add("Show", (*) => hGUI.Show())
    A_TrayMenu.Default := "Show"

    ;Register Event
    if closeHotkey {
        Hotkey(closeHotkey, ExitSoftware)
    }
    
    ;Safety
    if (timeToCheck < 1000 && tempBlockInput) {
        tempBlockInput := false
        BlockInputValue.Text := 0
        MsgBox("BlockInput is disable for safety due to timeToCheck < 1000 ms")
    }

}

ShowDescription(ctrl, info, i) {
    global mouse_desc_x
    global mouse_desc_y
    MouseGetPos(&mouse_desc_x, &mouse_desc_y)

    if (i == "CheckTimeDescription") {
        global timeToCheck
        sTime := timeToCheck / 1000
        mTime := sTime / 60
        ToolTip("Time per checking in miliseconds`n`nCurrent:`nmiliseconds: " timeToCheck "ms`nor seconds: " sTime "s`nor minutes: " mTime "m", mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "processingTimeDescription") {
         ToolTip("Processing time when execute the macro (Do not recommend change it)`nIncrease it if your game icon is blinking orange in the taskbar`nor simply turn off option 'Show flashing on taskbar apps' in Windows Taskbar Settings`n`nCurrent:`nmiliseconds: " processingTime "ms", mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "ButtonDescription") {
        ToolTip(
            "Change this to the button you want to press when (execute macro) switching tabs`nSearch codenames for button: https://www.autohotkey.com/docs/v2/KeyList.htm",
            mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "RobloxPlatformDescription") {
        ToolTip(
            "Roblox Platform of your roblox`n'MS' mean Microsoft Store version (Roblox download from Microsoft Store)`n'WEB' mean Offical version (Roblox download from offical website roblox.com)",
            mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "BlockInputDescription") {
        ToolTip(
            "Block any input from your Keyboard and Mouse when checking? and then it will unblock`n1 if argee`n0 if disargee`nThis feature only work if you run script with 'Run as administrator' (even with option 1)",
            mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "GameIgnoreBIDescription") {
        ToolTip(
            "This will ignore tempBlockInput feature when you activating roblox but still send button to prevent afk`nIt will not interrupt your experience when you are PvP or when you are gaming on Roblox`n1 if argee`n0 if disargee",
            mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "MoveMouseDescription") {
        ToolTip("Move mouse to Roblox windows when checking? and then it will go back`n1 if argee`n0 if disagree",
            mouse_desc_x + 10, mouse_desc_y - 20, 1)
    }
    SetTimer(HideDescription, 100)

}

HideDescription() {
    MouseGetPos(&newx, &newy)
    if ((newx - mouse_desc_x > 15 || newx - mouse_desc_x < -15) || (newy - mouse_desc_y > 15 || newy - mouse_desc_y < -
        15)) {
        ToolTip(, , , 1)
        SetTimer(, 0)
    }
}

SaveValue(*) {
    if !A_IsCompiled {
        return
    }

    IniWrite ButtonValue.Value, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "button"
    IniWrite CheckTimeValue.Text, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "timeToCheck"
    IniWrite BlockInputValue.Text, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings",
        "tempBlockInput"
    IniWrite MoveMouseValue.Text, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "moveMouse"
    IniWrite closeHotkeyValue.Value, A_ScriptDir "\anti-afk-for-roblox-settings.ini", "Settings", "closeHotkey"

    button := ButtonValue.Value
    timeToCheck := CheckTimeValue.Text
    tempBlockInput := BlockInputValue.Text
    moveMouse := MoveMouseValue.Text
    closeHotkey := closeHotkeyValue.Value

    WinGetPos &appX, &appY, , , hGUI

    ToolTip("You have been changed the settings`nYou need to restart the app to apply new changes", appX - 890, appY -
        135, 2)
    SetTimer RemoveChangeWarning, 3000
}

RemoveChangeWarning() {
    ToolTip(, , , 2)
    SetTimer , 0
}

MoveOutside(*) {
    robloxWindow := WinExist(RealRobloxName)
    if robloxWindow {
        WinActivate(robloxWindow)
        WinMove(0, -1000000, 800, 600, robloxWindow)
    } else {
        MsgBox("Roblox is not opening")
    }
}

MoveInside(*) {
    robloxWindow := WinExist(RealRobloxName)
    if robloxWindow {
        WinActivate(robloxWindow)
        WinMove(100, 100, 800, 600, robloxWindow)
    } else {
        MsgBox("Roblox is not opening")
    }
}

AntiAFK() {
    global button
    global timeToCheck
    global tempBlockInput
    global ignoreTempBlockInput
    global moveMouse
    global processingTime
    if (processingTime < 15) {
        processingTime := 15
    }

    totalRobloxWindows := WinGetList(RealRobloxName)

    if totalRobloxWindows {

        currentWindow := WinExist("A")

        if tempBlockInput {
            if ignoreTempBlockInput {
                if WinGetProcessName(currentWindow) != "RobloxPlayerBeta.exe" {
                    BlockInput true
                }
            } else {
                BlockInput true
            }
        }

        MouseGetPos(&currentX, &currentY)
        
        ;loop if multi instances
        for window in totalRobloxWindows {
            WinActivate(window)
            WinGetPos(, , &rbW, &rbH, window)
            if moveMouse {
                MouseMove(rbW / 2, rbH / 2)
                MouseMove(1, 1, 5, "R")
            }
            Sleep(10)
            Send("{" button " down}")
            Sleep(processingTime)
            Send("{" button " up}")
            Sleep(10)
        }

        if WinExist(currentWindow) {
            WinActivate(currentWindow)
        }

        if moveMouse {
            MouseMove(currentX, currentY)
        }

        if tempBlockInput {
            BlockInput false
        }

    }
}