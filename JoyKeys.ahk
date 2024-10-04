Slot = 0
Special = Joy2

Joy1::
  Send, Y ; SNES Y
  KeyWait, Joy1
Return

Joy2::
  GetKeyState, Info, Joy7
  Send, %Info% ; SNES X
  KeyWait, Joy2
Return

; Joy3:: ; SNES B

; Return

Joy4:: ; SNES A
  Send A
Return

Joy5::
  GetKeyState, Joy7, %Special%
  if (Joy7 == "D") {
    if (Slot <= 0) {
      Slot := 10
    }
    Slot := Slot - 1
    Send, %Slot%
    KeyWait, Joy6
    Return
  }
Return

Joy6::
  GetKeyState, Joy7, %Special%
  if (Joy7 == "D") {
    if (Slot >= 9) {
      Slot := 0
    }
    Slot := Slot + 1
    Send, %Slot%
    KeyWait, Joy6
    Return
  }
Return

Joy7::
  Send, E ; SNES SELECT
  KeyWait, Joy7
Return

Joy8::
  Send, {Esc} ; SNES START
  KeyWait, Joy8
Return