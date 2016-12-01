-- Auto Function Finder

-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    
    font("Palatino-Roman")
    displayMode(FULLSCREEN)
    
    index = 0
    ymar = 70
    xmar = (WIDTH - HEIGHT)/2 + ymar
    --[[
    parameter.action("Add Point", addpoint)
    parameter.action("Remove Point", rempoint)
    
    parameter.text("botX", -5)
    parameter.text("topX", 5)
    parameter.text("botY", -5)
    parameter.text("topY", 5)
    
    parameter.boolean("snap", false)
    
    parameter.action("Print Function", printf)
    ]]
    
    botX, botY, topX, topY = -5, -5, 5, 5;
    snap = false
    
    pointxs = {-1, 0, 1} --   INT
    pointys = {2, 1, 2} -- INT
    
    hasnilval = false
    nilimage = 0
    
    mat = {}
    
    touches = {}
    
    -- tst = "123456789"
    -- print(tst[4])
    
    addB = Button(WIDTH - xmar/2, 2.5*ymar, 58, addpoint, "Add")
    remB = Button(WIDTH - xmar/2, 1.5*ymar, 58, rempoint, "Remove")
    
    snapB = Button(xmar/2, HEIGHT - 1.5*ymar, 50, togglesnap, "Snap")
    
    lB = Button(WIDTH - xmar - 20, HEIGHT/2, 30, pLeft, "L")
    rB = Button(xmar + 20, HEIGHT/2, 30, pRight, "R")
    uB = Button(WIDTH/2, HEIGHT - ymar - 20, 30, pUp, "U")
    dB = Button(WIDTH/2, ymar + 20, 30, pDown, "D")
    
    zoomIn = Button(xmar/2, 2.5*ymar, 40, zIn, "Z+")
    zoomOut = Button(xmar/2, 1.5*ymar, 40, zOut, "Z-")
    
    butts = {addB, remB, snapB, lB, rB, uB, dB, zoomIn, zoomOut}
    
    oktouch = true
end

function pRight() 
    botX = botX - 1
    topX = topX - 1 
end

function pLeft() 
    botX = botX + 1
    topX = topX + 1 
end

function pDown() 
    botY = botY - 1
    topY = topY - 1 
end

function pUp() 
    botY = botY + 1
    topY = topY + 1 
end

function zOut()
    botX = botX - 1
    botY = botY - 1
    topX = topX + 1
    topY = topY + 1
end

function zIn()
    botX = botX + 1
    botY = botY + 1
    topX = topX - 1
    topY = topY - 1
end

function togglesnap()
    if snap then
        snap = false
    else
        snap = true
    end
end

function round(num, ind)
    return math.floor(num * 10^(ind or 0) + 0.5)/(10^(ind or 0))
end

function touched(touch)
    if touch.state == ENDED then 
        touches[touch.id] = nil 
    else 
        touches[touch.id] = touch 
    end
end

