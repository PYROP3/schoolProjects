print "Value for a1: "
a1val = gets.chomp.to_i
print "Value for q: "
qval = gets.chomp.to_i
while true
puts "--//--"
numIsOk = false
while !numIsOk
print "Value to discover: "
nval = gets.chomp.to_r
if nval === nval.to_i
numIsOk = true
else
puts "Number not valid"
end
end
nval = nval -1
nval = nval.to_i
resultval = a1val*(qval^nval)
puts "Result for n = " + (nval+1).to_s + ": " + resultval.to_s
end