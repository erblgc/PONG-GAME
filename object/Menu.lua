---@diagnostic disable: undefined-global

love = require('love')

local function Menu()
   
    return
    {
        start_color = {71/255, 186/255, 30/255},
        exit_color = {186/255, 28/255, 36/255},
        options_color = {128/255, 120/255, 120/255},

        hover_start_color = {19/255, 71/255, 1/255},
        hover_exit_color = {89/255, 2/255, 6/255},
        hover_options_color = {77/255, 72/255, 72/255},

        button_width = 200,
        button_height = 50,
    
    
        button = function (self, text , x , y , color, font)
            love.graphics.setColor(color)
            love.graphics.setFont(font)
            love.graphics.rectangle("fill", x, y, self.button_width , self.button_height,10,10)
            love.graphics.setColor(1, 1, 1)
            love.graphics.printf(text, x, y + 6, self.button_width, "center")
        end,  
        
        checkPressed = function (self, x, y, width, height)
            local mouseX = love.mouse.getX()
            local mouseY = love.mouse.getY()
            if mouseX > x and mouseX < x + width and mouseY > y and mouseY < y + height then
                return true
            end
            return false
        end,
        start_button = function (self)
            self:button(
            "START",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 - 60,
            self.start_color,
            font
        )end,

        options_button =  function (self)
            self:button(
            "OPTIONS",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2,
            self.options_color,
            font 
        )end,

        exit_button = function (self)
            self:button(
            "EXIT",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 + 60,
            self.exit_color,
            font
        ) end,

        hover_start = function (self)
            self:button(    
                "START",
                love.graphics.getWidth()/2 - self.button_width/2,
                love.graphics.getHeight()/2 - self.button_height/2 - 60,
                self.hover_start_color,
                font
        ) end,
        

        hover_options = function (self)
            self:button(
            "OPTIONS",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2,
            self.hover_options_color,
            font
        ) end,

        hover_exit = function (self)
            self:button(
                "EXIT",
                love.graphics.getWidth()/2 - self.button_width/2,
                love.graphics.getHeight()/2 - self.button_height/2 + 60,
                self.hover_exit_color,
                font
        )end,
        
        resume_button = function (self)
            self:button(
            "RESUME",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 - 60,
            self.start_color,
            font
        )end,

        hover_resume = function (self)
            self:button(
            "RESUME",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 - 60,
            self.hover_start_color,
            font
        )end,
        back_button = function (self)
            self:button(
            "BACK",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 + 60,
            self.exit_color,
            font
        )end,

        hover_back = function (self)
            self:button(
            "BACK",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 + 60,
            self.hover_exit_color,
            font
        )end,
        
        slow_button = function (self)
            self:button(
            "SLOW",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 - 60,
            self.start_color,
            font
        )end,

        medium_button = function (self)
            self:button(
            "MEDIUM",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2,
            self.options_color,
            font
        )end,

        fast_button = function (self)
            self:button(
            "FAST",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 + 60,
            self.exit_color,
            font
        )end,

        hover_slow = function (self)
            self:button(
            "SLOW",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 - 60,
            self.hover_start_color,
            font
        )end,

        hover_medium = function (self)
            self:button(
            "MEDIUM",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2,
            self.hover_options_color,
            font
        )end,

        hover_fast = function (self)
            self:button(
            "FAST",
            love.graphics.getWidth()/2 - self.button_width/2,
            love.graphics.getHeight()/2 - self.button_height/2 + 60,
            self.hover_exit_color,
            font
        )end,
    }
end

return Menu