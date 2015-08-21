local function clear()
  term.setBackgroundColor(colors.white)
  term.setTextColor(colors.black)
  term.clear()
  term.setCursorPos(1,1)
end

local function header()
	clear()
	local w, h = term.getSize()
	paintutils.drawLine(1,1,w,1, colors.gray)
	term.setTextColor(colors.white)
	term.setCursorPos(1,1)
	write(" "..sPhone.user)
	term.setCursorPos(w,1)
	write("X")
	term.setCursorPos(1,2)
	term.setBackgroundColor(colors.white)
	term.setTextColor(colors.black)
end

term.setCursorPos(1,3)
sertextext.center(3, "  Info")
print("")
print(" sPhoneOS "..sPhone.version.." by Sertex-Team")
print(" CST Wallet by Luca_S")
print(" UI API by LMNetOS")
print(" SHA256 API by GravityScore")
print(" SertexText API by Sertex-Team")
print(" Graphics API by Sertex-Team")
print(" Thanks to Luca_S for SMS system and Sertex ID")

while true do
  local w, h = term.getSize()
  local _, _, x, y = os.pulLEvent("mouse_click")
  if y == 1 and x == w then
    return
  end
  sleep(0)
end