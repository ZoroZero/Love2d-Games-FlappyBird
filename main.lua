push = require 'push'

Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'States/BaseState'
require 'States/TitleState'
require 'States/PlayState'
require 'States/GameOverState'
require 'States/StandByState'

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


-- Loading function
function love.load()
    -- Set scaling texture
    love.graphics.setDefaultFilter('nearest', 'nearest');

    -- Set window title
    love.window.setTitle("Zero Bird");

    -- Set random seed
    math.randomseed(os.time());

    -- Set font
    smallFont = love.graphics.newFont('font/font.ttf', 8)
    mediumFont = love.graphics.newFont('font/flappy.ttf', 14)
    hugeFont = love.graphics.newFont('font/flappy.ttf', 28)
    flappyFont = love.graphics.newFont('font/flappy.ttf', 56)
    love.graphics.setFont(smallFont)

    -- Set up screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsyn = true,
        fullscreen = false
    })

    -- Set up state machine
    game_State_Machine = StateMachine {
        ['title'] = function() return TitleState(); end,
        ['stand_by'] = function() return StandByState(); end,
        ['play'] = function() return PlayState(); end,
        ['game_over'] = function() return GameOverState() end
    }

    game_State_Machine:change('title');

    -- Initialize table of pressed key last frame
    love.keyboard.keysPressed = {};
end




-- Update game function
function love.update(dt)

    -- Upadte background and ground
    background_Scroll = (background_Scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT;
    ground_Scroll = (ground_Scroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT;

    -- State update
    game_State_Machine:update(dt)

    -- Reset key pressed table
    love.keyboard.keysPressed = {};
end





-- Render game function
function love.draw()
    push:start()

    -- Render background
    love.graphics.draw(background, -background_Scroll, 0);

    -- render state
    game_State_Machine:render()

    -- Render ground
    love.graphics.draw(ground, -ground_Scroll, VIRTUAL_HEIGHT - 16);

    push:finish();
end



-- Resize window function
function love.resize(w, h)
    push:resize(w, h);
end



-- Check if anykey is pressed function
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
