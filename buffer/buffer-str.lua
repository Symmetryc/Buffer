-- Buffer-Str, By Symmetryc
local log, log2, sub, rep, pairs = math.log, math.log(2), string.sub, string.rep, pairs
local t_pos, t_back, t_text, t_write, t_blink = term.setCursorPos, term.setBackgroundColor, term.setTextColor, term.write, term.setCursorBlink
local hex, cache, max_x, max_y = {}, nil, term.getSize()
for i = 0, 15 do
	hex[2 ^ i] = ("%x"):format(i)
	hex[("%x"):format(i)] = 2 ^ i
end
local floor = function(_n)
	return _n - _n % 1
end
local new = function(_w, _h, _color)
	local buffer = {
		pos_x = 1, pos_y = 1;
		width = _w, height = _h;
		color = _color ~= false;
		back = {}, text = {}, str = {};
		cur_back = "f", cur_text = "0";
		shift_x = 0, shift_y = 0;
		blink = false;
		-- Blinking
		draw_cache = function(self)
		end;
		draw_func = function(self)
		end;
		draw_dirty = function(self)
		end;
	}
	for i = 1, _h do
		buffer.back[i] = rep("f", _w)
		buffer.str[i] = rep("0", _w)
		buffer.text[i] = rep(" ", _w)
	end
	buffer.write = function(_str) -- check x && y
	end
	buffer.setCursorPos = function(_x, _y)
		buffer.pos_x, buffer.pos_y = floor(_x), floor(_y)
	end
	buffer.getCursorPos = function()
		return buffer.pos_x, buffer.pos_y
	end
	buffer.scroll = function(_n) --
		
	end
	buffer.isColor = function()
		return buffer.color
	end
	buffer.clear = function() --
	end
	buffer.clearLine = function() --
	end;
	buffer.setCursorBlink = function(_b)
		buffer.blink = _b
	end
	buffer.getSize = function()
		return buffer.width, buffer.height
	end
	buffer.setTextColor = function(_n)
		buffer.cur_text = hex[_n] or hex[2 ^ floor(log(_n) / log2)]
		if buffer.color or buffer.cur_text == "0" or buffer.cur_text == "f" then
			error("Color not supported", 0)
		end
	end
	buffer.setBackgroundColor = function(_n)
		buffer.cur_back = hex[_n] or hex[2 ^ floor(log(_n) / log2)]
		if buffer.color or buffer.cur_back == "0" or buffer.cur_back == "f" then
			error("Color not supported", 0)
		end
	end
	buffer.isColour = buffer.isColor
	buffer.setTextColour = buffer.setTextColor
	buffer.setBackgroundColour = buffer.setBackgroundColor
	return buffer
end
cache = new(max_x, max_y, true)
return {new = new, cache = cache}