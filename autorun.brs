r1=createobject("rorectangle",0,0,1920,1080)
h1=createobject("rohtmlwidget",r1)
h1.seturl("http://www.google.co.uk")
' Uncomment the following for portrait mode
'h1.settransform("rot90")
h1.StartInspectorServer(2999)
h1.show()

' Comment the following for portrait mode
rv=createobject("rorectangle", 660,880,600,200)
' Uncomment the following for portrait mode
'rv=createobject("rorectangle",1720,240,200,600)
v=createobject("rovirtualkeyboard",rv)
' Uncomment the following for portrait mode
'v.settransform("rot90")
v.setresource("file:///sd:/bsvirtualkb.html")

t=createobject("rotouchscreen")
t.enablecursor(1)

p = CreateObject("roMessagePort")
v.SetPort(p)

while true
	msg = wait(1000, p)
	if type(msg) = "roVirtualKeyboardEvent" then
    		print "msg=";msg.GetData().reason
		if msg.GetData().reason = "show-event"
			v.show()
		endif
		if msg.GetData().reason = "hide-event"
			v.hide()
		endif
	endif
end while


