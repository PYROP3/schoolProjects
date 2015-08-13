def simplify num, digits, float, addZ
    inp = num.to_f.to_s
    out = ""
    zeroed = ""
    counting = 0
    range = ["0","1","2","3","4","5","6","7","8","9"]
    safe = []
    for i in 0..(inp.length-1)
        if (counting < digits)
            c = inp[i]
            if (float && c == ".") 
                out << c
                safe << i
            elsif (range.include?(c))
                out << c 
                counting += 1
                safe << i 
            #elsif addZ
                #out << "0"
            end
        #elsif addZ
            #out << "0"
        end
    end
    #puts "Safe: " + safe.join(", ")
    for j in 0..(inp.length-1)
        #puts "Inserting: " + (safe.include?(j) ? inp[j] : "0")
        zeroed << (safe.include?(j) ? inp[j] : "0")
    end
    zeroed = zeroed.chomp("00")
    #puts "Out: " + out.to_f.to_sb
    #puts "Zer: " + zeroed.to_f.to_s
    return [out.to_f.to_s, zeroed.to_f.to_s]
end

numbers = {0 => "black", 1 => "brown", 2 => "red", 3 => "orange", 4 => "yellow", 5 => "green", 6 => "blue", 7 => "violet", 8 => "grey", 9 => "white"}
multipliers = {1.0 => "black", 10.0 => "brown", 100.0 => "red", 1000.0 => "orange", 10000.0 => "yellow", 100000.0 => "green", 1000000.0 => "blue", 10000000.0 => "violet", 100000000.0 => "grey", 1000000000.0 => "white", 0.1 => "gold", 0.05 => "silver"}
tolerance = {1.0 => "brown", 2.0 => "red", 3.0 => "orange", 4.0 => "yellow", 0.5 => "green", 0.25 => "blue", 0.1 => "violet", 0.05 => "grey", 5.0 => "gold", 10.0 => "silver", 20.0 => "-no band-"}
tempCoef = {100 => "brown", 50 => "red", 15 => "orange", 25 => "yellow"}

puts "Resistor color finder"
while true
    oldRes = 0
    order = 2
    max2 = 99*10**9
    max3 = 999*10**9
    while (((oldRes < 1 || oldRes > max2) && order == 2) || ((oldRes < 10 || oldRes > max3) && order == 3)) do
        oldRes = 0
        while oldRes <= 0 #|| (oldRes > max2 && order == 2) || (oldRes > max3 && order == 2)
            print "Resistance: " 
            oldRes = gets.to_f ##
            if oldRes <= 0
                puts "Resistance must be positive"
                puts "--//--"
                puts
            end
        end
        puts
        print "Band number (defaults to 4): "
        rcv = gets.to_i ##
        order = ((rcv == 4) ? 2 : ((rcv == 5 || rcv == 6) ? 3 : 2))
        acc = [4,5,6]
        puts "Defaulting band number to 4...\n" unless acc.include?(rcv)
        puts
        rcv = 4 unless acc.include?(rcv)
        if (oldRes < 1 && order == 2)
            puts "For 4 bands, value must be => 1"
            puts "--//--\n"
            puts
        elsif (oldRes < 10 && order == 3)
            puts "For 5 or 6 bands, value must be => 10"
            puts "--//--\n"
            puts
        elsif (oldRes > max2 && order == 2)
            puts "For 4 bands, value must be =< " + max2.to_s
            puts "--//--\n"
            puts
        elsif (oldRes > max3 && order == 3)
            puts "For 5 or 6 bands, value must be =< " + max3.to_s
            puts "--//--\n"
            puts
        end
    end
    print "Tolerance (defaults to 20): "
    tol = gets.to_f ##
    puts "Defaulting tolerance to 20..."  unless tolerance.has_key?(tol)
    puts 
    tol = 20.0 unless tolerance.has_key?(tol)
    if rcv == 6
        print "Temperature coefficient (defaults to 100): "
        temp = gets.to_i ##
        puts "Defaulting temperature coefficient to 100...\n" unless tempCoef.has_key?(temp)
        puts
        temp = 100 unless tempCoef.has_key?(temp)
    end
    #res = simplify(oldRes, order, !(oldRes == oldRes.to_i), false)[0]
    res = simplify(oldRes, order, false, false)[0]
    #puts "Res: " + res
    bands = []
    #puts "<< " + numbers[res[0].to_i]
    bands << numbers[res[0].to_i]
    bands << numbers[res[1].to_i]
    bands << numbers[res[2].to_i] if order == 3
    newOldRes = simplify(oldRes, order, !(oldRes == oldRes.to_i), true)[1]
    #puts "New Old res: " +  newOldRes
    multi = newOldRes.to_f/res.to_f
    if multi != multi.ceil
        approx = true
        multi = multi.ceil
    end
    if res.to_f/10 == newOldRes.to_f
        multi = 0.1
    elsif res.to_f/20 == newOldRes.to_f
        multi= 0.05
    end
    bands << multipliers[multi]
    bands << tolerance[tol]
    bands << tempCoef[temp] if rcv == 6
    puts "Bands: " + bands.join(" ")
    if oldRes.to_s != newOldRes.to_s
    puts "\n Valued lowered from " + oldRes.to_s + " to " + newOldRes.to_s + " to fit in " + rcv.to_s + " bands"
    end
    puts "\n Value cannot be calculated; RESISTOR does not exist, multiplier " + multi.to_s + " does not exist\n" unless multipliers.has_key?(multi)
    puts "--//--"
    puts
end
