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
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", VDA_DLL, "AStr", "MoveWindowToDesktopNumber", "Ptr")

; Switch to the specified virtual desktop
GoToDesktopNumber(num) {
    global GoToDesktopNumberProc
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
    SimulateAltTab() ; Hack to autofocus the window in the Virtual Desktop we just switched on
    return
}

; Move window to the specified virtuel desktop
MoveCurrentWindowToDesktop(number) {
    global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
    activeHwnd := WinGetID("A")
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", number, "Int")
    return
}

SimulateAltTab() {
    ; Send "!{Tab}" ; For some reasons, this doesn't work, therefore I manually do each input call
    DllCall("keybd_event", "UChar", 0x12, "UChar", 0, "UInt", 0, "UInt", 0) ; Simulate Alt down
    DllCall("keybd_event", "UChar", 0x09, "UChar", 0, "UInt", 0, "UInt", 0) ; Simulate Tab down
    DllCall("keybd_event", "UChar", 0x09, "UChar", 0, "UInt", 2, "UInt", 0) ; Simulate Tab up
    DllCall("keybd_event", "UChar", 0x12, "UChar", 0, "UInt", 2, "UInt", 0) ; Simulate Alt up
}

; Keymaps (switching)
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

; Keymaps (moving window)
#+1::MoveCurrentWindowToDesktop(0)
#+2::MoveCurrentWindowToDesktop(1)
#+3::MoveCurrentWindowToDesktop(2)
#+4::MoveCurrentWindowToDesktop(3)
#+5::MoveCurrentWindowToDesktop(4)
#+6::MoveCurrentWindowToDesktop(5)
#+7::MoveCurrentWindowToDesktop(6)
#+8::MoveCurrentWindowToDesktop(7)
#+9::MoveCurrentWindowToDesktop(8)
#+0::MoveCurrentWindowToDesktop(9)

