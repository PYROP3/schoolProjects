#Matrices multiplication
def receiveNumber min, max, message
isOK = false
while !isOK
print message
rcv = gets.chomp.to_i
if ((rcv >= min) and (rcv <= max)
return rcv
isOK = true
else
puts "Invalid value"
end
end
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
matrix1 = new array[lines1][columns1]
matrix2 = new array[lines2][columns2]
matrixR = new array[lines1][columns2]
for n in 1..columns1
for m in 1..lines1
matrix1[m-1][n-1] = receiveNumber(-999, 999, ("a" + m.to_s + n.to_s + "="))
end
end

for q in 1..columns2
for p in 1..lines2
matrix2[p-1][q-1] = receiveNumber(-999, 999, ("b" + p.to_s + q.to_s + "="))
end
end

for y in 0..(columns2-1)
for x in 0 (lines1-1)

for i in 0..(columns2-1)
matrixR[x][y] = matrix1[1][i]*matrix2[i][1]
end

end
end

for k in 0..(columns2-1)
print matrixR[k]
puts
end

puts "--//--"

end
end
