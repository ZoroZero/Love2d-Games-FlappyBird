Bird = Class{}

function Bird:init()
    self.sprite = love.graphics.newImage('bird.png')
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.x = VIRTUAL_WIDTH/2 - (self.width/2)
    self.y = VIRTUAL_HEIGHT/2 - (self.height/2)
    self.dy = 0;
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY_ACCELERATION*dt;
    if love.keyboard.wasPressed('space') then
        self.dy = JUMP_ACCELERATION;
    end 
    self.y = math.max(0, self.y + self.dy);
end

function Bird:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end
