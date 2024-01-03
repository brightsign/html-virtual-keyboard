REM
REM @title                   BrightSign Virtual Keyboard
REM @author                  Lee Dydo
REM @company                 BrightSign LLC.
REM @date-created            06/06/2016
REM @date-last-modified      01/03/2024
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
      ' This is based on the current video mode and monitor orientation

      vidmode = createObject("roVideoMode")
      width = vidmode.getResX()
      height = vidmode.getResY()

      if m.bsp.sign.monitorOrientation = "portrait" then
        rectangle = createobject("rorectangle",1720,240,200,600) ' keeping same for now
        transform = "rot90"
      else if m.bsp.sign.monitorOrientation = "portraitbottomonright" then
        rectangle = createobject("rorectangle",200,240,200,600) ' keeping same for now
        transform = "rot270"
      else
        ' for 1080p, rectangle is 600x400 pxs, starts at (660,680)
        ' 31.25% of the screen width, 37% of the screen height
        ' starts 2/3 of way down screen, and 1/3 of way across screen

        ' rectWidth = width*.3125 => 1920*.3125 = 600
        ' rectHeight = height*.37 => 1080*.37 = 400

        rectX = Cint(width*.3125)
        rectY = Cint(height*.37)
        startX = Cint((width-rectX)/2)
        startY = Cint(height-rectY)

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