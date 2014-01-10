-- Buffer-Str, By Symmetryc
return {
	new = function(_w, _h)
		local str_, text_, back_ = "", "", ""
		return {
			pos_x = 1, pos_y = 1;
			back = 32768, text = 1;
			shift_x = 0, shift_y = 0;
			blink = false;
			clear = function(self)
				str_, text_, back_ = "", "", ""
				return self
			end;
			write = function(self, _str)

			end;
			render = function(self)
				--#stuff
				return draw
			end;
		}
	end;
}
--[[
local buffer = dofile("buffer-str.lua")
local menu = buffer.new()
menu.pos_x, menu.pos_y = 1, 1
menu:write("hello!")
	:render()()
--]]