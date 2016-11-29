-- Auto Function Finder

-- Use this function to perform your initial setup
function setup()
    index = 0
    ymar = 70
    xmar = (WIDTH - HEIGHT)/2 + ymar
    
    parameter.action("Add Point", addpoint)
    parameter.action("Remove Point", rempoint)
    
    parameter.text("botX", -5)
    parameter.text("topX", 5)
    parameter.text("botY", -5)
    parameter.text("topY", 5)
    
    parameter.boolean("snap", false)
    
    parameter.action("Print Function", printf)
    
    pointxs = {-1, 0, 1} --   INT
    pointys = {2, 1, 2} -- INT
    
    hasnilval = false
    nilimage = 0
    
    mat = {}
    
    touches = {}
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
            mat[l][n + 1] = mat [l][n + 1] - mat[l][c]*mat[c][n+1]
        end
    end
    -- print("Ended second half")
    -- printmat()
end

function printf()
    txt = ""
    for i, v in ipairs(mat) do
        if v[#v] ~= 0 then
            if v[#v] > 0 and i > 1 then
                txt = txt.."+"
            end
            txt = txt..v[#v]
        
        if (#mat - i) > 0 then
            txt = txt.."*x"
            if (#mat - i) > 1 then
                txt = txt.."^"..(#mat - i)
            end
        end
        end
        -- txt = txt.." "
    end
    print(txt)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(238, 223, 166, 255)

    -- This sets the line thickness
    strokeWidth(1)
    stroke(0, 255)
    
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
        stroke(0)
        text(x, xmar + (x - botX)*xpx, ymar - 16)
    end
    
    for y = botY, topY do
        if y == 0 then
            stroke(229, 95, 95, 255)
        else
            stroke(118, 226, 223, 255)
        end
        line(xmar, ymar + (y-botY)*ypx, WIDTH - xmar, ymar + (y-botY)*ypx)
        stroke(0)
        text(y, xmar - 16, ymar + (y - botY)*ypx)
    end
    
    fill(22, 23, 36, 255)
    for i, v in ipairs(pointxs) do
        tx = xmar + (v - botX)*xpx
        ty = ymar + (pointys[i] - botY)*ypx
        -- ellipse(v/xpx, pointys[i]/ypx, 30)
        ellipse(tx, ty, 20)
        -- print("ellipse at "..tx..", "..ty)
        if CurrentTouch.state == BEGAN and vec2(CurrentTouch.x, CurrentTouch.y):dist(vec2(tx, ty)) <= 30 and CurrentTouch.tapCount == 1 then index = i end
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
    
    -- TESTING ONLY
    -- mat = {{0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}
    -- TESTING ONLY
    
    -- lasty = 100
    for cx = xmar, WIDTH - xmar do
        -- tx = (cx)*uxpx + botX
        tx = (cx - xmar)*uxpx + botX
        ty = fofx(tx) -- INT 
        -- lasty = ty
        -- print("Point: "..tx..", "..ty)
        -- print("lasty: "..lasty)
        if cx > xmar and cx <= WIDTH - xmar then
            priny = ymar + (ty - botY)/uypx
            if cx == xmar then
                lasy = priny
            end
            -- print(priny)
            if priny >= ymar then
                if priny <= HEIGHT - ymar then
                    if lasy >= ymar then
                        if lasy <= HEIGHT - ymar then
                            -- ellipse(cx, priny, 3)
                            line(cx - 1, lasy, cx, priny)
                        end
                    end
                end
            end
        end
        lasy = priny
    end
    -- while true do
        
    -- end
end

