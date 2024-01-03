REM
REM @title                   BrightSign Virtual Keyboard
REM @author                  Lee Dydo
REM @company                 BrightSign LLC.
REM @date-created            06/06/2016
REM @date-last-modified      06/07/2016
REM
Function virtualKeyboard_Initialize(msgPort As Object, userVariables As Object, bsp As Object)
  return {
	objectName :      "virtualKeyboard_object",
  msgPort :         msgPort,
  userVariables :   userVariables,
  bsp :             bsp,
  rectangle :       invalid,
  virtualKeyboard : invalid,
  ProcessEvent :    Function (event As Object)
    'Keyboard needs to be initialized after the target roHTMLWidget, in order to be rendered on top
    if m.virtualKeyboard = invalid
      keyboardPackage = createObject("roBrightPackage", m.bsp.assetPoolFiles.getPoolFilePath("keyboard.zip"))
      if type (keyboardPackage) = "roBrightPackage"
        createDirectory("virtualKeyboard")
        keyboardPackage.unpack("virtualKeyboard/")
      endif

      ' Need to do some math to get the correct rectangle for the virtual keyboard
      ' This is based on the proportions designed around native 1080p resolution
      vidmode = createObject("roVideoMode")
      width = vidmode.getResX()
      height = vidmode.getResY()

      ' rectX and rectY are the dimensions of the keyboard
      rectX = Cint(width*.3125) ' Using percentage adjustments based on the resolution allows for correct sizing regardless of res
      rectY = Cint(height*.37)
      ' startX and startY are the coordinates of the top left corner of the keyboard
      startX = Cint((width-rectX)/2) ' Placing the keyboard on the bottom of the screen. Using the dimensions of the keyboard guarantee that the entire rectangle will be rendered onscreen
      startY = Cint(height-rectY)

      ' Must fetch the monitor orientation to determine how to place and rotate the keyboard
      monitorOrientation = ""
      if m.bsp.sign.screens <> invalid then ' account for multiple screens
          colCount = m.bsp.sign.screens.count()
          rowCount = m.bsp.sign.screens[0].count()
          if colCount > 1 or rowCount > 1 then
            print "virtualKeyboard_Initialize: warning - confirm the keyboard orientation is correct per screen"
          end if

          monitorOrientation = m.bsp.sign.screens[0][0].monitorOrientation
          ' Here is where you would handle multiscreen keyboard orientation instances as needed
        else
          monitorOrientation = m.bsp.sign.monitorOrientation
        end if

      ' Place, size and rotate the keyboard based on the monitor/tv orientation
      if monitorOrientation = "portrait" then
        startXPortrait = Cint(width-rectY)
        startYPortrait = Cint((height-rectX)/2)
        rectangle = createobject("rorectangle",startXPortrait,startYPortrait,rectX,rectY)
        transform = "rot90"
      else if monitorOrientation = "portraitbottomleft" then
        rectangle = createobject("rorectangle",rectX,rectY/2,rectX,rectY)
        transform = "rot270"
      else if monitorOrientation = "portraitbottomonright" then
        rectangle = createobject("rorectangle",rectX,rectY/2,rectX,rectY)
        transform = "rot90"
      else if monitorOrientation = "portraitbottomright" then
        rectangle = createobject("rorectangle",rectX,rectY/2,rectX,rectY)
        transform = "rot90"
      else ' landscape
        rectangle = createobject("rorectangle",startX,startY,rectX,rectY)
        transform = ""
      endif
      virtualKeyboard = createObject("roVirtualKeyboard", rectangle)
      virtualKeyboard.SetTransform(transform)
      virtualKeyboard.setResource("file:///virtualKeyboard/bsvirtualkb.html")
      virtualKeyboard.setPort(m.msgPort)
      m.virtualKeyboard = virtualKeyboard
      m.rectangle = rectangle
    endif

      if type(event) = "roVirtualKeyboardEvent" then
        print "event=";event.GetData().reason
        if event.GetData().reason = "show-event"
          ?"show: ";m.virtualKeyboard.show()
        endif
        if event.GetData().reason = "hide-event"
          ?"hide: ";m.virtualKeyboard.hide()
        endif
        return true
      endif
      return false
    End Function
  }
End Function