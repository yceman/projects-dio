-- CONSTANTS
local WAIT_INTERVAL = 1

-- MEMBERS
local minutesAfterMidnight: number

while true do
    minutesAfterMidnight = game.Lighting:GetMinutesAfterMidnight() + 3.2
    game.Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)
    wait(WAIT_INTERVAL)
end