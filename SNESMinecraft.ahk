; Variables
SpecialKey = Joy2
SpecialSlowKey = Joy1
Sensitivity = 15
SensitivitySlow = 10
Slot = 0

; Timers
SetTimer, WatchController, 5

; Keys
^D::
  msgbox, Value Is: %RTriggerPrev%
  msgbox, Value Is: %RTriggerCurr%
Return
Joy5::
  GetKeyState, Special, %SpecialKey%
  if (Special == "D") {
    if (Slot <= 0) {
      Slot := 10
    }
    Slot := Slot - 1
    Send, %Slot%
    KeyWait, Joy5
    Return
  }
Return
Joy6::
  GetKeyState, Special, %SpecialKey%
  if (Special == "D") {
    if (Slot >= 9) {
      Slot := 0
    }
    Slot := Slot + 1
    Send, %Slot%
    KeyWait, Joy6
    Return
  }
Return

; Functions
WatchController() {
  global
  GetKeyState, Special, %SpecialKey% ; Special Key
  HandleDPad(Special)
  HandleRightTrigger(Special)
  Return
}
HandleDPad(ByRef Special) {
  global
  GetKeyState, XAxis, JoyX ; X Axis
  GetKeyState, YAxis, JoyY ; Y Axis
  GetKeyState, SpecialSlow, %SpecialSlowKey% ; Slow Mouse Movement
  DPadPrev = %DPadCurr%
  DPadPrevWASD = %DPadCurrWASD%
  if (Special == "D") {
    if (XAxis > 70) { ; Right
      DllCall("mouse_event", "UInt", 1, "Int", 15, "Int", 0)
    } else if (XAxis < 30) { ; Left
      DllCall("mouse_event", "UInt", 1, "Int", -Sensitivity, "Int", 0)
    } else if (YAxis > 70) { ; Up
      DllCall("mouse_event", "UInt", 1, "Int", 0, "Int", Sensitivity)
    } else if (YAxis < 30) { ; Down
      DllCall("mouse_event", "UInt", 1, "Int", 0, "Int", -Sensitivity)
    }
    DPadCurr =
    DPadCurrWASD =
  } else if (SpecialSlow == "D") {
    if (XAxis > 70) { ; Right
      DllCall("mouse_event", "UInt", 1, "int", SensitivitySlow, "int", 0)
    } else if (XAxis < 30) { ; Left
      DllCall("mouse_event", "UInt", 1, "int", -SensitivitySlow, "int", 0)
    } else if (YAxis > 70) { ; Up
      DllCall("mouse_event", "UInt", 1, "int", 0, "int", SensitivitySlow)
    } else if (YAxis < 30) { ; Down
      DllCall("mouse_event", "UInt", 1, "int", 0, "int", -SensitivitySlow)
    }
    DPadCurr =
    DPadCurrWASD =
  } else {
    if (XAxis > 70) { ; Right
      DPadCurr = Right
      DPadCurrWASD = D
    } else if (XAxis < 30) { ; Left
      DPadCurr = Left
      DPadCurrWASD = A
    } else if (YAxis > 70) { ; Down
      DPadCurr = Down
      DPadCurrWASD = S
    } else if (YAxis < 30) { ; Up
      DPadCurr = Up
      DPadCurrWASD = W
    } else {
      DPadCurr =
      DPadCurrWASD =
    }
  }
  if (DPadCurr = %DPadPrev%) {
    Return
  }
  SetKeyDelay, -1
  if (DPadPrev) {
    Send, {%DPadPrev% up}
  }
  if (DPadPrevWASD) {
    Send, {%DPadPrevWASD% up}
  }
  if (DPadCurr) {
    Send, {%DPadCurr% down}
  }
  if (DPadCurrWASD) {
    Send, {%DPadCurrWASD% down}
  }
}
HandleRightTrigger(ByRef Special) {
  global
  GetKeyState, RTrigger, Joy6 ; Right Trigger
  RTriggerPrev = %RTriggerCurr%
  if (Special == "D") {
    RTriggerCurr =
  } else {
    if (RTrigger == "D") {
      RTriggerCurr = LButton
    } else {
      RTriggerCurr =
    }
  }
  if (RTriggerCurr = %RTriggerPrev%) {
    Return
  }
  SetKeyDelay, -1
  if (RTriggerPrev) {
    Send, {%RTriggerPrev% up}
    msgbox prev
  }
  if (RTriggerCurr) {
    Send, {%RTriggerCurr% down}
  }
}