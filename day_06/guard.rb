@filename = 'input.txt'

def paint_grid(grid)
  system("clear") || system("cls")
  grid.each do |l|
    l.each do |c|
      printf c
    end
    puts
  end
end

def find_guard(grid)
  pos_x, pos_y = nil, nil
  (0..grid.size - 1).each do |x|
    (0..grid[x].size - 1).each do |y|
      next unless grid[x][y] == '^'
      pos_x = x
      pos_y = y
      break
    end
  end
  [pos_x, pos_y]
end

def coords_in_bounds?(x, y, grid)
  x >= 0 && x < grid.size && y >= 0 && y < grid[0].size
end

def move_guard(x, y, direction)
  return [x - 1, y] if direction[0] == :up
  return [x, y + 1] if direction[0] == :right
  return [x + 1, y] if direction[0] == :down
  return [x, y - 1] if direction[0] == :left
end

def calculate_direction(x, y, grid, direction)
  new_x, new_y = move_guard(x, y, direction)
  while coords_in_bounds?(new_x, new_y, grid) && grid[new_x][new_y] == '#'
    direction = direction.rotate
    new_x, new_y = move_guard(x, y, direction) 
  end
  direction
end

def march_guard(grid)
  direction = [:up, :right, :down, :left]
  guard_x, guard_y = find_guard(grid)
  steps = 0
  looped = false
  largest_potential_loop = ((grid.size - 1) * (grid[0].size - 1))
  while coords_in_bounds?(guard_x, guard_y, grid) do
    grid[guard_x][guard_y] = 'X'
    direction = calculate_direction(guard_x, guard_y, grid, direction)
    guard_x, guard_y = move_guard(guard_x, guard_y, direction)
    grid[guard_x][guard_y] = '^' if coords_in_bounds?(guard_x, guard_y, grid)
    steps += 1
    if steps > largest_potential_loop
      looped = true
      break
    end
  end
  [grid, looped]
end

def find_all_visited(grid)
  visited_spots = []
  (0..grid.size - 1).each do |x|
    (0..grid[x].size - 1).each do |y|
      next unless grid[x][y] == 'X'
      visited_spots << [x, y]
    end
  end
  new_grid = File.open(@filename).map {|l| l.gsub("\n", '').chars }
  visited_spots - [find_guard(new_grid)]
end

#D6P1
grid = File.open(@filename).map {|l| l.gsub("\n", '').chars }
grid, _ = march_guard(grid)
paint_grid(grid)
visited_count = grid.map { |l| l.join('') }.join('').count('X')
puts "D6P1: visited spots: #{visited_count}"

#D6P2
grid = File.open(@filename).map {|l| l.gsub("\n", '').chars }
grid, _ = march_guard(grid)
looping_counter = 0
printf "<(#{find_all_visited(grid).size})"
find_all_visited(grid).each_with_index do |visited, index|
  printf "#"
  printf "(#{index})" if index % 100 == 0
  modified_grid = File.open(@filename).map {|l| l.gsub("\n", '').chars }
  modified_grid[visited[0]][visited[1]] = '#'
  modified_grid, looped = march_guard(modified_grid)
  looping_counter += 1 if looped
end
puts ">"
puts puts "D6P1: locations that create loops: #{looping_counter}"

