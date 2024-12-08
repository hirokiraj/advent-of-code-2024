equations = File.open('input.txt').map do |l| 
  { result: l.split(': ')[0].to_i, parts: l.split(': ')[1].split(' ').map(&:to_i) }
end

# D7P1
true_results = []
equations.each do |e|
  ['+', '*'].repeated_permutation(e[:parts].size-1).each do |operations|
    calculated_result = e[:parts][0]
    operations.each_with_index do |oper, index|
      calculated_result += e[:parts][index + 1] if oper == '+'
      calculated_result *= e[:parts][index + 1] if oper == '*'
    end
    if e[:result] == calculated_result
      true_results << e[:result]
      break
    end
  end
end
puts "D7P1: sum of true results #{true_results.reduce(&:+)}"

# D7P2
true_results = []
equations.each do |e|
  ['+', '*', '||'].repeated_permutation(e[:parts].size-1).each do |operations|
    calculated_result = e[:parts][0]
    operations.each_with_index do |oper, index|
      calculated_result += e[:parts][index + 1] if oper == '+'
      calculated_result *= e[:parts][index + 1] if oper == '*'
      calculated_result = "#{calculated_result}#{e[:parts][index + 1]}".to_i if oper == '||'
    end
    if e[:result] == calculated_result
      true_results << e[:result]
      break
    end
  end
end
puts "D7P2: sum of true results #{true_results.reduce(&:+)}"