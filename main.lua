push = require 'push'

Class = require 'class'

require 'Bird'

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

GRAVITY_ACCELERATION = 10;
JUMP_ACCELERATION = -5;
local background = love.graphics.newImage('background.png');
local background_Scroll = 0;

local ground = love.graphics.newImage('ground.png');
local ground_Scroll = 0;

local BACKGROUND_SCROLL_SPEED = 30;
local GROUND_SCROLL_SPEED = 60;

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest');
    love.window.setTitle("Zero Bird");

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsyn = true,
        fullscreen = false
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
    if key == 'escape' then
        love.event.quit();
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end

function love.update(dt)
    background_Scroll = (background_Scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT;

    ground_Scroll = (ground_Scroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH;

    bird:update(dt);

    love.keyboard.keysPressed = {};
end

function love.draw()
    push:start()

    love.graphics.draw(background, -background_Scroll, 0);

    love.graphics.draw(ground, -ground_Scroll, VIRTUAL_HEIGHT - 16);

    bird:render()

    push:finish()
end
