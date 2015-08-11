def simplifyNum num, digits
	inp = num.to_s
	out = ""
	counting = 0
	found = false
	validF = ["1","2","3","4","5","6","7","8","9"]
	valid = ["0","1","2","3","4","5","6","7","8","9"]
	inp.each_char { |c| 
		if (!found && validF.include?(c))
			out << c
			found = true
			counting += 1
			#puts "Concatted " + c
		elsif (found && valid.include?(c) && counting < digits)
			out << c
			counting += 1
			#puts "Concatted " + c + " at counting " + (counting-1).to_s
		end
	}
	return out.to_i
end

numbers = {0 => "black", 1 => "brown", 2 => "red", 3 => "orange", 4 => "yellow", 5 => "green", 6 => "blue", 7 => "violet", 8 => "grey", 9 => "white"}
multipliers = {1.0 => "black", 10.0 => "brown", 100.0 => "red", 1000.0 => "orange", 10000.0 => "yellow", 100000.0 => "green", 1000000.0 => "blue", 10000000.0 => "violet", 100000000.0 => "grey", 1000000000.0 => "white", 0.1 => "gold", 0.05 => "silver"}
tolerance = {1.0 => "brown", 2.0 => "red", 3.0 => "orange", 4.0 => "yellow", 0.5 => "green", 0.25 => "blue", 0.1 => "violet", 0.05 => "grey", 5.0 => "gold", 10.0 => "silver", 20.0 => "-no band-", 0.0 => "X"}
tempCoef = {100 => "brown", 50 => "red", 15 => "orange", 25 => "yellow", 0 => "X"}

while true
	bNum = 3
	addTol = false
	addTCo = false
	print "Resistance: "
	res = gets.chomp.to_f
	
	#puts "Received resistance: " + res.to_s
	
	tol = 0
	while !tolerance.has_key?(tol) do
		print "Tolerance (0 = no tolerance (+/-20% by default)): "
		tol = gets.chomp.to_f
		if !tolerance.has_key?(tol)
			puts "Invalid value"
		end
	end
	#break unless tolerance.has_key?(tol)
	#if tol != 0
	if true
		if tol == 0
			tol = 20.0
		end
		while (bNum != 4 && bNum != 5 && bNum != 6)
			print "4, 5 or 6 bands? "
			bNum = gets.chomp.to_i
			if (bNum != 4 && bNum != 5 && bNum != 6)
				puts "Invalid number"
			end
		end
		addTol = true
		if bNum != 4
			temp = 0
			while !tempCoef.has_key?(temp) do
				print "Temperature coefficient (0 = no temp. coeff): "
				temp = gets.chomp.to_i
				if !tempCoef.has_key?(temp) 
					puts "invalid value"
				end
			end
			#break unless tempCoef.has_key?(temp)
			if temp != 0
				bNum = 6
				addTCo = true
			end
		end
	end	
	resistance = 0
	resis = res.to_s
	bands = []
	approx = false
	mathsIsOk = false
	firstTry = true
	oldRes = res
	while !mathsIsOk
		if !firstTry
			#res = ((res/10).floor)*10
			res = ((res/10).floor)
			bands = []
		end
		case bNum
			when 3, 4
				val = simplifyNum(res, 2)
				
				#puts "Val: " + val.to_s
				
				mul = (res/val)
				if mul != mul.ceil
					approx = true
					mul = mul.ceil
				end
				if res*10 == val
					mul = 0.1
				elsif res*20 == val
					mul = 0.05
				end
				
				mathsIsOk = mul*val == res
				
				#puts "Mul: " + mul.to_s
				
				bands << numbers[val.to_s[0].to_i]	
				bands << numbers[val.to_s[1].to_i]
				bands << multipliers[mul.to_f]
				if addTol
					bands << tolerance[tol.to_f]
				end
			when 5, 6
				val = simplifyNum(res, 3)
				mul = (res/val)
				if mul != mul.ceil
					approx = true
					mul = mul.ceil
				end
				if res*10 == val
					mul = 0.1
				elsif res*20 == val
					mul = 0.05
				end
				
				mathsIsOk = mul*val == res
				
				bands << numbers[val.to_s[0].to_i]	
				bands << numbers[val.to_s[1].to_i]
				bands << numbers[val.to_s[2].to_i]
				bands << multipliers[mul.to_f]
				bands << tolerance[tol.to_f]
				if addTCo
					bands << tempCoef[temp] 
				end
		end
		firstTry = false
		
	end
	puts "\nBand colors: " + bands.join(" ") 
	puts "\nMaths didn't work out, try a bigger band number (test with " + (bNum + 1).to_s + " bands)" if !mathsIsOk
	puts "Maths failed; RESISTOR does not exist. Approximated resistance value " + oldRes.to_s + " to " + res.to_s if approx
	puts "\n--\\--\n"
end