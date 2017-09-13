REM
REM @title                   BrightSign Virtual Keyboard
REM @author                  Lee Dydo
REM @company                 BrightSign LLC.
REM @date-created            06/06/2016
REM @date-last-modified      07/05/2016
REM
Function virtualKeyboard_Initialize(msgPort As Object, userVariables As Object, bsp As Object)
  return {
    objectName :      "virtualKeyboard_object",
    version:          1.02,
    msgPort :         msgPort,
    userVariables :   userVariables,
    bsp :             bsp,
    rectangle :       invalid,
    virtualKeyboard : invalid,
    ProcessEvent :    Function (event As Object)
      'Keyboard needs to be initialized after the target roHTMLWidget, in order to be rendered on top
	  if m.virtualKeyboard = invalid
	    vm = m.bsp.videomode
		width = vm.getresx()
		height = vm.getresy()
        keyboardPackage = createObject("roBrightPackage", m.bsp.assetPoolFiles.getPoolFilePath("keyboard.zip"))
        if type (keyboardPackage) = "roBrightPackage"
          createDirectory("virtualKeyboard")
          keyboardPackage.unpack("virtualKeyboard/")
        endif
		rectangle = createObject("rorectangle", 0, 0, width, height)
        virtualKeyboard = createObject("roVirtualKeyboard", rectangle)
        if m.bsp.sign.monitorOrientation = "portrait" then
		  virtualKeyboard.setTransform("rot90")
		else if m.bsp.sign.monitorOrientation = "portraitbottomonright" then
		  virtualKeyboard.setTransform("rot270")
		endif
		virtualKeyboard.setResource("file:///virtualKeyboard/bsvirtualkb.html")
        virtualKeyboard.setPort(m.msgPort)
		m.virtualKeyboard = virtualKeyboard
		m.rectangle = rectangle
		m.virtualKeyboard.hide()
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
