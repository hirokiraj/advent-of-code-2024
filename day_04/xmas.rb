grid = File.open('input.txt').map {|l| l.gsub("\n", '').chars }

#D4P1
xmas_count = 0
for i in 0..grid.size-1 do
  for j in 0..grid[i].size-1 do
    next unless grid[i][j] == 'X'
    xmas_count += 1 if j < grid[i].size - 3 && grid[i][j+1] == 'M' && grid[i][j+2] == 'A'  && grid[i][j+3] == 'S'
    xmas_count += 1 if j > 2 && grid[i][j-1] == 'M' && grid[i][j-2] == 'A'  && grid[i][j-3] == 'S'    
    xmas_count += 1 if i < grid.size - 3 && grid[i+1][j] == 'M' && grid[i+2][j] == 'A'  && grid[i+3][j] == 'S'
    xmas_count += 1 if i > 2 && grid[i-1][j] == 'M' && grid[i-2][j] == 'A'  && grid[i-3][j] == 'S'
    xmas_count += 1 if i < grid.size - 3 && j < grid[i].size - 3 && grid[i+1][j+1] == 'M' && grid[i+2][j+2] == 'A'  && grid[i+3][j+3] == 'S'
    xmas_count += 1 if i > 2 && j < grid[i].size - 3 && grid[i-1][j+1] == 'M' && grid[i-2][j+2] == 'A'  && grid[i-3][j+3] == 'S'    
    xmas_count += 1 if i < grid.size - 3 && j > 2 && grid[i+1][j-1] == 'M' && grid[i+2][j-2] == 'A'  && grid[i+3][j-3] == 'S'
    xmas_count += 1 if i > 2 && j > 2 && grid[i-1][j-1] == 'M' && grid[i-2][j-2] == 'A' && grid[i-3][j-3] == 'S'
  end
end
puts "D4P1 xmas count #{xmas_count}"

#D4P2
x_mas_count = 0
for i in 1..grid.size-2 do
  for j in 1..grid[i].size-2 do
    next unless grid[i][j] == 'A'
    x_mas_count += 1 if grid[i-1][j-1] == 'M' && grid[i-1][j+1] == 'S' && grid[i+1][j-1] == 'M' && grid[i+1][j+1] == 'S'
    x_mas_count += 1 if grid[i-1][j-1] == 'S' && grid[i-1][j+1] == 'S' && grid[i+1][j-1] == 'M' && grid[i+1][j+1] == 'M'
    x_mas_count += 1 if grid[i-1][j-1] == 'M' && grid[i-1][j+1] == 'M' && grid[i+1][j-1] == 'S' && grid[i+1][j+1] == 'S'
    x_mas_count += 1 if grid[i-1][j-1] == 'S' && grid[i-1][j+1] == 'M' && grid[i+1][j-1] == 'S' && grid[i+1][j+1] == 'M'
  end
end
puts "D4P2 x-mas count #{x_mas_count}"
