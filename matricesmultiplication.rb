#Matrices multiplication
def receiveNumber min, max, message
    isOK = false
    while !isOK
        print message
        rcv = gets.chomp.to_f
        if ((rcv >= min) and (rcv <= max))
            return rcv
            isOK = true
        else
            puts "Invalid value"
        end
    end
end

def outputM cols, line 
    #for i in 0..line 
        accept = false
        while !accept
            print "Line " + (line+1).to_s + ": "
            rcv = gets
            if rcv == nil
                puts "Empty line"
            else
                testing = rcv.chomp.split(",").map(&:to_f)
                if testing.length == cols
                    return testing
                    accept = true
                else
                    puts "Wrong number of elements"
                end
            end
        end
    #end
end

puts "Matrices multiplication"
while true
    lines1 = receiveNumber(1, 999, "Number of lines on the first matrix: ")
    columns1 = receiveNumber(1, 999, "Number of columns on the first matrix: ")
    lines2 = receiveNumber(1, 999, "Number of lines on the second matrix: ")
    columns2 = receiveNumber(1, 999, "Number of columns on the second matrix: ")
    if (columns1 != lines2)
        puts "Can't multiply those matrices"
    else
#matrix1 = new array[lines1][columns1]
#matrix2 = new array[lines2][columns2]
#matrixR = new array[lines1][columns2]
#matrix1 = Array.new(lines1, Array.new(columns1, 0))
#matrix2 = Array.new(lines2, Array.new(columns2, 0))
#matrixR = Array.new(lines1, Array.new(columns2, 0))
        matrix1 = Array.new(lines1) { Array.new(columns1) { 0 } }
        matrix2 = Array.new(lines2) { Array.new(columns2) { 0 } }
        matrixR = Array.new(lines1) { Array.new(columns2) { 0 } }
        possib = ["1", "2"]
        ans = ""
        while !possib.include?(ans)
            print "Type each element (1) or type each line (2)?: "
            ans = gets.chomp.downcase
            if ans == "1"
                for n in 0..lines1-1
                    for m in 0..columns1-1
                        matrix1[n][m] = receiveNumber(-999, 999, ("a" + (n+1).to_s + (m+1).to_s + "="))
#print matrix1
#puts
                    end
                end
                #print matrix1
                puts
#for n in 0..(((columns1*lines1)**2)-1)
#matrix1[n%columns1][n] = receiveNumber(-999, 999, ("a" + ((n%columns1)+1).to_s + (n+1).to_s + "="))
#print matrix1
#puts
#end
                for p in 0..columns2-1
                    for q in 0..lines2-1
                        matrix2[p][q] = receiveNumber(-999, 999, ("b" + (p+1).to_s + (q+1).to_s + "="))
#print matrix2
#puts
                    end
                end
                #print matrix2
                puts
            elsif ans == "2"
                puts "Matrix 1"
                for i in (0..(lines1-1))
                    matrix1[i] = outputM((columns1), i)
                end
                #curr = ""
                #for i in (0..(lines1-1))
                    #while curr == ""
                       # print "Line " + (i + 1).to_s + ": "
                        #curr = gets
                        ##if curr != nil
                            #curr = curr.chomp
                            #testing = curr.split(",").map(&:to_r)
                           # if testing.length == columns1
                           # matrix1[i] = testing
                        #else
                            #curr = ""
                        #end
                    #end
                #end
                #print matrix1
                puts
                puts "Matrix 2"
                for k in 0..(lines2-1)
                    matrix2[k] = outputM(columns2, k)
                end
                #curr = ""
                #for k in (0..(lines2-1))
                    #while curr == ""
                        #print "Line " + (k + 1).to_s + ": "
                        #curr = gets.chomp
                    #end
                    #matrix2[k] = curr.split(",").map(&:to_r)
                    #curr = ""
                #end
                #print matrix2
                puts
            else
                puts "Unknown command"
            end
        end
        #Same as lines2-1
        magicNum = columns1 - 1

        #print "Start: " + matrixR.to_s
        #puts
        
        for y in 0..(lines1-1)
            for x in 0..(columns2-1)
                for i in 0..magicNum
                #DEBUG
                    #print "x: " + x.to_s
                    #print " y: " + y.to_s
                    #print " i: " + i.to_s
                    #puts 
                    #puts "Accessing matrix1[" + y.to_s + "][" + (i).to_s + "] and matrix2[" + (i).to_s + "][" + x.to_s + "] and matrixR[" + y.to_s + "][" + x.to_s + "]"
                    #puts "Matrix1: " + matrix1[y][i].to_s
                    #puts "Matrix2: " + matrix2[i][x].to_s
                    #print "Was " + matrixR[x][y].to_s

                    val1 = matrix1[y][i]
                    val2 = matrix2[i][x]
#puts (val1*val2).to_s
                    matrixR[y][x] += (val1*val2)

                    #DEBUG
                    #puts ", added " + matrix1[y][i].to_s + "*" + matrix2[i][x].to_s + "(=" + (matrix1[y][i]*matrix2[i][x]).to_s + "), becoming " + matrixR[y][x].to_s
                    
                end
                #puts "Next column"
            end
            #puts "Next line"
        end

#for x in 0..(columns2-1)
#for y in 0..(lines1-1)

#for j in 0..(columns2-1)
#for i in 0..(lines1-1)
#print "X range: (0.." + (columns2-1).to_s + ")"
#print "Y range: (0.." + (lines1-1).to_s + ")"

#print "x: " + x.to_s
#print " y: " + y.to_s
#print " i: " + i.to_s
#puts
#puts " j: " + j.to_s

#puts "matrix1: " + matrix1[x][y].to_s
#puts "matrix2: " + matrix2[x][y].to_s
#print "Was " + matrixR[x][y].to_s
#matrixR[x][y] += matrix1[x][y]*matrix2[x][y]
#puts ", added " + matrix1[x][y].to_s + "*" + matrix2[x][y].to_s + "(=" + (matrix1[x][y]*matrix2[x][y]).to_s + "), becoming " + matrixR[x][y].to_s
#print matrixR
#puts
#end
#end

#end
#end
        
        
        puts "Result: "
        
        for k in 0..(lines1-1)
            print matrixR[k]
            puts
        end
        puts
        puts "--//--"
        puts
    end
end
