r1=createobject("rorectangle",0,0,960,1080)
r1small=createobject("rorectangle",0,0,960,600)
h1=createobject("rohtmlwidget",r1)
h1.seturl("http://www.google.co.uk")
h1.show()

r2=createobject("rorectangle",960,0,960,1080)
r2small=createobject("rorectangle",960,0,960,600)
h2=createobject("rohtmlwidget",r2)
h2.seturl("http://www.bbc.co.uk")
h2.show()

rv=createobject("rorectangle",0,600,1920,400)
v=createobject("rovirtualkeyboard",rv)
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
			h1.setRectangle(r1small)
			h2.setRectangle(r2small)
			v.show()
		endif
		if msg.GetData().reason = "hide-event"
			v.hide()
			h1.setrectangle(r1)
			h2.setrectangle(r2)
		endif
	endif
end while

