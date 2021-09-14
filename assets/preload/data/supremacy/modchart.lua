local background = nil

local hudX = 0
local hudY = 0

local fourStartX = 0
local fiveStartX = 0
local sixStartX = 0
local sevenStartX = 0

function start(song) 
    background = makeSprite('black','black',false)
    setActorAlpha(0,background)
    setActorX(600,background)
    setActorY(600,background)
    setActorScale(10,background)
    hudX = getHuxX()
    hudY = getHudY()
end

local power = 0

local hudZoom = 0

local spinCrazy = false
local spin = false
local spinUpFast = false

local hit = false
local directionMulti = 1
local heightMulti = 1

local direction = 2

function update(elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60)
    if curStep > 468 and curStep < 500 then
        for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
        end
        power = 0.01 * currentBeat
        camHudAngle = camHudAngle + power
    end
    if curStep > 500 and curStep < 528 then
        for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
        end
        power = 0.01 * currentBeat
        camHudAngle = camHudAngle + power
    end
    
    if curStep >= 596 and curStep < 651 then
        camHudAngle = camHudAngle + 0.04
    end

    if curStep >= 652 and curStep < 660 then
        camHudAngle = camHudAngle + 25
    end

    -- curStep >= 660 and curStep < 720
    -- curStep >= 789 and curStep < 847
    -- curStep >= 1556 and curStep < 1675
    -- curStep >= 1685 and curStep < 1794
    -- curStep >= 2324 and curStep < 2384
    -- curStep >= 2452 and curStep < 2512
    if spinCrazy then -- spinning crazy
        camHudAngle = 32 * math.sin(currentBeat * math.pi)
        if getHudX() < 320 then
            setHudPosition(getHudX() + 4, 32 * math.cos(currentBeat * math.pi))
        else
            setHudPosition(-640, 32 * math.cos(currentBeat * math.pi))
        end
    end
    -- curStep >= 737 and curStep < 756
    -- curStep >= 770 and curStep < 784
    -- curStep >= 916 and curStep < 1168
    -- curStep >= 1300 and curStep < 1411
    -- curStep >= 1812 and curStep < 2052
    -- curStep >= 2402 and curStep < 2420
    -- curStep >= 2434 and curStep < 2452
    if spin then
        if getHudX() + 640 > 1280 and not hit then
            hit = not hit
            direction = 2 * directionMulti
        elseif hit then
            if getHudX() - 640 > -1280 and hit then
                direction = -2 * directionMulti
            else
                hit = not hit
                direction = 2 * directionMulti
            end
        end
        setHudPosition(getHudX() + direction, 32 * math.cos(currentBeat * math.pi) * heightMulti)
    end

    if curStep >= 785 and curStep < 789 then
        camHudAngle = camHudAngle + 25
    end

    if curStep >= 1172 and curStep < 1204 then
        camHudAngle = camHudAngle + 1
    end
    if curStep >= 1204 and curStep < 1236 then
        camHudAngle = camHudAngle + 10
    end
    if curStep >= 1236 and curStep < 1268 then
        camHudAngle = camHudAngle + 1
    end
    if curStep >= 1268 and curStep < 1290 then
        camHudAngle = camHudAngle + 10
    end

    if curStep >= 1540 and curStep < 1552 then
        camHudAngle = camHudAngle + 2
    end
    
    if curStep >= 1797 and curStep < 1808 then
        camHudAngle = camHudAngle + 2
        hudZoom = hudZoom + 0.01
        setHudZoom(hudZoom)
    end

    if curStep >= 2058 and curStep < 2188 then
        camHudAngle = camHudAngle + 0.04
    end

    if curStep >= 2260 and curStep < 2315 then
        camHudAngle = camHudAngle + 0.04
    end

    if curStep >= 2316 and curStep < 2323 then
        camHudAngle = camHudAngle + 0.03
    end

    if curStep >= 2565 and curStep < 2580 then
        camHudAngle = camHudAngle + 2
        hudZoom = hudZoom + 0.01
        setHudZoom(hudZoom)
    end

    if curStep >= 2576 and curStep < 2696 then
        camHudAngle = camHudAngle + 0.04
    end
end

-- camHudAngle = 32 * math.sin(currentBeat * math.pi)
-- if getHudX < 1920 then
--     setHudPosition(getHudX() + 40, 32 * math.cos(currentBeat * math.pi))
-- else
--     setHudPosition(0, 32 * math.cos(currentBeat * math.pi))
-- end

function beatHit(beat)
    if curStep >= 2006 and beat % 2 == 0 and curStep < 2037 then
        setHudZoom(1.2)
        tweenHudZoom(0.7,0.2)
    end
    if curStep >= 2037 and curStep < 2052 then
        setHudZoom(1.2)
        tweenHudZoom(0.7,0.2)
    end
end

function setDefault(id)
    _G['defaultStrum'..id..'X'] = getActorX(id)
