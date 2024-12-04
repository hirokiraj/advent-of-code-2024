reports = File.open('reports.txt').map { |l| l.split(' ').map(&:to_i) }

# Shared common methods
def order_ok?(report)
  report == report.sort || report.reverse == report.sort
end

def distance_ok?(report)
  (1..(report.size-1)).each do |i|
    distance = (report[i] - report[i - 1]).abs
    return false if distance == 0 || distance > 3  
  end
  true
end

# D2P1
safe_count = 0
reports.each { |r| safe_count += 1 if order_ok?(r) && distance_ok?(r) }
puts "D2P1 - safe count: #{safe_count}"

# D2P2
safe_count = 0
reports.map do |r| 
  [r].concat(r.combination(r.size - 1).map { |c| c }).each do |v| 
    if order_ok?(v) && distance_ok?(v)
      safe_count += 1
      break
    end
  end
end
puts "D2P2 - safe_count: #{safe_count}"
