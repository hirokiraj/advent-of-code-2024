require 'matrix'
filename = 'input.txt'
grid = Matrix[*(File.open(filename).map { |l| l.gsub("\n", '').chars.map(&:to_i) })]

def traverse(grid, x, y, peaks)
  traverse(grid, x - 1, y, peaks) if x > 0 && grid[x - 1, y] == grid[x, y] + 1
  traverse(grid, x + 1, y, peaks) if x < grid.row_size - 1 && grid[x + 1, y] == grid[x, y] + 1
  traverse(grid, x, y - 1, peaks) if y > 0 && grid[x, y - 1] == grid[x, y] + 1
  traverse(grid, x, y + 1, peaks) if y < grid.column_size - 1 && grid[x, y + 1] == grid[x, y] + 1
  peaks << [x, y] if grid[x, y] == 9
end

# D10P1
trailheads_sum = 0
grid.each_with_index do |val, x, y|
  if val == 0
    peaks = []
    traverse(grid, x, y, peaks)
    trailheads_sum += peaks.uniq.size
  end
end
p "D10P1: all trailheads unique peaks sum: #{trailheads_sum}"

#D10P2
trailheads_ratings_sum = 0
grid.each_with_index do |val, x, y|
  if val == 0
    peaks = []
    traverse(grid, x, y, peaks)
    trailheads_ratings_sum += peaks.size
  end
end
p "D10P2: all trailheads ratings peaks sum: #{trailheads_ratings_sum}"


