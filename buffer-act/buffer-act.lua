-- Buffer-Act, By Symmetryc
local pairs, twrite, ttext, tback, tpos, tclear, tblink = pairs, term.write, term.setTextColor, term.setBackgroundColor, term.setCursorPos, term.clear, term.setCursorBlink
return {
	new = function()
		local act, pos_x_, pos_y_, back_, text_ = {}
		return {
			pos_x = 1, pos_y = 1;
			back = colors.black, text = colors.white;
			shift_x = 0, shift_y = 0;
			blink = false; -- CHECK TO SEE IF term.setCursorBlink(nil) WILL ALSO WORK, IN WHICH CASE, NO NEED TO DEFINE THIS
			-- CHECK
			-- CHECK
			-- REMINDER TO CHECK
			--   CZECH
			--   CZECH
			--   CZECH
			-- MY HANDS ARE TYPING WORDS
			-- CHECK
			-- CHECK
			write = function(self, _str)
				local append, pos_x, pos_y, back, text = true, self.pos_x, self.pos_y, self.back, self.text
				if pos_x ~= pos_x_ or pos_y ~= pos_y_ then
                    act[#act + 1] = {tpos, pos_x, pos_y}
					append = false
				end
				if back ~= back_ then
					act[#act + 1] = {tback, back}
					back_ = back
					append = false
				end
				if text ~= text_ then
					act[#act + 1] = {ttext, text}
					text_ = text
					append = false
				end
				for line, nl in _str:gmatch("([^\n]*)(\n?)") do
					if append then
						act[#act][2] = act[#act][2]..line
						append = false
					else
						act[#act + 1] = {twrite, line}
					end
					if nl == "\n" then
						pos_y = pos_y + 1
						act[#act + 1] = {tpos, pos_x, pos_y}
					else
						pos_x = pos_x + #line
					end
				end
				pos_x_, pos_y_, self.pos_x_, self.pos_y_ = pos_x, pos_y, pos_x, pos_y
				return self
			end;
			clear = function(self)
				pos_x_, pos_y_, back_, text_, act = nil, nil, self.back, nil, {
					{tback, self.back};
					{tclear};
				}
				return self
			end;
			draw = function(self)
				local shift_x, shift_y = self.shift_x, self.shift_y
				for k, v in pairs(act) do
					if v[3] then
						v[1](v[2] + shift_x, v[3] + shift_y)
					else
						v[1](v[2])
					end
				end
				tblink(self.blink)
				return self
			end;
		}
	end;
}
