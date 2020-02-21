StandByState = Class{__includes = BaseState}

COUNT = 0.75
function StandByState:init()
    self.count_down = 3;
    self.timer = 0;
end

function StandByState:update(dt)
    -- Update time
    self.timer  = self.timer + dt;

    if self.timer > COUNT then
        self.timer = self.timer % COUNT
        self.count_down = self.count_down -1;
   
        -- Check if count down reach 0
        if self.count_down == 0 then 
            game_State_Machine: change('play')
        end 
    end
end

function StandByState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count_down), 0, VIRTUAL_HEIGHT/2 - 30, VIRTUAL_WIDTH, 'center')
end