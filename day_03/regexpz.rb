input = File.open('input.txt').map{ |l| l }.join('')
# D3P1
r = input.scan(/mul\(\d{1,3},\d{1,3}\)/).map do |muli|
  muli.scan(/\d{1,3}/).map(&:to_i).reduce(:*)
end.reduce(:+)
puts "D3P1: #{r}"
#D3P2
r = input.split('do()').map { |a| a.split("don't()")[0] }.join("").scan(/mul\(\d{1,3},\d{1,3}\)/).map do |muli|
  muli.scan(/\d{1,3}/).map(&:to_i).reduce(:*)
end.reduce(:+)
puts "D3P2: #{r}"