end


function stepHit(step)
    if step == 1 then
        fourStartX = getActorX(4)
        fiveStartX = getActorX(5)
        sixStartX = getActorX(6)
        sevenStartX = getActorX(7)
    end

    if (curStep >= 660 and curStep < 714) 
    or (curStep >= 789 and curStep < 840) 
    or (curStep >= 1556 and curStep < 1605)
    or (curStep >= 1620 and curStep < 1675)
    or (curStep >= 1685 and curStep < 1731)
    or (curStep >= 1748 and curStep < 1794)
    or (curStep >= 2324 and curStep < 2379)
    or (curStep >= 2452 and curStep < 2506) then
        spinCrazy = true
    else
        spinCrazy = false
    end

    if (curStep >= 737 and curStep < 756) 
    or (curStep >= 770 and curStep < 784)
    or (curStep >= 916 and curStep < 1168)
    or (curStep >= 1300 and curStep < 1411)
    or (curStep >= 1812 and curStep < 2052)
    or (curStep >= 2402 and curStep < 2420)
    or (curStep >= 2434 and curStep < 2452)
    or (curStep >= 2697 and curStep < 2737) then
        spin = true
    else
        spin = false
    end

    if step == 55 then
        tweenFadeIn(background,1,2)
        for i = 0, 3 do -- fuk outta here
            tweenFadeOut(i,0,2)
        end
        for i = 4, 7 do -- go to the center
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,0,2, 'setDefault')
        end
        tweenHudZoom(0.7,2)
        showOnlyStrums = not showOnlyStrums
    end
    if step >= 55 and step <= 83 then
        showOnlyStrums = not showOnlyStrums
        setActorAlpha(showOnlyStrums,'boyfriend')
    end

    if step >= 84 and step < 400 then
        showOnlyStrums = true
    end


    if step == 372 then
        for i = 4, 5 do
            tweenPosXAngle(i,getActorX(i) - 100,0,0.1)
            tweenPosYAngle(i,getActorY(i) + 250,0,0.1)
        end
        for i = 6, 7 do
            tweenPosXAngle(i,getActorX(i) + 100,0,0.1)
        end
    end

    if step == 398 then
        for i = 4, 5 do
            tweenPosXAngle(i,getActorX(i) + 100,0,0.1)
            tweenPosYAngle(i,getActorY(i) - 250,0,0.1)
        end
        for i = 6, 7 do
            tweenPosXAngle(i,getActorX(i) - 100,0,0.1)
        end
        print('called hud angle')
        setHudPosition(getHudX() + 100, getHudY())
    end

    if step == 420 then
        setHudPosition(getHudX() - 400, getHudY() + 400)
    end

    if step == 424 then
        setHudPosition(getHudX(), getHudY() - 535)
    end

    if step == 446 then
        setHudPosition(getHudX() + 300, getHudY() + 135)
    end

    if step == 448 then
        camHudAngle = 60
    end

    if step == 462 then
        camHudAngle = 0
    end

    if step == 528 then
        camHudAngle = 0
        for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'], i)
        end
    end

    if step == 659 then
        camHudAngle = 0
    end

    if step >= 532 and step % 8 == 4 and step < 556 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 564 and step % 8 == 4 and step < 588 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 596 and step % 8 == 4 and step < 620 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 628 and step % 8 == 4 and step < 651 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step == 720 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 756 or step == 785 or step == 789 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 841 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 950 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1169 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 2380 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1606 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1732 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1675 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1291 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1412 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 2506 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1422 then
        for i = 4, 5 do
            tweenPosXAngle(i,getActorX(i) - 100,0,0.1)
            tweenPosYAngle(i,getActorY(i) + 250,0,0.1)
        end
        for i = 6, 7 do
            tweenPosXAngle(i,getActorX(i) + 100,0,0.1)
        end
    end

    if step == 1425 then
        for i = 6, 7 do
            tweenPosYAngle(i,getActorY(i) - 50,0,0.1)
        end
        tweenPosXAngle(6,getActorX(6) + 40,0,0.1)
    end

    if step == 1442 then
        camHudAngle = 80
    end

    if step == 661 then
        camHudAngle = 0
    end

    if step == 1446 then
        camHudAngle = 120
    end
    if step == 1448 then
        camHudAngle = 180
    end

    if step == 1452 then
        setHudZoom(1.5)
    end

    if step == 1456 then
        setHudZoom(0.4)
    end

    if step == 1462 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
        tweenHudZoom(0.7,0.001)
    end

    if step == 1470 then
        for i = 4, 7 do
            tweenPosXAngle(i,_G['defaultStrum'..i..'X'],0,2)
            tweenPosYAngle(i,_G['defaultStrum'..i..'Y'],0,2)
        end
    end

    if step == 1492 then
        setHudZoom(4)
    end

    if step == 1506 then
        setHudZoom(0.4)
    end

    if step == 1516 then
        setHudZoom(1.5)
    end

    if step == 1520 then
        setHudZoom(0.4)
    end

    if step == 1526 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
        tweenHudZoom(0.7,0.001)
    end

    if step == 1675 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1795 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1812 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
        tweenHudZoom(0.7,0.1)
    end

    if step == 2052 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 2737 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end
    
    if step >= 2068 and step % 8 == 4 and step < 2092 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 2100 and step % 8 == 4 and step < 2124 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 2133 and step % 8 == 4 and step < 2156 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 2165 and step % 8 == 4 and step < 2186 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step == 2188 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step >= 2196 and step % 8 == 4 and step < 2220 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 2229 and step % 8 == 4 and step < 2252 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 2260 and step % 8 == 4 and step < 2285 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    if step >= 2292 and step % 8 == 4 and step < 2315 then
        setActorX(getActorX(4) - 200,4)
        setActorX(getActorX(5) - 100,5)
        setActorX(getActorX(6) + 100,6)
        setActorX(getActorX(7) + 200,7)
        tweenPos(4,getActorX(4) + 200,getActorY(4),0.2)
        tweenPos(5,getActorX(5) + 100,getActorY(6),0.2)
        tweenPos(6,getActorX(6) - 100,getActorY(5),0.2)
        tweenPos(7,getActorX(7) - 200,getActorY(7),0.2)
    end

    -- 2188
    -- 2315
    -- 2323

    if step == 2189 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end
    if step == 2316 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end
    if step == 2324 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    if step == 1740 then
        camHudAngle = 0
    end

    if step == 714 then
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end

    -- 2384
    -- 2512
    if step == 2385 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
    end
    if step == 2513 then
        direction = 2
        camHudAngle = 0
        setHudPosition(hudX,hudY)
        hudZoom = 0.7 -- reset it here cuz im lazy lol!
    end
    
    if step == 2580 then
        camHudAngle = 0
        tweenHudZoom(0.7,0.001)
        setHudPosition(hudX,hudY)
        for i = 4, 5 do
            tweenPosXAngle(i,getActorX(i) - 100,0,0.1)
            tweenPosYAngle(i,getActorY(i) + 250,0,0.1)
        end
        for i = 6, 7 do
            tweenPosXAngle(i,getActorX(i) + 100,0,0.1)
        end
    end

    if step == 2606 then
        for i = 4, 5 do
            tweenPosXAngle(i,getActorX(i) + 100,0,0.1)
            tweenPosYAngle(i,getActorY(i) - 250,0,0.1)
        end
        for i = 6, 7 do
            tweenPosXAngle(i,getActorX(i) - 100,0,0.1)
        end
        print('called hud angle')
        setHudPosition(getHudX() + 100, getHudY())
    end

    if step == 2608 then
        setHudPosition(getHudX() - 400, getHudY() + 400)
    end

    if step == 2628 then
        setHudPosition(getHudX(), getHudY() - 535)
    end

    if step == 2632 then
        setHudPosition(getHudX() + 300, getHudY() + 135)
    end

    if step == 2654 then
        camHudAngle = 60
    end

    if step == 2656 then
        camHudAngle = 120
    end

    
    if step == 652 then
        camHudAngle = 120
    end
    
    if step == 2673 then
        camHudAngle = 0
        for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'], i)
        end
    end
    if step == 2708 then
        camHudAngle = 0
        tweenHudZoom(0.7,0.001)
    end


    if step == 2740 then
        camHudAngle = 0
        tweenHudZoom(0.2,2)
    end

    if step == 2756 then
        tweenHudZoom(0.7,0.001)
        tweenHudZoom(0.2,2)
    end

    
    if step == 2772 then
        tweenHudZoom(0.7,0.001)
        tweenHudZoom(0.2,4)
    end

    
    if step == 2804 then
        tweenHudZoom(0.7,0.001)
        tweenHudZoom(0.2,4)
    end

    if step == 2868 then
        tweenFadeOut(background,0,1)
        tweenFadeIn('boyfriend',1,1)
        showOnlyStrums = false
        for i = 0, 3 do
            tweenFadeOut(i,1,1)
        end
        tweenHudZoom(0.9,0.01)
        setActorX(fourStartX,4)
        setActorX(fiveStartX,5)
        setActorX(sixStartX,6)
        setActorX(sevenStartX,7)
    end

end

function playerOneSing(noteData, pos)
    local data = math.abs(noteData)
    if curStep >= 852 and curStep < 899 then
        if data == 0 then
            setHudPosition(hudX - 100,hudY)
        elseif data == 1 then
            setHudPosition(hudX,hudY + 100)
        elseif data == 2 then
            setHudPosition(hudX,hudY + 100)
        elseif data == 3 then
            setHudPosition(hudX + 100,hudY)
        end
    end
end