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

		rectangle = invalid
        if m.bsp.sign.monitorOrientation = "portrait" then
		  rectangle = createobject("rorectangle",1720,240,200,600)
		else if m.bsp.sign.monitorOrientation = "portraitbottomonright" then
		  rectangle = createobject("rorectangle",200,240,200,600)
		else
          rectangle = createobject("rorectangle", 660,880,600,200)
		endif
        virtualKeyboard = createObject("roVirtualKeyboard", rectangle)
        if m.bsp.sign.monitorOrientation = "portrait" then
          virtualKeyboard.SetTransform("rot90")
		else if m.bsp.sign.monitorOrientation = "portraitbottomonright" then
          virtualKeyboard.SetTransform("rot270")
		endif
        virtualKeyboard.setResource("file:///virtualKeyboard/bsvirtualkb.html")
        virtualKeyboard.setPort(m.msgPort)

		m.virtualKeyboard = virtualKeyboard
		m.rectangle = rectangle
	  
	  endif
	  
      'Receive a plugin message
      'if type(event) = "roAssociativeArray" then
      '  if type(event["EventType"]) = "roString"
      '    if event["EventType"] = "SEND_PLUGIN_MESSAGE" then
      '      if event["PluginName"] = "virtualKeyboard" then
      '        pluginMessage$ = event["PluginMessage"]
      '        retVal = true
      '      endif
      '    endif
      '  endif
      'endif
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
    
    
    
      'Send a plugin message
      if (false)
        pluginMessageCmd = {}
        pluginMessageCmd["EventType"] = "EVENT_PLUGIN_MESSAGE"
        pluginMessageCmd["PluginName"] = "virtualKeyboard"
        pluginMessageCmd["PluginMessage"] = "empty"
        m.msgPort.PostMessage(pluginMessageCmd)
      endif
      return false
      End Function
  }
End Function
