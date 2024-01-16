REM
REM @title                   BrightSign Virtual Keyboard
REM @author                  Lee Dydo
REM @company                 BrightSign LLC.
REM @date-created            06/06/2016
REM @date-last-modified      06/07/2016
REM

' This is an example plugin script for the BrightSign Virtual Keyboard, used in your BA:Con presentation
' For information on how to use this script, please see the readme in the github repo or this script's comments

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
        vidmode = m.bsp.videomode
        width = vidmode.getResX()
        height = vidmode.getResY()

        ' rectSizeX and rectSizeY are the dimensions of the keyboard
        rectSizeX = Cint(width*.3125) ' Using percentage adjustments based on the resolution allows for correct sizing regardless of res
        rectSizeY = Cint(height*.37)
        ' startCoordX and startCoordY are the coordinates of the top left corner of the keyboard
        startCoordX = Cint((width-rectSizeX)/2) ' Placing the keyboard on the bottom of the screen. Using the dimensions of the keyboard guarantee that the entire rectangle will be rendered onscreen
        startCoordY = Cint(height-rectSizeY)

        ' Must fetch the monitor orientation to determine how to place and rotate the keyboard
        if m.bsp.sign.screens <> invalid then ' account for multiple screens
          colCount = m.bsp.sign.screens.count()
          rowCount = m.bsp.sign.screens[0].count()
          if colCount > 1 or rowCount > 1 then
            print "virtualKeyboard_Initialize: warning - confirm the keyboard orientation is correct per screen"
            monitorOrientation = m.bsp.sign.screens[0][0].monitorOrientation
            ' Here is where you would handle multiscreen keyboard orientation instances as needed  
          else
            monitorOrientation = m.bsp.sign.monitorOrientation
          end if
        else
          monitorOrientation = "landscape"
        end if

        ' Place, size and rotate the keyboard based on the monitor/tv orientation
        if monitorOrientation = "portrait" then
          startCoordXPortrait = Cint(width-rectSizeY)
          startCoordYPortrait = Cint((height-rectSizeX)/2)
          rectangle = createobject("rorectangle",startCoordXPortrait,startCoordYPortrait,rectSizeX,rectSizeY)
          transform = "rot90"
        else if monitorOrientation = "portraitbottomleft" then
          rectangle = createobject("rorectangle",rectSizeX,rectSizeY/2,rectSizeX,rectSizeY)
          transform = "rot270"
        else if monitorOrientation = "portraitbottomonright" then
          rectangle = createobject("rorectangle",rectSizeX,rectSizeY/2,rectSizeX,rectSizeY)
          transform = "rot90"
        else if monitorOrientation = "portraitbottomright" then
          rectangle = createobject("rorectangle",rectSizeX,rectSizeY/2,rectSizeX,rectSizeY)
          transform = "rot90"
        else ' landscape
          rectangle = createobject("rorectangle",startCoordX,startCoordY,rectSizeX,rectSizeY)
          transform = ""
        endif

        m.rectangle = rectangle
        m.transform = transform
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
      
      ' Only load the keyboard widget after html widget has finished loading
      else if type(event) = "roHtmlWidgetEvent" then
        data = event.GetData()
        if type(data) = "roAssociativeArray" then
          if data.reason = "load-finished"
            m.virtualKeyboard = invalid
            m.virtualKeyboard = virtualKeyboard_Setup(m.rectangle, m.transform, m.msgPort)
            return false
          endif
        endif
      endif
      return false
    End Function
  }
End Function

Function virtualKeyboard_Setup(rectangle, transform, msgPort)

  virtualKeyboard = createObject("roVirtualKeyboard", rectangle)
  virtualKeyboard.SetTransform(transform)
  virtualKeyboard.setResource("file:///virtualKeyboard/bsvirtualkb.html")
  virtualKeyboard.setPort(m.msgPort)

  return virtualKeyboard
end Function
