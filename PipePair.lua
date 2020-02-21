PipePair = Class{}

PIPE_GAP = 100;

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32;

    -- y is the top of the upper pipe
    self.y = y

    -- pair of pipes init
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + PIPE_GAP)
    }

    -- remove when the pair is ready to be romove
    self.remove = false

    -- Init have bird pass
    self.hasPassed = false;
end

-- Update pair of pipes
function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_WIDTH*dt;
        self.pipes['upper'].x = self.x;
        self.pipes['lower'].x = self.x;
    else
        self.remove = true;
    end
end


-- Render function of each pair
function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
