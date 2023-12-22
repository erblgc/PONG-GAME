love = require('love')

math.randomseed(os.time())

local function Ball()

    
    return{
        x = love.graphics.getWidth()/2,
        y = love.graphics.getHeight()/2,
        width = 20,
        height = 20,
        xVelocity = nil,
        yVelocity = 1,


        update = function(self, dt)
            self.x = self.x + self.xVelocity * dt
            self.y = self.y + self.yVelocity * dt
        end,

        draw = function(self,color)
            love.graphics.setColor(color)
            love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
        end,

        checkCollision = function (self,x,y,width,height)
            if self.x < x + width and
                self.x + self.width > x and
                self.y < y + height and
                self.y + self.height > y then
                    return true
            end
            return false
        end,

        bounce = function(self,obj)
            self.xVelocity = -self.xVelocity * 1.03
            if self.yVelocity < 0 then
                self.yVelocity = -math.random(100, 280)
            else
                self.yVelocity = math.random(100, 280)
            end
        end,

        reset = function(self)
            self.x = love.graphics.getWidth()/2
            self.y = love.graphics.getHeight()/2
            if self.xVelocity < 0 then
                self.xVelocity = self.xVelocity 
            else
                self.xVelocity = self.xVelocity 
            end
            self.yVelocity = 1
        end

    }
end

return Ball