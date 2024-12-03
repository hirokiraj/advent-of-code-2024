# Common for both part of the day
# Get inputs and put em in sorted arrays
file = File.open('lists.txt')

llist, rlist = [], []
file.each do |line|
  values = line.split('   ')
  llist << values[0].to_i
  rlist << values[1].to_i
end
llist.sort!
rlist.sort!

# Part 1
total_distance = 0

llist.each_with_index do |item, index|
  total_distance += (item - rlist[index]).abs
end

puts "D1P1 -> Total distance is: #{total_distance}"

# Part 2
similarity_score = 0
rhash = rlist.to_h { |item| [item, rlist.count(item)] }

llist.each do |value|
  similarity_score += value * (rhash[value] || 0)
end

puts "D1P2 -> Similiarity score is: #{similarity_score}"
