Bird = Class{}

function Bird:init()
    self.sprite = love.graphics.newImage('assets/bird.png')
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.x = VIRTUAL_WIDTH/2 - (self.width/2)
    self.y = VIRTUAL_HEIGHT/2 - (self.height/2)
    self.dy = 0;
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY_ACCELERATION*dt;
    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = JUMP_ACCELERATION;
        sounds['jump']:play();
    end 
    self.y = math.max(0, self.y + self.dy);
end


function Bird:collide(pipe)
    return (self.x < pipe.x + PIPE_WIDTH) and 
    (self. x + self.width > pipe.x) and
    (self.y < pipe.y + PIPE_HEIGHT) and
    (self.y + self.height > pipe.y)
end


function Bird:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end
