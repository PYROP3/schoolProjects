while true
print "A1 = "
a1Val = gets.chomp.to_r
validQ = false
while !validQ
print "Q = "
qVal = gets.chomp.to_r
if qVal >= 1
puts "qVal must be smaller than 1"
elsif qVal == 0
puts "qVal must not be 0"
else
validQ = true
end
end
infiniteSum = a1Val/(1-(qVal))
puts "Infinite sum is: " + infiniteSum.to_s
puts "--//--"
end