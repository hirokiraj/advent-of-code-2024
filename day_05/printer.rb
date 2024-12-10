rules = []
updates = []

reading_rules = true
File.open('input.txt').each do |l|
  if l == "\n"
    reading_rules = false
    next 
  end
  rules << l.split("|").map(&:to_i) if reading_rules
  updates << l.split(",").map(&:to_i) unless reading_rules
end

def rules_comparator(order_hash, a, b)
  return 1 if order_hash[b] && order_hash[b].include?(a)
  return -1
end

order_hash = {}
rules.each do |rule|
  order_hash[rule[0]] = [] unless order_hash[rule[0]]
  order_hash[rule[0]] << rule[1]
end

#D5P1
midpoints_sum = 0
updates.each do |update|
  midpoints_sum += update[(update.size.to_f/2.to_f).floor] if update == update.sort { |a,b| rules_comparator(order_hash, a, b) }
end
p "D5P1: midpoints sum: #{midpoints_sum}"

#D5P2
midpoints_sorted_sum = 0
updates.each do |update|
  update_sorted = update.sort { |a,b| rules_comparator(order_hash, a, b) }
  midpoints_sorted_sum += update_sorted[(update_sorted.size.to_f/2.to_f).floor] if update != update_sorted
end
p "D5P2: midpoints of sorted sum: #{midpoints_sorted_sum}"
