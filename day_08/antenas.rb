require 'matrix'
filename = 'input.txt'

def find_antenas(grid)
  antenas = {}
  grid.each_with_index do |elem, x, y|
    unless elem == '.' || elem == '#'
      antenas[elem] = [] unless antenas[elem]
      antenas[elem] << [x, y]
    end
  end
  antenas
end

# D8P1
grid = Matrix[*(File.open(filename).map { |l| l.gsub("\n", '').chars })]
antenas = find_antenas(grid)
antenas.each do |name, positions|
  positions.repeated_combination(2).reject {|p| p[0] == p[1]}.each do |pair|
    dist_x = (pair[0][0] - pair[1][0])
    dist_y = (pair[0][1] - pair[1][1])

    s1x = pair[0][0] + dist_x
    s1y = pair[0][1] + dist_y
    grid[s1x, s1y] = '#' if (0..grid.column_size - 1).include?(s1x) && (0..grid.row_size - 1).include?(s1y)

    s2x = pair[1][0] - dist_x
    s2y = pair[1][1] - dist_y
    grid[s2x, s2y] = '#' if (0..grid.column_size - 1).include?(s2x) && (0..grid.row_size - 1).include?(s2y)
  end
end
antinodes_count = 0
grid.each { |e| antinodes_count += 1 if e == '#' }

puts "D8P1: antinodes in bounds count: #{antinodes_count}"

# D8P2
grid = Matrix[*(File.open(filename).map { |l| l.gsub("\n", '').chars })]
antenas = find_antenas(grid)
antenas.each do |name, positions|
  positions.repeated_combination(2).reject {|p| p[0] == p[1]}.each do |pair|
    dist_x = (pair[0][0] - pair[1][0])
    dist_y = (pair[0][1] - pair[1][1])

    s1x = pair[0][0]
    s1y = pair[0][1]
    s1_counter = 0
    while (0..grid.column_size - 1).include?(s1x) && (0..grid.row_size - 1).include?(s1y)
      grid[s1x, s1y] = '#'
      s1x = s1x + dist_x
      s1y = s1y + dist_y
    end

    s2x = pair[1][0]
    s2y = pair[1][1]
    s2_counter = 0
    while (0..grid.column_size - 1).include?(s2x) && (0..grid.row_size - 1).include?(s2y)
      grid[s2x, s2y] = '#' 
      s2x = s2x - dist_x
      s2y = s2y - dist_y
    end
  end
end
antinodes_count = 0
grid.each { |e| antinodes_count += 1 if e == '#' }

puts "D8P2: antinodes in bounds with resonant harmonics count: #{antinodes_count}"

