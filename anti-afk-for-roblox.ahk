;Creator: https://www.facebook.com/cbmchau07/
#Requires AutoHotkey v2.0

;Roblox Platform of your roblox
; "MS" mean Microsoft Store version (Roblox download from Microsoft Store)
; "WEB" mean Offical version (Roblox download from offical website roblox.com)
global robloxPlatform := "WEB"

;Change this to the button you want to press when switching tabs
;Search codenames for button: https://www.autohotkey.com/docs/v2/KeyList.htm
global button := "="

;Time per checking in seconds
global timeToCheck := 1190000 ; miliseconds (1000ms = 1s)

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



























































































































































































































RealRobloxName := "ahk_exe RobloxPlayerBeta.exe"

if robloxPlatform == "MS" {
    RealRobloxName := "ahk_exe applicationframehost.exe"
}
CheckingAdministrator()

AntiAFK() ;demo task
SetTimer(AntiAFK, timeToCheck)
CheckingSaveValueForEXE()

ExitSoftware(*) {
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
    if A_IsCompiled {
        if !FileExist(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini") {
            global robloxPlatform
            global button
            global timeToCheck
            global tempBlockInput
            global ignoreTempBlockInput
            global moveMouse

            DirCreate A_AppData "\Autohotkey_v2"

            IniWrite robloxPlatform, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "robloxPlatform"
            IniWrite button, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "button"
            IniWrite timeToCheck, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "timeToCheck"
            IniWrite tempBlockInput, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "tempBlockInput"
            IniWrite ignoreTempBlockInput, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "ignoreTempBlockInput"
            IniWrite moveMouse, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "moveMouse"

            SaveCheckTimeValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "timeToCheck")
            SaveButtonValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "button")
            SaveRobloxPlatformValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "robloxPlatform")
            SaveBlockInputValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "tempBlockInput")
            SaveGameIgnoreBIValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "ignoreTempBlockInput")
            SaveMoveMouseValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "moveMouse")
        } else {
            SaveCheckTimeValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "timeToCheck")
            SaveButtonValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "button")
            SaveRobloxPlatformValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "robloxPlatform")
            SaveBlockInputValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "tempBlockInput")
            SaveGameIgnoreBIValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "ignoreTempBlockInput")
            SaveMoveMouseValue := IniRead(A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
                "moveMouse")

            robloxPlatform := SaveRobloxPlatformValue
            button := SaveButtonValue
            timeToCheck := SaveCheckTimeValue
            tempBlockInput := SaveBlockInputValue
            ignoreTempBlockInput := SaveGameIgnoreBIValue
            moveMouse := SaveMoveMouseValue
        }
        hGUI.Add("Text", "x0 y10 w200 h20 +BackgroundTrans +Center +cPurple", "Roblox Anti-AFK is Running")

        hGUI.Add("Text", "x22 y30 w190 h25 +BackgroundTrans", "Check Time")
        CheckTimeDescription := hGUI.Add("Button", "x5 y29 w15 h15 +BackgroundTrans", "?")
        global CheckTimeValue := hGUI.Add("Edit", "x140 y28 w55 h18", SaveCheckTimeValue)

        hGUI.Add("Text", "x22 y55 w190 h25 +BackgroundTrans", "Button")
        ButtonDescription := hGUI.Add("Button", "x5 y54 w15 h15 +BackgroundTrans", "?")
        global ButtonValue := hGUI.Add("Edit", "x140 y53 w55 h18", SaveButtonValue)

        hGUI.Add("Text", "x22 y80 w190 h25 +BackgroundTrans", "Roblox Platform")
        RobloxPlatformDescription := hGUI.Add("Button", "x5 y79 w15 h15 +BackgroundTrans", "?")
        global RobloxPlatformValue := hGUI.Add("DropDownList", "x140 y77 w55 h105", ["MS", "WEB"])
        RobloxPlatformValue.Text := SaveRobloxPlatformValue

        hGUI.Add("Text", "x22 y105 w190 h25 +BackgroundTrans", "Block Input")
        BlockInputDescription := hGUI.Add("Button", "x5 y104 w15 h15 +BackgroundTrans", "?")
        global BlockInputValue := hGUI.Add("DropDownList", "x140 y102 w55 h105", [true, false])
        BlockInputValue.Text := SaveBlockInputValue

        hGUI.Add("Text", "x22 y130 w190 h25 +BackgroundTrans", "Gaming Ignore BI")
        GameIgnoreBIDescription := hGUI.Add("Button", "x5 y129 w15 h15 +BackgroundTrans", "?")
        global GameIgnoreBIValue := hGUI.Add("DropDownList", "x140 y127 w55 h105", [true, false])
        GameIgnoreBIValue.Text := SaveGameIgnoreBIValue

        hGUI.Add("Text", "x22 y155 w190 h25 +BackgroundTrans", "Move Mouse")
        MoveMouseDescription := hGUI.Add("Button", "x5 y154 w15 h15 +BackgroundTrans", "?")
        global MoveMouseValue := hGUI.Add("DropDownList", "x140 y152 w55 h105", [true, false])
        MoveMouseValue.Text := SaveMoveMouseValue

        CheckTimeValue.OnEvent("Change", SaveValue)
        ButtonValue.OnEvent("Change", SaveValue)
        RobloxPlatformValue.OnEvent("Change", SaveValue)
        BlockInputValue.OnEvent("Change", SaveValue)
        GameIgnoreBIValue.OnEvent("Change", SaveValue)
        MoveMouseValue.OnEvent("Change", SaveValue)

        CheckTimeDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "CheckTimeDescription"))
        ButtonDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "ButtonDescription"))
        RobloxPlatformDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info,
            "RobloxPlatformDescription"))
        BlockInputDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "BlockInputDescription"))
        GameIgnoreBIDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "GameIgnoreBIDescription"))
        MoveMouseDescription.OnEvent("Click", (ctrl, info) => ShowDescription(ctrl, info, "MoveMouseDescription"))

        outside := hGUI.Add("Button", "x5 y180 w190 h25 +BackgroundTrans +Center", "Move Roblox off the screen")
        inside := hGUI.Add("Button", "x5 y208 w190 h25 +BackgroundTrans +Center", "Move Roblox back to the screen")
        outside.Focus()
        outside.OnEvent("Click", MoveOutside)
        inside.OnEvent("Click", MoveInside)
        hGUI.OnEvent("Close", ExitSoftware)
        hGUI.Show("w200 h240")
    } else {
        hGUI.Add("Text", "x0 y10 w200 h20 +BackgroundTrans +Center", "Roblox Anti-AFK is Running")
        outside := hGUI.Add("Button", "x5 y30 w190 h25 +BackgroundTrans +Center", "Move Roblox off the screen")
        inside := hGUI.Add("Button", "x5 y58 w190 h25 +BackgroundTrans +Center", "Move Roblox back to the screen")
        outside.OnEvent("Click", MoveOutside)
        inside.OnEvent("Click", MoveInside)
        hGUI.OnEvent("Close", ExitSoftware)
        hGUI.Show("w200 h88")
    }
}

