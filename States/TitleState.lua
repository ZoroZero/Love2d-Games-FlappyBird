TitleState = Class{__includes = BaseState}

function TitleState:update(dt) 
    -- Pressed enter to play
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game_State_Machine:change('stand_by')
    end
end

function TitleState:render() 
    love.graphics.setFont(flappyFont)
    love.graphics.printf("ZERO BIRD", 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter to play", 0, 140, VIRTUAL_WIDTH, 'center')
end