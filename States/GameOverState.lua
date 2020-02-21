GameOverState = Class {__includes = BaseState}

function GameOverState:enter(score)
    self.score = score
end

function GameOverState:update(dt)
    -- Pressed enter to play
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game_State_Machine:change('stand_by')
    end

end

function GameOverState:render()
    
    love.graphics.setFont(flappyFont)
    love.graphics.printf("You lost", 8, 8, VIRTUAL_WIDTH, 'center')

    -- print score
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score:" .. tostring(self.score), 8, 70, VIRTUAL_WIDTH, 'center')

    -- Print play again
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter to play again", 0, 140, VIRTUAL_WIDTH, 'center')
end