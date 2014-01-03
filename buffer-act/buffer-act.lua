-- Buffer-Act, By Symmetryc
return {
        new = function()
                return {
                        act = {};
                        pos_x = 1;
                        pos_y = 1;
                        shift_x = 0;
                        shift_y = 0;
                        back = colors.white;
                        text = colors.black;
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
}
