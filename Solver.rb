while true
print "Value for A: "
valueA = gets.chomp.to_r;
print "Value for B: "
valueB = gets.chomp.to_r;
print "Value for C: "
valueC = gets.chomp.to_r;
delta = (valueB*valueB) + ((-4)*valueA*valueC)
puts "Delta: " +delta.to_s
if delta < 0
puts "No real solutions available"
else
solution1 = ((-1)*valueB + Math.sqrt(delta))/(2*valueA)
solution2 = ((-1)*valueB - Math.sqrt(delta))/(2*valueA)
puts "Solutions: " + solution1.to_s + " and " + solution2.to_s
end
puts "--/--"
end