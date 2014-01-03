-- IBuffer API, by Symmetryc
local function copy(_t)
        local t = {}
        for k, v in pairs(_t) do
                t[k] = type(v) == "table" and copy(v) or v
        end
        return t
end
return {
        buffer = function()
                return {
                        act = {};
                        pos_x = 1;
                        pos_y = 1;
                        shift_x = 0;
                        shift_y = 0;
                        back = colors.white;
                        text = colors.lightGray;
                        blink = false;
                        write = function(self, _str)
                                local act = self.act
                                local append = true
                                if self.pos_x ~= act.pos_y or self.pos_x ~= act.pos_y then
                                        act[#act + 1] = {term.setCursorPos, self.pos_x, self.pos_y}
                                        append = false
                                end
                                if self.back ~= act.back then
                                        act[#act + 1] = {term.setBackgroundColor, self.back}
                                        act.back = self.back
                                        append = false
                                end
                                if self.text ~= act.text then
                                        act[#act + 1] = {term.setTextColor, self.text}
                                        act.text = self.text
                                        append = false
                                end
                                for line, nl in _str:gmatch("([^\n]*)(\n?)") do
                                        if append then
                                                act[#act][2] = act[#act][2]..line
                                                append = false
                                        else
                                                act[#act + 1] = {term.write, line}
                                        end
                                        if nl == "\n" then
                                                self.pos_y = self.pos_y + 1
                                                act[#act + 1] = {term.setCursorPos, self.pos_x, self.pos_y}
                                        else
                                                self.pos_x = self.pos_x + #line
                                        end
                                end
                                act.pos_x, act.pos_y = self.pos_x, self.pox_y
                                return self
                        end;
                        clear = function(self)
                                self.act = {
                                        {term.setBackgroundColor, self.back};
                                        {term.clear};
                                }
                                return self
                        end;
                        draw = function(self)
                                for i, v in ipairs(self.act) do
                                        if v[3] then
                                                v[1](v[2] + self.shift_x, v[3] + self.shift_y)
                                        else
                                                v[1](v[2])
                                        end
                                end
                                term.setCursorBlink(self.blink)
                                return self
                        end;
                }
        end;
        new = function()
                return {
                        add = function(self, _buffer, _n)
                                self[_n or #self + 1] = copy(_buffer)
                                return self
                        end;
                        run = function(self)
                                for k, v in pairs(self) do
                                        if type(v) == "table" and v.draw then
                                                v:draw()
                                        end
                                end
                                local r = {}
                                while not r[1] do
                                        local event = {os.pullEvent()}
                                        for k, v in pairs(self) do
                                                if type(v) == "table" and v.fn then
                                                        r = {v:fn(self, event)}
                                                        if #r > 0 then
                                                                break
                                                        end
                                                end
                                        end
                                end
                                return unpack(r)
                        end;
                }
        end;
}
