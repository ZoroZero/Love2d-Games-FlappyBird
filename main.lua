push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

GRAVITY_ACCELERATION = 10;
JUMP_ACCELERATION = -4;


local background = love.graphics.newImage('background.png');
local background_Scroll = 0;

local ground = love.graphics.newImage('ground.png');
local ground_Scroll = 0;

local BACKGROUND_SCROLL_SPEED = 30;
local GROUND_SCROLL_SPEED = 60;

local BACKGROUND_LOOPING_POINT = 413;

local bird = Bird();

local pipes = {};

local pipe_spawning_timer = 0;
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
    background_Scroll = (background_Scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT;

    ground_Scroll = (ground_Scroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH;

    bird:update(dt);

    -- spawn pipes
    pipe_spawning_timer = pipe_spawning_timer + dt;

    if pipe_spawning_timer > 2 then
        table.insert( pipes, Pipe() )
        pipe_spawning_timer = 0;
    end

    -- Update pipes and remove pipe if it is out of screen
    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove( pipes, k )
        end
    end

    -- Reset key pressed table
    love.keyboard.keysPressed = {};
end


-- Render game function
function love.draw()
    push:start()

    love.graphics.draw(background, -background_Scroll, 0);

    -- Render pipes
    for k, pipe in pairs(pipes) do
        pipe:render();
    end

    love.graphics.draw(ground, -ground_Scroll, VIRTUAL_HEIGHT - 16);

    bird:render();

    push:finish();
end
