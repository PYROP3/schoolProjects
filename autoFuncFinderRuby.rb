def sim(num)
    if num == num.to_i then
        return num.to_i.to_s
    elsif num == num.to_f then
        return num.to_f.to_s
    else
        return "(" + num.to_s + ")"
    end
end

mat = []
print "Number of points? "
n = gets.chomp.to_i

xs = []
ys = []
hasnilval = false
savenilimage = false
nilimage = 0

for i in 1..n
    xok = false
    while !xok do
        print i.to_s + "_X: "
        tryX = gets.chomp.to_f
        if !(xs.include?(tryX)) and (tryX != 0)
            savenilimage = false
            xs.push(tryX)
            xok = true
        elsif !hasnilval and tryX == 0
            savenilimage = true
            hasnilval = true
            xok = true
        else
            print "That value is already on the list \n"
        end
    end
    
    print i.to_s + "_Y: "
    tryY = gets.chomp.to_f
    if savenilimage
        nilimage = tryY
        savenilimage = false
    else
        ys.push(tryY)
    end
end

for i in 0..n do
    mat.push([])
end

for i in 0..(n - 1) do
    if (i == (n - 1) and hasnilval)
        for v in 0..(n-1) do
            if v == (n-1)
                mat[i][v] = 1.0
            else
                mat[i][v] = 0.0
            end
        end
        mat[i][n] = nilimage
    else
        for v in 0..(n-1) do
            mat[i][v] = xs[i]**(n - v - 1)
        end
        mat[i][n] = ys[i]
    end
end

print "--//-- \n" 
print "Points saved: "
for i in 0..(xs.length-1) do
    print "(" + sim(xs[i]) + "," + sim(ys[i]) + ")"
    print ", " unless (i == xs.length - 1)
end
if hasnilval 
    print ", (0," + sim(nilimage) + ")"
end
print "\n \n"

for l in 0..(n-1) do
    divK = mat[l][l]
    for c in 0..n do
        mat[l][c] = mat[l][c]/divK
    end
    for ll in (l+1)..(n  -1) do
        thisK = mat[ll][l]
        for c in 0..n do
            mat[ll][c] = mat[ll][c] - mat[l][c]*thisK
        end
    end
end

for fc in 0..(n-1)
    c = n-1-fc
    print "Began c-loop: " + c.to_s + "\n"
    for fl in 0..(c-1)
        l = c-1-fl 
        print "Began l-loop: " + l.to_s + "\n \n"
        mat[l][n] = mat[l][n] - mat[c][n]*mat[l][c]
    end
end

print "y="

for i in 0..(n-1) do
    if mat[i][n] != 0 then
        print sim(mat[i][n]) #+ "*x^" + (n - i - 1).to_s
        if (n - i - 1) > 0
            print "*x"
            if (n - i - 1) != 1 then
                print ("^" + (n - i - 1).to_s)
            end
        end
        if ((i != (n - 1)) and (mat[i+1][n] > 0))then
            print "+"
        end
    end
end