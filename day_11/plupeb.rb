filename = 'input.txt'
pebbles = File.open(filename).first.split(' ').map(&:to_i)

# NOTE: old solution for P1 that obv stopped scaling around 39th blink for P2
# NOTE: left here for just as a reference
# def blink(pebbles)
#   pebbles.each_with_index do |value, index|
#     if @results_cache[value]
#       pebbles[index] = @results_cache[value]
#     elsif value == 0
#       pebbles[index] = 1
#     elsif ((digits_count = (Math.log10(value).to_i + 1)) % 2) == 0
#       divider = 1
#       (digits_count / 2).times { divider *= 10 }
#       new_pebbles = [value / divider, value % divider]
#       @results_cache[value] = new_pebbles
#       pebbles[index] = new_pebbles
#     else
#       new_val = value * 2024
#       @results_cache[value] = new_val
#       pebbles[index] = new_val
#     end
#   end
#   pebbles.flatten!
# end

def blink(results_cache, values_counts)
  new_counts = {}
  values_counts.keys.each do |value|
    count = values_counts[value]
    next unless count

    if results_cache[value]
      if results_cache[value].is_a?(Array)
        new_counts[results_cache[value][0]] ||= 0
        new_counts[results_cache[value][0]] += count
        new_counts[results_cache[value][1]] ||= 0
        new_counts[results_cache[value][1]] += count
      else
        new_counts[results_cache[value]] ||= 0
        new_counts[results_cache[value]] += count
      end
    elsif value == 0
      new_counts[1] ||= 0
      new_counts[1] += count
    elsif ((digits_count = (Math.log10(value).to_i + 1)) % 2) == 0
      divider = 1
      (digits_count / 2).times { divider *= 10 }
      new_pebbles = [value / divider, value % divider]
      results_cache[value] = new_pebbles

      new_counts[value / divider] ||= 0
      new_counts[value / divider] += count
      new_counts[value % divider] ||= 0
      new_counts[value % divider] += count
    else
      new_val = value * 2024
      results_cache[value] = new_val
      
      new_counts[new_val] ||= 0
      new_counts[new_val] += count
    end
  end
  new_counts
end

# D11P1
results_cache = {}
values_counts = {}
pebbles.each { |p| values_counts[p] = values_counts[p] ? values_counts[p] + 1 : 1 }
25.times do
  values_counts = blink(results_cache, values_counts)
end
p "D11P1: pebbles count is: #{values_counts.values.reduce(&:+)}"

# D11P2
results_cache = {}
values_counts = {}
pebbles.each { |p| values_counts[p] = values_counts[p] ? values_counts[p] + 1 : 1 }
75.times do
  values_counts = blink(results_cache, values_counts)
end
p "D11P2: pebbles count is: #{values_counts.values.reduce(&:+)}"
