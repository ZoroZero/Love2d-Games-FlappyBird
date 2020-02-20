
Pipe = Class {}

local pipe_image = love.graphics.newImage('pipe.png');
local PIPE_MOVING_SPEED = -60

function Pipe:init()
    self.x = VIRTUAL_WIDTH;
    self.y = math.random(100, VIRTUAL_HEIGHT - 40);
    
    self.width = pipe_image:getWidth();
end

-- Update function for each pipe
function Pipe:update(dt)
    self.x = self.x + PIPE_MOVING_SPEED*dt
end


-- Render function for each pipe
function Pipe:render()
    love.graphics.draw(pipe_image, self.x, self.y)
end