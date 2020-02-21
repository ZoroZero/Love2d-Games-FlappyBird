PlayState = Class {__includes = BaseState}

function PlayState:init()
    -- Declare bird
    self.bird = Bird();

    -- Declare table of pairs of pipes
    self.pair_pipes = {};
    
    -- Spawn pipes circle time
    self.pipe_spawning_cicle = 2.2;

    -- Pipe spawn timer
    self.pipe_spawning_timer = 0;

    -- Init y of the last spawn pair
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20;

    -- Init score = 0
    self.score = 0
    
end

function PlayState:update(dt) 
    -- Update bird
    self.bird:update(dt);

     -- spawn pipes
     self.pipe_spawning_timer = self.pipe_spawning_timer + dt;

    if self.pipe_spawning_timer > self.pipe_spawning_cicle then

        -- y is no bigger than (screen height - 90) - pipe_height (bottom pipe not render well) 
        -- and no less than -pipe_height + 10 (or else top pipe will not render well)
        local y = math.max(-PIPE_HEIGHT + 10 ,
        math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - PIPE_GAP - PIPE_HEIGHT) );

        -- Add pair to table
        table.insert(self.pair_pipes, PipePair(y));

        -- update variable
        self.lastY = y;
        self.pipe_spawning_timer = 0;

    end

    -- Update pipes and score
    for k, pipes in pairs(self.pair_pipes) do
        if not pipes.hasPassed then
            if pipes.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1;
                pipes.hasPassed = true;
            end
        end

        pipes:update(dt)

        for l, pipe in pairs(pipes.pipes) do
            if self.bird:collide(pipe) then 
                game_State_Machine:change('game_over', self.score)
                break;
            end
        end
    end

    -- Check if any pair need to be remove. Different loop to avoid buggy 
    for k, pipe in pairs(self.pair_pipes) do
        if pipe.remove then
            table.remove(self.pair_pipes, k)
        end
    end

    -- If bird falls to the ground then game over
    if self.bird.y > VIRTUAL_HEIGHT -15 then
        game_State_Machine:change('game_over', self.score);
    end

end

function PlayState:render() 
     -- Render pipes
    for k, pipe in pairs(self.pair_pipes) do
        pipe:render();
    end

    -- Render bird
    self.bird:render();

    -- Print score
    love.graphics.setFont(mediumFont);
    love.graphics.print(tostring(self.score), 8, 8);
end