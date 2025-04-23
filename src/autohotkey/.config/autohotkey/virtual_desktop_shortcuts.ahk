; AutoHotkey v2 script
; Script to switch the Windows Virtual Desktop using Win+X (with X in 1-4 range)
; See example: https://github.com/Ciantic/VirtualDesktopAccessor/blob/rust/example.ah2
; WARNING: This script uses VirtualDesktopAccessor.dll (a Rust DLL)
; -> Download it on https://github.com/Ciantic/VirtualDesktopAccessor
; -> place it in "./local/bin/dll/VirtualDesktopAccessor.dll"

; Load the DLL
SetWorkingDir(EnvGet("USERPROFILE"))
VDA_PATH := ".\.local\bin\dll\VirtualDesktopAccessor.dll"
VDA_DLL := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

; Load functions from VirtualDesktopAccessor DLL
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", VDA_DLL, "AStr", "GoToDesktopNumber", "Ptr")

; Function to switch virtual desktop
GoToDesktopNumber(num) {
    global GoToDesktopNumberProc
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
    Sleep 50 ; Hack to ensure the ALT+TAB is done after the new Virtual Desktop is selected
    Send "!{Tab}" ; Hack to autofocus the window in the Virtual Desktop we just switched on
    return
}

; Keymap
#1::GoToDesktopNumber(0)  ; Win+1 -> Desktop 1
#2::GoToDesktopNumber(1)  ; Win+2 -> Desktop 2
#3::GoToDesktopNumber(2)  ; Win+3 -> Desktop 3
#4::GoToDesktopNumber(3)  ; Win+4 -> Desktop 4
#5::GoToDesktopNumber(4)  ; Win+5 -> Desktop 5
#6::GoToDesktopNumber(5)  ; Win+6 -> Desktop 6
#7::GoToDesktopNumber(6)  ; Win+7 -> Desktop 7
#8::GoToDesktopNumber(7)  ; Win+8 -> Desktop 8
#9::GoToDesktopNumber(8)  ; Win+9 -> Desktop 9
#0::GoToDesktopNumber(9)  ; Win+0 -> Desktop 10

