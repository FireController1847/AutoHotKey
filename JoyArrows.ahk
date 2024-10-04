Slot = 0
Special = Joy2

#Persistent
SetTimer, WatchAxis, 5
SetTimer, WatchRight, 5
SetTimer, WatchLeft, 5
SetTimer, WatchSpace, 5
Return

WatchAxis:
  GetKeyState, JoyX, JoyX ; Get position of the X axis
  GetKeyState, JoyY, JoyY ; Get position of the Y axis
  GetKeyState, Joy7, %Special% ; Get select button
  GetKeyState, Joy8, Joy1
  KeyToHoldDownPrev = %KeyToHoldDown% ; Prev now holds the key that was down before (if any).
  KeyToHoldForCompatPrev = %KeyToHoldForCompat%

  if (Joy7 == "D") {
    if (JoyX > 70) {
      ; MouseMove, 10, 0, 0.5, R
      DllCall("mouse_event", UInt, 1, int, 15, int, 0) ; Right
    } else if (JoyX < 30) {
      DllCall("mouse_event", UInt, 1, int, -15, int, 0) ; Left
      ; MouseMove, -10, 0, 0.5, R
    } else if (JoyY > 70) {
      DllCall("mouse_event", UInt, 1, int, 0, int, 15) ; Up
    } else if (JoyY < 30) {
      DllCall("mouse_event", UInt, 1, int, 0, int, -15) ; Down
    }
    KeyToHoldDown =
    KeyToHoldForCompat =
  } else if (Joy8 == "D") {
    if (JoyX > 70) {
      ; MouseMove, 10, 0, 0.5, R
      DllCall("mouse_event", UInt, 1, int, 5, int, 0) ; Right
    } else if (JoyX < 30) {
      DllCall("mouse_event", UInt, 1, int, -5, int, 0) ; Left
      ; MouseMove, -10, 0, 0.5, R
    } else if (JoyY > 70) {
      DllCall("mouse_event", UInt, 1, int, 0, int, 5) ; Up
    } else if (JoyY < 30) {
      DllCall("mouse_event", UInt, 1, int, 0, int, -5) ; Down
    }
    KeyToHoldDown =
    KeyToHoldForCompat =
  } else {
    if (JoyX > 70) {
      KeyToHoldDown = Right ; Right or D
      KeyToHoldForCompat = D
    } else if (JoyX < 30) {
      KeyToHoldDown = Left ; 
      KeyToHoldForCompat = A
    } else if (JoyY > 70) {
      KeyToHoldDown = Down
      KeyToHoldForCompat = S
    } else if (JoyY < 30) {
      KeyToHoldDown = Up
      KeyToHoldForCompat = W
    } else {
      KeyToHoldDown =
      KeyToHoldForCompat =
    }
  }

  if KeyToHoldDown = %KeyToHoldDownPrev%  ; The correct key is already down (or no key is needed).
    Return  ; Do nothing.
  
  ; Otherwise, release the previous key and press down the new key:
  SetKeyDelay -1  ; Avoid delays between keystrokes.
  if KeyToHoldDownPrev {   ; There is a previous key to release.
    Send, {%KeyToHoldDownPrev% up}  ; Release it.
    Send, {%KeyToHoldForCompatPrev% up}
  }
  if KeyToHoldDown {   ; There is a key to press down.
    Send, {%KeyToHoldDown% down}  ; Press it down.
    Send, {%KeyToHoldForCompat% down}
  }
Return

WatchRight:
  GetKeyState, Joy6, Joy6 ; Get left click (right trigger)
  GetKeyState, Joy7, %Special% ; Get select button
  KeyToHoldDownRightPrev = %KeyToHoldDownRight% ; Prev now holds the key that was down before (if any).

  if (Joy7 == "D") {
    KeyToHoldDownRight =
  } else {
    if (Joy6 == "D") {
      KeyToHoldDownRight = LButton
    } else {
      KeyToHoldDownRight =
    }
  }

  if KeyToHoldDownRight = %KeyToHoldDownRightPrev%  ; The correct key is already down (or no key is needed).
    Return  ; Do nothing.
  
  ; Otherwise, release the previous key and press down the new key:
  SetKeyDelay -1  ; Avoid delays between keystrokes.
  if KeyToHoldDownRightPrev {   ; There is a previous key to release.
    Send, {%KeyToHoldDownRightPrev% up}  ; Release it.
  }
  if KeyToHoldDownRight {
    Send, {%KeyToHoldDownRight% down}
  }
Return

WatchLeft:
  GetKeyState, Joy5, Joy5 ; Get right click (left trigger)
  GetKeyState, Joy7, %Special% ; Get select button
  KeyToHoldDownLeftPrev = %KeyToHoldDownLeft% ; Prev now holds the key that was down before (if any).

  if (Joy7 == "D") {
    KeyToHoldDownLeft =
  } else {
    if (Joy5 == "D") {
      KeyToHoldDownLeft = RButton
    } else {
      KeyToHoldDownLeft =
    }
  }

  if KeyToHoldDownLeft = %KeyToHoldDownLeftPrev%  ; The correct key is already down (or no key is needed).
    Return  ; Do nothing.
  
  ; Otherwise, release the previous key and press down the new key:
  SetKeyDelay -1  ; Avoid delays between keystrokes.
  if KeyToHoldDownLeftPrev {   ; There is a previous key to release.
    Send, {%KeyToHoldDownLeftPrev% up}  ; Release it.
  }
  if KeyToHoldDownLeft {
    Send, {%KeyToHoldDownLeft% down}
  }
Return

WatchSpace:
  GetKeyState, Joy3, Joy3 ; Get right click (left trigger)
  GetKeyState, Joy7, %Special% ; Get select button
  KeyToHoldDownSpacePrev = %KeyToHoldDownSpace% ; Prev now holds the key that was down before (if any).

  if (Joy7 == "D") {
    KeyToHoldDownSpace =
  } else {
    if (Joy3 == "D") {
      KeyToHoldDownSpace = Space
    } else {
      KeyToHoldDownSpace =
    }
  }

  if KeyToHoldDownSpace = %KeyToHoldDownSpacePrev%  ; The correct key is already down (or no key is needed).
    Return  ; Do nothing.
  
  ; Otherwise, release the previous key and press down the new key:
  SetKeyDelay -1  ; Avoid delays between keystrokes.
  if KeyToHoldDownSpacePrev {   ; There is a previous key to release.
    Send, {%KeyToHoldDownSpacePrev% up}  ; Release it.
  }
  if KeyToHoldDownSpace {
    Send, {%KeyToHoldDownSpace% down}
  }
Return