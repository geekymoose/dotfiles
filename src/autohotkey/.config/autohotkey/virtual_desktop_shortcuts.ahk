; AutoHotkey v2 script
; Script to switch the Windows Virtual Desktop using Win+X (with X in 1-4 range)
; See example: https://github.com/Ciantic/VirtualDesktopAccessor/blob/rust/example.ah2
; WARNING: VirtualDesktopAccessor.dll must exist on the same location
; Download it on https://github.com/Ciantic/VirtualDesktopAccessor

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
    return
}

; Keymap
#1::GoToDesktopNumber(0)  ; Win+1 -> Desktop 1
#2::GoToDesktopNumber(1)  ; Win+2 -> Desktop 2
#3::GoToDesktopNumber(2)  ; Win+3 -> Desktop 3
#4::GoToDesktopNumber(3)  ; Win+4 -> Desktop 4

