#Matrices multiplication
def receiveNumber min, max, message
	isOK = false
	while !isOK
		print message
		rcv = gets.chomp.to_i
		if ((rcv >= min) and (rcv <= max))
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
		matrix1 = Array.new(lines1) {Array.new(columns1,0)}
		matrix2 = Array.new(lines2) {Array.new(columns2,0)}
		matrixR = Array.new(lines1) {Array.new(columns2,0)}
		for m in 1..lines1
			for n in 1..columns1
				matrix1[m-1][n-1] = receiveNumber(-999, 999, ("a" + m.to_s + n.to_s + "="))
			end
		end
		print matrix1
		puts
		for p in 1..lines2
			for q in 1..columns2
				matrix2[p-1][q-1] = receiveNumber(-999, 999, ("b" + p.to_s + q.to_s + "="))
			end
		end
		print matrix2
		puts
		magicNum = columns1
		for x in 0..(lines1 - 1)
			for y in 0..(columns2 - 1)
				for k in x..(magicNum - 1)
					for l in y..(magicNum - 1)
					#first retrieve line then column
					puts "Multiplying " + matrix1[k][l].to_s + " by " + matrix2[l][k].to_s
						matrixR[x][y] += matrix1[k][l]*matrix2[l][k]
						puts "Current cell is now " + matrixR[x][y].to_s
					end
				end
			end
		end
		#for y in 0..(columns2-1)
		#	puts "y " + y.to_s
		#	for x in 0..(lines1-1)
		#		puts "x " + x.to_s
		#		for i in 0..(columns1-1)
		#		puts
		#			puts "i " + i.to_s
		#			puts matrix1[1][i].to_s
		#			puts matrix2[i][1].to_s
		#			puts
		#			matrixR[x][y] += matrix1[1][i]*matrix2[i][1]
		#			puts "curr " + matrixR[x][y].to_s
		#		end
#
		#	end
		#end
		puts
		for k in 0..(columns2-1)
			print matrixR[k]
			puts
		end

		puts "--//--"

	end
end