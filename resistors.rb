def split(rcv, char)
	splitted = Array.new((rcv.count(char)), "")
	#puts "Length = " + (rcv.count(char) + 1).to_s
	curr = ""
	i = 0
	rcv.each_byte { |x|
		ana = x.chr
		if ana == char
			splitted[i] = curr
			i += 1
			curr = ""
		else
			curr << ana
		end
		#puts ana
		#puts i.to_s
		#puts
		#puts splitted.join(" ")
		#print splitted
		#puts
		#puts
	}
	#splitted[i + 1] = curr
	return splitted << curr
end

def insertDots num
	inp = num.to_s.reverse
	out = ""
	counting = 0
	for i in (0..(inp.length-1))
		out << inp[i]
		out << "\'" if counting == 2 && i < inp.length - 1
		counting += 1 unless inp[i] == "."
		counting = 0 if counting == 3
	end
	return out.reverse
end

nums = {"black" => 0, "brown" => 1, "red" => 2, "orange" => 3, "yellow" => 4, "green" => 5, "blue" => 6, "violet" => 7, "grey" => 8, "white" => 9}
multi = {"black" => 1, "brown" => 10, "red" => 100, "orange" => 1000, "yellow" => 10000, "green" => 100000, "blue" => 1000000, "violet" => 10000000, "grey" => 100000000, "white" => 1000000000, "gold" => 0.1, "silver" => 0.01}
tolerance = {"brown" => 1, "red" => 2, "green" => 0.5, "blue" => 0.25, "violet" => 0.1, "grey" => 0.05, "gold" => 5, "silver" => 10}
temperature = {"brown" => 100, "red" => 50, "orange" => 15, "yellow" => 25}

possibLengths = [4, 5, 6]

puts "Resistor color code"
while true
	print "Colors: "
	rcv = gets.chomp.downcase
	vals = split(rcv, " ")
	
	#Check
	okay = false
	errorIn = 0
	errorCase = 0
	
	if (possibLengths.include?(vals.length))
		case vals.length
			when 4, 5
				vals.each_index { |x| 
					if x < vals.length - 2
						okay = nums.has_key?(vals[x])
						errorCase = 0
					elsif x == vals.length - 2
						okay = multi.has_key?(vals[x])
						errorCase = 1
					else
						okay = tolerance.has_key?(vals[x])
						errorCase = 2
					end
					errorIn = x unless okay == true
					break unless okay == true
				}
			when 6
				vals.each_index { |x| 
					if x < vals.length - 3
						okay = nums.has_key?(vals[x])
						errorCase = 0
					elsif x == vals.length - 3
						okay = multi.has_key?(vals[x])
						errorCase = 1
					elsif x == vals.length - 2
						okay = tolerance.has_key?(vals[x])
						errorCase = 2
					else
						okay = temperature.has_key?(vals[x])
						errorCase = 3
					end
					errorIn = x unless okay == true
					break unless okay == true
				}
			end
	
		errorCases = [nums, multi, tolerance, temperature]
		
		if (vals[0] != "black" && okay)
			case vals.length
				when 4
					out = (nums[vals[0]]*10 + nums[vals[1]])*multi[vals[2]]
					tol = tolerance[vals.last]
					temp = "?"
				when 5
					out = (nums[vals[0]]*100 + nums[vals[1]]*10 + nums[vals[2]])*multi[vals[3]]
					tol = tolerance[vals.last]
					temp = "?"
				when 6	
					out = (nums[vals[0]]*100 + nums[vals[1]]*10 + nums[vals[2]])*multi[vals[3]]
					tol = tolerance[vals[vals.length-2]]
					temp = temperature[vals.last]
				end
			print "Value: " + insertDots(out).to_s + " Ohms; Tolerance: +/- " + tol.to_s + "%"
			puts temp != "?" ? "; Temperature Coefficient: " + temp.to_s + "ppm" : ""
		elsif (!okay)
			puts "Found invalid value at index " + errorIn.to_s + " (" + vals[errorIn] + "); "
		else
			puts "First value cannot be black"
		end
	else
		puts "Invalid band number"
	end
	puts "--//--\n"
end