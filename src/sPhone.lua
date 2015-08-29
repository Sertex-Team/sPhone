os.forceShutdown = os.shutdown

local function crash(err)
	if not sPhone then
		sPhone = {
			devMode = false,
		}
	end
	term.setCursorBlink(false)
	term.setBackgroundColor(colors.blue)
	term.clear()
	term.setCursorPos(1,1)
	term.setTextColor(colors.white)
	if not err then
		err = "Unknown"
	end
	
	print("sPhone Crash:\n")
	term.setBackgroundColor(colors.black)
	printError(err)
	term.setBackgroundColor(colors.blue)
	print("\nContact sPhone devs: GitHub: Sertex-Team/sPhone")
	print("Press any key")
	repeat
		sleep(0)
	until os.pullEvent("key")
	if not sPhone.devMode then
		os.forceShutdown()
	end
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	sleep(0.1)
	shell.run("/rom/programs/shell")
end

if not pocket or not term.isColor() then
	crash("Computer not supported: use an Advanced Pocket Computer or an Advanced Wireless Pocket Computer")
end


local function kernel()
	_G.sPhone = {
		version = "Alpha 1",
		user = "Unknown",
		devMode = true,
	}
	
	if fs.exists("/.sPhone/config/username") then
		local u = fs.open("/.sPhone/config/username","r")
		sPhone.user = u.readLine()
		u.close()
	end
	
	if not fs.exists("/.sPhone/apis") then
		fs.makeDir("/.sPhone/apis")
	end
	
	for k, v in pairs(fs.list("/.sPhone/apis")) do
		os.loadAPI("/.sPhone/apis/"..v)
	end
	
	function os.version()
		return "sPhone "..sPhone.version
	end
	
	local function clear()
		term.setBackgroundColor(colors.white)
		term.clear()
		term.setCursorPos(1,1)
		term.setTextColor(colors.black)
	end
	
	sPhone.forceShutdown = os.shutdown
	sPhone.forceReboot = os.reboot
	
	function os.shutdown()
		os.pullEvent = os.pullEventRaw
		if sPhone.doneShutdown then
			clear()
			w, h = term.getSize()
			term.setCursorPos( (w/2)- 7, h/2)
			write("Press CTRL + S")
			while true do
				sleep(3600)
			end
		end
		sPhone.doneShutdown = true
		clear()
		w, h = term.getSize()
    term.setCursorPos( (w / 2) - 1, h / 2)
		for i = 1,3 do
			sleep(0.3)
			write(".")
		end
		sleep(0.2)
		sPhone.forceShutdown()
	end
	
	function os.reboot()
		os.pullEvent = os.pullEventRaw
		if sPhone.doneShutdown then
			clear()
			w, h = term.getSize()
			term.setCursorPos( (w/2)- 7, h/2)
			write("Press CTRL + R")
			while true do
				sleep(3600)
			end
		end
		sPhone.doneShutdown = true
		clear()
		w, h = term.getSize()
		term.setCursorPos( (w / 2) - 1, h / 2)
		for i = 1,3 do
			sleep(0.3)
			write(".")
		end
		sleep(0.2)
		sPhone.forceReboot()
	end
	
	function byte(string)
		local newString = ""
		for i = 1, #string do
			addString = string.byte(string.sub(string, i))
			newString = newString .. addString
		end
		return newString
	end
	
	function sPhone.yesNo(title, desc)
		term.setBackgroundColor(colors.white)
		term.clear()
		term.setCursorPos(1,1)
		term.setTextColor(colors.black)
		local w, h = term.getSize()
		paintutils.drawLine(1,1,w,1, colors.gray)
		term.setTextColor(colors.white)
		term.setCursorPos(1,1)
		if not sPhone.user then
			write(" sPhone")
		else
			write(" "..sPhone.user)
		end
		term.setCursorPos(1,3)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		sertextext.center(3, "  "..title)
		if desc then
			sertextext.center(6, "  "..desc)
		end
		paintutils.drawFilledBox(3, 16, 9, 18, colors.green)
		paintutils.drawFilledBox(18, 16, 24, 18, colors.red)
		term.setTextColor(colors.white)
		term.setCursorPos(5,17)
		term.setBackgroundColor(colors.green)
		write("Yes")
		term.setCursorPos(20,17)
		term.setBackgroundColor(colors.red)
		write("No")
		while true do
			local _,_,x,y = os.pullEvent("mouse_click")
			if (x > 2 and y > 15) and (x < 10 and y < 19) then
				return true
			elseif (x > 17 and y > 15) and (x < 25 and y < 19) then
				return false
			end
		end
	end
	
	function sPhone.winOk(fmessage, smessage, bg, side, text, button)
		if not fmessage then
			fmessage = ""
		end
		if not bg then
			bg = colors.gray
		end
		if not text then
			text = colors.white
		end
		if not button then
			button = colors.lightGray
		end
		if not side then
			side = colors.lightGray
		end
		local w, h = term.getSize
		term.setBackgroundColor(side)
		paintutils.drawBox(11 - math.ceil(#fmessage / 2), 5, 16 + math.ceil(#fmessage / 2), 10, side)
		term.setBackgroundColor(bg)
		paintutils.drawFilledBox(12 - math.ceil(#fmessage / 2), 6, 15 + math.ceil(#fmessage / 2), 9, bg)
		term.setCursorPos(14 - math.ceil(#fmessage / 2), 7)
		term.setTextColor(text)
		write(fmessage)
		if smessage then
			term.setCursorPos(14 - math.ceil(#smessage / 2), 8)
			write(smessage)
		end
		term.setCursorPos(13,10)
		term.setBackgroundColor(button)
		write("Ok")
		while true do
			local e, k, x,y = os.pullEvent()
			if e == "mouse_click" then
				if y == 10 then
					if x == 13 or x == 14 then
						return
					end
				end
			elseif e == "key" then
				if k == 28 then
					return
				end
			end
		end
	end
	
	function lChat()
		clear()
		local w, h = term.getSize()
		paintutils.drawLine(1,1,w,1,colors.gray)
		term.setTextColor(colors.white)
		sertextext.center(1,"  Chat")
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		term.setCursorPos(2, 5)
		if not peripheral.isPresent("back") or not peripheral.getType("back") == "modem" then
			print("Modem not found")
			print(" Press any key")
			os.pullEvent("key")
			return
		end
		write("Host: ")
		local h = read()
		term.setCursorPos(2,6)
		shell.run("/rom/programs/rednet/chat", "join", h, sPhone.user)
		sleep(1)
	end
	
	local function home()
		local function drawHome()
			local function box(x,y,text,bg,colorText,page)
				graphics.box(x,y,x+1+#text,y+2,bg)
				term.setCursorPos(x+1,y+1)
				term.setTextColor(colorText)
				write(text)
			end
			clear()
			local w, h = term.getSize()
			paintutils.drawLine(1,1,w,1, colors.gray)
			term.setTextColor(colors.white)
			sertextext.right(1,"vvv")
			term.setCursorPos(1,1)
			write(" "..sPhone.user)
			box(2,3,"Shell",colors.black,colors.yellow)
			box(19,3,"Lock",colors.lightGray,colors.black)
			box(11,3,"sID",colors.red,colors.white)
			box(2,7,"Games",colors.pink,colors.blue)
			box(10,7,"Chat", colors.black,colors.white)
			box(19,7,"SMS",colors.green,colors.white)
			box(3, 11, "CST", colors.lightBlue, colors.blue)
			box(10, 11, "GPS", colors.red, colors.black)
			box(18, 11, "Info", colors.lightGray, colors.black)
		end
		local function footerMenu()
			sPhone.isFooterMenuOpen = true
			function redraw()
				local w, h = term.getSize()
				graphics.box(1,2,w,4,colors.gray)
				term.setTextColor(colors.white)
				term.setBackgroundColor(colors.gray)
				sertextext.right(1,"^^^")
				sertextext.right(3, "Reboot")
				term.setCursorPos(11,3)
				write("Settings")
				term.setCursorPos(2,3)
				write("Shutdown")
			end
			while true do
				redraw()
				local _,_,x,y = os.pullEvent("mouse_click")
				if y == 3 then
					if x > 1 and x < 10 then
						os.shutdown()
					elseif x > 19 and x < 26 then
						os.reboot()
					elseif x > 10 and x < 19 then
						shell.run("/.sPhone/apps/system/settings")
						drawHome()
					end
				elseif y == 1 then
					if x < 26 and x > 22 then
						sPhone.isFooterMenuOpen = false
						return
					end
				end
			end
		end
		
		while true do
			drawHome()
			term.setCursorBlink(false)
			local _,m,x,y = os.pullEvent("mouse_click")
			
			if y == 1 then
				if x < 26 and x > 22 then
					footerMenu()
				end
			else
				if (y > 2 and x > 1) and (y < 6 and x < 9) then
					term.setBackgroundColor(colors.black)
					term.clear()
					term.setCursorPos(1,1)
					term.setTextColor(colors.white)
					print("Type \"exit\" to close the shell")
					shell.run("/rom/programs/shell")
				elseif (y > 2 and x > 10) and (y < 7 and x < 16) then
					shell.run("/.sPhone/apps/system/sID")
				elseif (y > 2 and x > 18) and (y < 6 and x < 25) then
					login()
				elseif (y > 6 and x > 1) and (y < 10 and x < 9) then
					sPhone.winOk("Work In", "Progress")
				elseif (y > 6 and x > 9) and (y < 10 and x < 16) then
					lChat()
				elseif (y > 6 and x > 18) and (y < 10 and x < 24) then
					shell.run("/.sPhone/apps/sms")
				elseif (y > 10 and x > 2) and (y < 14 and x < 8) then
					shell.run("/.sPhone/apps/cstwallet")
				elseif (y > 10 and x > 9) and (y < 14 and x < 15) then
					shell.run("/.sPhone/apps/gps")
				elseif (y > 10 and x > 17) and (y < 14 and x < 24) then
					shell.run("/.sPhone/apps/system/info")
				end
			end
		end
	end
	
	function login()
		if fs.exists("/.sPhone/.password") then
			while true do
				term.clear()
				term.setCursorPos(1,1)
				paintutils.drawImage(paintutils.loadImage("/.sPhone/interfaces/login"),1,1)
				term.setTextColor(colors.white)
				term.setBackgroundColor(colors.gray)
				term.setCursorPos(1,1)
				write(" "..sPhone.user)
				if sPhone.wrongPassword then
					term.setTextColor(colors.red)
					term.setBackgroundColor(colors.white)
					sertextext.center(13,"  Wrong Password")
				end
				term.setTextColor(colors.black)
				term.setBackgroundColor(colors.white)
				sertextext.center(7,"  Insert Password")
				term.setTextColor(colors.black)
				term.setCursorBlink(true)
				term.setCursorPos(9,10)
				local _, k1 = os.pullEvent("char")
				write("*")
				term.setCursorPos(12,10)
				local _, k2 = os.pullEvent("char")
				write("*")
				term.setCursorPos(15,10)
				local _, k3 = os.pullEvent("char")
				write("*")
				term.setCursorPos(18,10)
				local _, k4 = os.pullEvent("char")
				write("*")
				term.setCursorBlink(false)
				local passwordLogin = k1..k2..k3..k4
				local fpw = fs.open("/.sPhone/.password","r")
				if sha256.sha256(passwordLogin) == fpw.readLine() then
					sPhone.wrongPassword = false
					home()
				else
					sPhone.wrongPassword = true
				end
			end
		else
			local name
			local pw
			local pwr
			local rServer
			while true do
				term.clear()
				term.setCursorPos(1,1)
				paintutils.drawImage(paintutils.loadImage("/.sPhone/interfaces/login"),1,1)
				if sPhone.wrongPassword then
					term.setTextColor(colors.red)
					sertextext.center(13,"  Wrong Password")
				end
				term.setTextColor(colors.black)
				term.setBackgroundColor(colors.white)
				sertextext.center(3,"  Setup")
				sertextext.center(7,"  Insert Password")
				term.setTextColor(colors.black)
				term.setCursorBlink(true)
				term.setCursorPos(9,10)
				local _, k1 = os.pullEvent("char")
				write("*")
				term.setCursorPos(12,10)
				local _, k2 = os.pullEvent("char")
				write("*")
				term.setCursorPos(15,10)
				local _, k3 = os.pullEvent("char")
				write("*")
				term.setCursorPos(18,10)
				local _, k4 = os.pullEvent("char")
				write("*")
				term.setCursorBlink(false)
				local password1 = k1..k2..k3..k4
				term.clear()
				term.setCursorPos(1,1)
				paintutils.drawImage(paintutils.loadImage("/.sPhone/interfaces/login"),1,1)
				term.setTextColor(colors.black)
				term.setBackgroundColor(colors.white)
				sertextext.center(3,"  Setup")
				sertextext.center(7,"  Repeat")
				term.setTextColor(colors.black)
				term.setCursorBlink(true)
				term.setCursorPos(9,10)
				local _, v1 = os.pullEvent("char")
				write("*")
				term.setCursorPos(12,10)
				local _, v2 = os.pullEvent("char")
				write("*")
				term.setCursorPos(15,10)
				local _, v3 = os.pullEvent("char")
				write("*")
				term.setCursorPos(18,10)
				local _, v4 = os.pullEvent("char")
				write("*")
				term.setCursorBlink(false)
				local password2 = v1..v2..v3..v4
				if password1 == password2 then
					local f = fs.open("/.sPhone/.password", "w")
					f.write(sha256.sha256(password1))
					f.close()
					term.setTextColor(colors.lime)
					sertextext.center(13,"  Password set!")
					sleep(2)
					break
				else
					sPhone.wrongPassword = true
				end
			end
			
			term.setBackgroundColor(colors.white)
			term.clear()
			term.setCursorPos(1,1)
			local w, h = term.getSize()
			paintutils.drawLine(1,1,w,1,colors.gray)
			term.setTextColor(colors.black)
			term.setBackgroundColor(colors.white)
			sertextext.center(3,"  Setup Sertex ID")
			local isDown = http.get("http://sertex.esy.es/status.php").readAll()
			if isDown ~= "true" then
				sertextext.center(5, "  The server is down")
				sertextext.center(6, "  Run sID on the home")
				name = "Run sID"
				sleep(2)
			else

				local choose = sPhone.yesNo("Setup Sertex ID", "Do you have a Sertex ID?")
				if not choose then
					term.setBackgroundColor(colors.white)
					term.clear()
					term.setCursorPos(1,1)
					local w, h = term.getSize()
					paintutils.drawLine(1,1,w,1,colors.gray)
					term.setTextColor(colors.black)
					term.setBackgroundColor(colors.white)
					sertextext.center(3,"  Setup Sertex ID")
					sertextext.center(7,"  Your Username")
					term.setCursorPos(3,8)
					name = read()
					while true do
						sertextext.center(9, "  Your Password")
						term.setCursorPos(3,10)
						term.clearLine()
						pw = read("*")
						sertextext.center(11, "  Repeat")
						term.setCursorPos(3,12)
						term.clearLine()
						pwr = read("*")
						if pw == pwr then
							break
						else
							print("   Wrong Password")
							sleep(1)
						end
					end
					local rServer = http.post("http://sertex.esy.es/register.php", "user="..name.."&password="..pw).readAll()
					if rServer ~= "Success!" then
						print("Username already exists")
						print("Retry later in the app sID")
						sleep(1)
					end
					local f = fs.open("/.sPhone/config/username","w")
					f.write(name)
					f.close()
					local pwf = fs.open("/.sPhone/config/.sIDPw", "w")
					pwf.write(base64.encode(pw))
					pwf.close()
				else
					term.setBackgroundColor(colors.white)
					term.clear()
					term.setCursorPos(1,1)
					local w, h = term.getSize()
					paintutils.drawLine(1,1,w,1,colors.gray)
					term.setTextColor(colors.black)
					term.setBackgroundColor(colors.white)
					sertextext.center(3,"  Setup Sertex ID")
					sertextext.center(7,"  Your Username")
					term.setCursorPos(3,8)
					name = read()
					sertextext.center(9, "  Your Password")
					term.setCursorPos(3,10)
					term.clearLine()
					pw = read("*")
					sertextext.center(11, "  Checking...")
					rServer = http.post("http://sertex.esy.es/login.php", "user="..name.."&password="..pw).readAll()
						if rServer ~= "true" then
						print("   Wrong Username/Password")
						print("   Run sID")
						sleep(2)
					else
						f = fs.open("/.sPhone/config/username", "w")
						f.write(name)
						f.close()
						f = fs.open("/.sPhone/config/.sIDpw", "w")
						f.write(base64.encode(pw))
						f.close()
					end
				end
			end
			
			sertextext.center(13,"  All Set!")
			sertextext.center(14,"  Have fun with sPhone")
			sPhone.user = name
			sleep(2)
			home()
		end
	end
	
	login()
end

if sPhone then
	printError("sPhone already started")
	return
end

local ok, error = pcall(kernel)

if not ok then
	crash(error)
end

os.forceShutdown()
