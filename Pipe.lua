
Pipe = Class {}

local pipe_image = love.graphics.newImage('pipe.png');
PIPE_MOVING_SPEED = -60
PIPE_WIDTH = pipe_image:getWidth();
PIPE_HEIGHT = pipe_image:getHeight()

function Pipe:init(type, y)
    self.x = VIRTUAL_WIDTH;
    self.y = y;
    
    self.width = PIPE_WIDTH;

    self.type = type;
end

-- Update function for each pipe - no need
function Pipe:update(dt)
    
end


-- Render function for each pipe
function Pipe:render()
    love.graphics.draw(pipe_image, self.x, self.type == 'top' and self.y + PIPE_HEIGHT or self.y,
     0,    -- rotation
     1,    -- XScale
     self.type == 'top' and -1 or 1); -- YSCale
end