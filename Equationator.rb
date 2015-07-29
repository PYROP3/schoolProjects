valDefined = false;
while true
    while valDefined == false
        aVal = 0
        while aVal == 0
            print "Value for A: "
            aVal = gets.chomp.to_r
            if aVal == 0
                puts "aVal cannot be zero"
            end
        end
        print "Value for B: "
        bVal = gets.chomp.to_r
        print "Value for C: "
        cVal = gets.chomp.to_r
        puts ""
        delta = ((bVal*bVal)-(4*aVal*cVal))
        if delta < 0
            puts "No real roots"
         else
            puts "Delta: " + delta.to_s
            root1 = ((-1)*bVal + Math.sqrt(delta))/(2*aVal)
            root2 = ((-1)*bVal - Math.sqrt(delta))/(2*aVal)
            puts "Roots: " + root1.to_s + " and " + root2.to_s
        end
        Xv = (-bVal/(2*aVal)).to_f
        Yv = ((aVal*Xv*Xv) + (bVal*Xv) + cVal).to_f
        puts "Apex = " + Xv.to_s + ";" + Yv.to_s
        puts ""
        valDefined = true
    end
    print "Value for X: "
    currX = gets.chomp.to_f
    currSol = ((aVal*currX*currX) + (bVal*currX) + cVal).to_f
    puts "Solution for X=" + currX.to_s + ": " +currSol.to_s
    puts ""
end