ShowDescription(ctrl, info, i) {
    global mouse_desc_x
    global mouse_desc_y
    MouseGetPos(&mouse_desc_x, &mouse_desc_y)

    if (i == "CheckTimeDescription") {
        ToolTip("Time per checking in miliseconds", mouse_desc_x + 10, mouse_desc_y - 20, 1)
    } else if (i == "ButtonDescription") {
        ToolTip(
            "Change this to the button you want to press when switching tabs`nSearch codenames for button: https://www.autohotkey.com/docs/v2/KeyList.htm",
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
    IniWrite RobloxPlatformValue.Text, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
        "robloxPlatform"
    IniWrite ButtonValue.Text, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "button"
    IniWrite CheckTimeValue.Text, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "timeToCheck"
    IniWrite BlockInputValue.Text, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
        "tempBlockInput"
    IniWrite GameIgnoreBIValue.Text, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings",
        "ignoreTempBlockInput"
    IniWrite MoveMouseValue.Text, A_AppData "\Autohotkey_v2\roblox-anti-afk-setttings.ini", "Settings", "moveMouse"

    robloxPlatform := RobloxPlatformValue.Text
    button := ButtonValue.Text
    timeToCheck := CheckTimeValue.Text
    tempBlockInput := BlockInputValue.Text
    ignoreTempBlockInput := GameIgnoreBIValue.Text
    moveMouse := MoveMouseValue.Text

    WinGetPos &appX, &appY, , , hGUI

    ToolTip("You have been changed the settings`nYou need to restart the app to apply new changes", appX - 885, appY -
        140, 2)
    SetTimer RemoveChangeWarning, 3000
}

RemoveChangeWarning() {
    ToolTip(, , , 2)
    SetTimer , 0
}

MoveOutside(*) {
    robloxWindow := WinExist(RealRobloxName)
    if robloxWindow {
        WinMove(0, -1000000, 800, 600, robloxWindow)
    } else {
        MsgBox("Roblox is not opening")
    }
}

MoveInside(*) {
    robloxWindow := WinExist(RealRobloxName)
    if robloxWindow {
        WinMove(100, 100, 800, 600, robloxWindow)
        WinActivate(robloxWindow)
    } else {
        MsgBox("Roblox is not opening")
    }
}

AntiAFK() {
    robloxWindow := WinExist(RealRobloxName)
    if robloxWindow {
        if tempBlockInput {
            if ignoreTempBlockInput {
                if !WinActive(robloxWindow) {
                    BlockInput true
                }
            } else {
                BlockInput true
            }
        }
        currentWindow := WinExist("A")
        MouseGetPos(&currentX, &currentY)
        WinActivate(robloxWindow)
        WinGetPos(, , &rbW, &rbH, RealRobloxName)
        if moveMouse {
            MouseMove(rbW / 2, rbH / 2)
            MouseMove(1, 1, 5, "R")
        }
        Sleep(10)
        Send("{" button " down}")
        Sleep(15)
        Send("{" button " up}")
        Sleep(10)
        WinActivate(currentWindow)
        if moveMouse {
            MouseMove(currentX, currentY)
        }
        if tempBlockInput {
            BlockInput false
        }
    }
}