function rempoint()
    table.remove(pointxs, #pointxs)
    table.remove(pointys, #pointys)
end

function addpoint()
    table.insert(pointxs, 0)
    table.insert(pointys, 0)
end

function printmat()
    for i, v in ipairs(mat) do
        txt = ""
        for ni, nv in ipairs(v) do
            txt = txt..nv..", "
        end
        print(txt)
    end
    print("-----")
    print("")
end

function clearnil()
    hasnilval = false
    for i, v in ipairs(pointxs) do
        if v == 0 then
            hasnilval = true
            nilimage = pointys[i]
        end
    end
end

function checkifhas(el, tabl)
    has = false
    for i, v in ipairs(tabl) do
        if v == tonumber(el) then has = true end
    end
    return has
end

function fofx(x)
    res = 0
    txt = ""
    for i, v in ipairs(mat) do
        res = res + v[#v]*x^(#mat - i)
        txt = txt..v[#v].."x^("..(#mat - i)..") + "
    end
    -- print(txt.."; x = "..x.."; y = "..res)
    -- print(txt)
    -- text(txt, WIDTH/2, HEIGHT - ymar/2)
    return res
end

function calcc()
    mat = {}
    
    clearnil()
    
    siz = #pointxs
    
    for i = 1, siz do
        if pointxs[i] ~= 0 then
            table.insert(mat, {})
            for c = 1, #pointxs do
                table.insert(mat[#mat], pointxs[i]^(#pointxs - c))
            end
            table.insert(mat[#mat], pointys[i])
        end
    end
    if hasnilval then
        table.insert(mat, {})
        for c = 1, #pointxs do
            if c == #pointxs then
                table.insert(mat[#mat], 1)
            else
                table.insert(mat[#mat], 0)
            end
        end
        table.insert(mat[#mat], nilimage)
    end
    -- print("Received: ")
    -- printmat()
    
    --------- 
    
    for l = 1, #mat do
        thisk = mat[l][l]
        for c = 1, #mat + 1 do
            mat[l][c] = mat[l][c]/thisk
        end
        
        for ll = l + 1, #mat do
            newk = mat[ll][l]
            for c = 1, #mat + 1 do
                -- mat[ll][c] = mat[ll][c] - mat[l][c]*mat[ll][l]
                mat[ll][c] = mat[ll][c] - mat[l][c]*newk
            end
        end
    end
    
    -- ENDED FIRST HALF 
    -- print("Ended first half:")
    -- printmat()
    
    n = #mat
    --[[
    for fc = 0, n - 1 do
        c = n - fc 
        print("c: "..c)
        thisk = mat[c][n]
        for fl = 0, c - 2 do
            l = #mat  - fl
            mat[l][n] = mat[l][n] - thisk*mat[l][c]
            -- print("Mat ["..l.."]["..n.."] is being subtracted by")
        end
    end
    ]]
    
    for fc = 0, (n - 1) do
        c = n - fc
        -- print("c: "..c)
        for fl = 1, (c - 1) do
            l = c - fl
            -- print("--l: "..l)
            mat[l][n + 1] = mat[l][n + 1] - mat[l][c]*mat[c][n+1]
        end
    end
    -- print("Ended second half")
    -- printmat()
end

function printf()
    txt = "y="
    for i, v in ipairs(mat) do
        if v[#v] ~= 0 then
            if v[#v] > 0 and i > 1 then
                txt = txt.."+"
            end
            if v[#v] ~= 1 or i == #mat then
                txt = txt..round(v[#v], 2)
            end
            if (#mat - i) > 0 then
                if v[#v] ~= 1 then
                    txt = txt.."*"
                end
                txt = txt.."x"
                if (#mat - i) > 1 then
                    txt = txt.."^"..(#mat - i)
                end
            end
        end
        -- txt = txt.." "
    end
    -- print(txt)
    textMode(CENTER)
    fill(31, 42, 113, 255)
    fontSize(math.min(ymar/2, 2*(WIDTH - 2*xmar)/txt:len()))
    text(txt, WIDTH/2, HEIGHT - ymar/2)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(238, 223, 166, 255)

    -- This sets the line thickness
    strokeWidth(1)
    stroke(0, 255)
    
    fontSize(14)
    
    testps = {}
    warn = false
    
    if CurrentTouch.state == ENDED then oktouch = true end
    
    for i, v in ipairs(pointxs) do
        -- print("Reading point x "..v)
        if checkifhas(v, testps) == false then
            table.insert(testps, v)
            -- print("New value")
        else
            -- print("Found recurring")
            warn = true
        end
    end
    
    if botX == "-" then botX = "-0" end
    if botY == "-" then botY = "-0" end
    if botX == "" then botX = "0" end
    if botY == "" then botY = "0" end
    if topX == "" then topX = "0" end
    if topY == "" then topY = "0" end
    
    ymar = 70
    xmar = (WIDTH - HEIGHT)/2 + ymar
    
    line(xmar, ymar, xmar, HEIGHT - ymar)
    line(xmar, ymar, WIDTH - xmar, ymar)
    line(WIDTH - xmar, ymar, WIDTH - xmar, HEIGHT - ymar)
    line(xmar, HEIGHT - ymar, WIDTH - xmar, HEIGHT - ymar)

    -- Do your drawing here
    xpx = (WIDTH - 2*xmar)/(topX - botX)
    ypx = (HEIGHT - 2*ymar)/(topY - botY)
    
    for x = botX, topX do
        if x == 0 then
            stroke(229, 95, 95, 255)
        else
            stroke(118, 226, 223, 255)
        end
        line(xmar + (x-botX)*xpx, ymar, xmar + (x-botX)*xpx, HEIGHT - ymar)
    end
    
    for y = botY, topY do
        if y == 0 then
            stroke(229, 95, 95, 255)
        else
            stroke(118, 226, 223, 255)
        end
        line(xmar, ymar + (y-botY)*ypx, WIDTH - xmar, ymar + (y-botY)*ypx)
    end
    stroke(0)
    fill(22, 23, 36, 255)
    for i, v in ipairs(pointxs) do
        tx = xmar + (v - botX)*xpx
        ty = ymar + (pointys[i] - botY)*ypx
        -- ellipse(v/xpx, pointys[i]/ypx, 30)
        if tx >= xmar and tx <= WIDTH - xmar and ty >= ymar and ty <= HEIGHT - ymar then
            ellipse(tx, ty, 20)
        
        -- print("ellipse at "..tx..", "..ty)
        if CurrentTouch.state == BEGAN and vec2(CurrentTouch.x, CurrentTouch.y):dist(vec2(tx, ty)) <= 30 and CurrentTouch.tapCount == 1 then index = i end
        end
    end
    
    if CurrentTouch.state ~= ENDED and CurrentTouch.tapCount == 1 and index ~= 0 and CurrentTouch.x >= xmar and CurrentTouch.x <= WIDTH-xmar and CurrentTouch.y >= ymar and CurrentTouch.y <= HEIGHT-ymar then
        if snap then
            pointxs[index] = math.floor((CurrentTouch.x - xmar)/xpx + 0.5) + botX
            pointys[index] = math.floor((CurrentTouch.y - ymar)/ypx + 0.5) + botY
        else
            pointxs[index] = (CurrentTouch.x - xmar)/xpx + botX
            pointys[index] = (CurrentTouch.y - ymar)/ypx + botY
        end
    elseif CurrentTouch.state == ENDED then
        index = 0
    end
    --[[
    linedCount = 0
    lineType = ""
    
    tCount = 0
    for k, t in pairs(touches) do
        if t ~= nil then tCount = tCount + 1 end
    end
    
    delta = 0
    
    if tCount == 1 then
        for k, t in pairs(touches) do
            if t.y >= (ymar - botY*ypx) - 5 or t.y <= (ymar - botY*ypx) + 5 then
                linedCount = linedCount + 1
                lineType = "h"
                print("Touch at y=0, id "..k)
                delta = t.deltaX
            elseif t.x >= (xmar - botX*xpx) - 5 or t.x <= (xmar - botX*xpx) + 5 then
                linedCount = linedCount + 1 
                lineType = "v"
                print("Touch at x=0, id "..k)
                delta = t.deltaY
            end
        end
    end
    
    print("Delta: "..delta)
    
    delta = math.ceil(delta)
    
    if lineType == "h" then
        botX = botX + delta
        topX = topX - delta
    elseif lineType == "v" then
        botY = botY + delta
        topY = topY - delta
    end
    
    ]]
    -----
    
    calcc()
    
    uxpx = 1/xpx
    uypx = 1/ypx
    
    lasy = 0
    
    previousY = 0
    
    -- TESTING ONLY
    -- mat = {{0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}
    -- TESTING ONLY
    -- print(lasy)
    -- lasty = 100
    for cx = xmar - 1, WIDTH - xmar do
        -- tx = (cx)*uxpx + botX
        tx = (cx - xmar)*uxpx + botX
        ty = fofx(tx) -- INT 
        -- lasty = ty
        -- print("Point: "..tx..", "..ty)
        -- print("lasty: "..lasty)
        
        -- print("in "..cx..", "..lasy)
        if cx >= xmar and cx <= WIDTH - xmar then
            priny = ymar + (ty - botY)/uypx
            -- print("priny "..priny)
            if cx == xmar then
            previousY = priny
        end
        
            -- line(-10, -10, 90, 90)
            -- print(priny)
            -- if priny >= ymar then
                -- if priny <= HEIGHT - ymar then
                    -- if lasy >= ymar then
                        -- if lasy <= HEIGHT - ymar then
                            -- ellipse(cx, priny, 3)
                            line(cx - 1, previousY, cx, priny)
                        -- end
                    -- end
                -- end
            -- end
        -- end
            end
        previousY = priny
    end
    -- while true do
    fill(238, 223, 166, 255)
    stroke(255, 0, 0, 0)
    rectMode(CENTER)
    rect(WIDTH/2, ymar/2, WIDTH, ymar)
    rect(WIDTH/2, HEIGHT - ymar/2, WIDTH, ymar)
    
    
    for x = botX, topX do
        fill(0)
        text(x, xmar + (x - botX)*xpx, ymar - 16)
    end
    
    for y = botY, topY do
        fill(0)
        text(y, xmar - 16, ymar + (y - botY)*ypx)
    end
    -- end
    
    textMode(CENTER)
    
    if index == 0 and CurrentTouch.state ~= ENDED and CurrentTouch.x >= xmar and CurrentTouch.x <= WIDTH - xmar then
        --[[
        if snap then
            cx = math.floor((CurrentTouch.x - xmar)*uxpx + botX + 0.5)
        else
            cx = (CurrentTouch.x - xmar)*uxpx + botX
        end
        ]]
        tx = (CurrentTouch.x - xmar)*uxpx + botX
        ty = fofx(tx) -- INT 
        
        priny = ymar + (ty - botY)/uypx
        
        stroke(0, 170)
        
        if priny >= ymar and priny <= HEIGHT - ymar then
        ellipse(CurrentTouch.x, priny, 6)
        -- text(tx..", "..ty, CurrentTouch.x, priny + 10)
        text(round(tx, 2)..", "..round(ty, 2), CurrentTouch.x, priny + 10)
        
        
        
        line(xmar, priny, WIDTH - xmar, priny)
        end
        line(CurrentTouch.x, HEIGHT - ymar, CurrentTouch.x, ymar)
    end
    --[[
    addB:draw()
    addB:touched(CurrentTouch)
    remB:draw()
    remB:touched(CurrentTouch)
    snapB:draw()
    snapB:touched(CurrentTouch)
    ]]
    
    for i, b in ipairs(butts) do
        b:draw()
        b:touched(CurrentTouch)
    end
    
    if warn then
        sz = math.min(2*xmar/3, 2*ymar/3)
        sprite("Small World:Flag", WIDTH - xmar/2, HEIGHT - ymar/2, sz, sz)
    end
    
    printf()
end

