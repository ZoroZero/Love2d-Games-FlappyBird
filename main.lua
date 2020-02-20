push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

-- Gravity variable for each frame
GRAVITY_ACCELERATION = 10;

-- Jump accelaration
JUMP_ACCELERATION = -4;

-- Background
local background = love.graphics.newImage('background.png');
local background_Scroll = 0;

-- Ground
local ground = love.graphics.newImage('ground.png');
local ground_Scroll = 0;

-- Back ground and ground scrolling speed
local BACKGROUND_SCROLL_SPEED = 30;
local GROUND_SCROLL_SPEED = 60;

-- Background and ground loop point
local BACKGROUND_LOOPING_POINT = 413;
local GROUND_LOOPING_POINT = VIRTUAL_WIDTH;

-- Declare bird
local bird = Bird();

-- Declare table of pairs of pipes
local pair_pipes = {};

-- Pipe spawn timer
local pipe_spawning_timer = 0;

-- Spawn circle time
local pipe_spawning_cicle = 2.2;

-- Init y of the last spawn pair
local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- Loading function
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest');
    love.window.setTitle("Zero Bird");

    math.randomseed(os.time());

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsyn = true,
        fullscreen = false
    })

    love.keyboard.keysPressed = {};
end


-- Resize window function
function love.resize(w, h)
    push:resize(w, h);
end


-- Check if anykey is pressed
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
    if key == 'escape' then
        love.event.quit();
    end
end

-- Check if a certain key was pressed last frame
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end


-- Update game function
function love.update(dt)
    -- Upadte background and ground
    background_Scroll = (background_Scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT;
    ground_Scroll = (ground_Scroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT;

    -- Update bird
    bird:update(dt);

    -- spawn pipes
    pipe_spawning_timer = pipe_spawning_timer + dt;

    if pipe_spawning_timer > pipe_spawning_cicle then
        -- y is no bigger than (screen height - 90) - pipe_height (bottom pipe not render well) 
        -- and no less than -pipe_height + 10 (or else top pipe will not render well)
        local y = math.max(-PIPE_HEIGHT + 10 ,
        math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - PIPE_GAP - PIPE_HEIGHT) );

        -- Add pair to table
        table.insert(pair_pipes, PipePair(y));

        -- update variable
        lastY = y;
        pipe_spawning_timer = 0;
    end

    -- Update pipes and remove pipe if it is out of screen
    for k, pipe in pairs(pair_pipes) do
        pipe:update(dt)
    end

    -- Check if any pair need to be remove
    for k, pipe in pairs(pair_pipes) do
        if pipe.remove then
            table.remove(pair_pipes, k)
        end
    end

    -- Reset key pressed table
    love.keyboard.keysPressed = {};
end


-- Render game function
function love.draw()
    push:start()
    -- Render background
    love.graphics.draw(background, -background_Scroll, 0);

    -- Render pipes
    for k, pipe in pairs(pair_pipes) do
        pipe:render();
    end

    -- Render ground
    love.graphics.draw(ground, -ground_Scroll, VIRTUAL_HEIGHT - 16);

    -- Render bird
    bird:render();

    push:finish();
end
