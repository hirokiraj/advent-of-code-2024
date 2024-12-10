encoded_seq = File.open('input.txt').first

def unpack_data(encoded)
  disk_data = []
  file_index = 0
  block_type = [:file, :free]
  encoded.chars.each do |segment|
    disk_data += Array.new(segment.to_i, file_index) if block_type.first == :file
    disk_data += Array.new(segment.to_i, '.') if block_type.first == :free
    block_type = block_type.rotate
    file_index += 1 if block_type.first == :file
  end
  disk_data
end

def calculate_checksum(disk_data)
  checksum = 0
  disk_data.each_with_index do |value, index|
    checksum += value * index if value != '.'
  end
  checksum
end

#D9P1
def defrag_data(disk_data)
  put_index = 0
  take_index = disk_data.size - 1

  while put_index < take_index
    if disk_data[put_index] != '.'
      put_index += 1
    elsif disk_data[take_index] == '.'
      take_index -= 1
    else
      val = disk_data[take_index]
      disk_data[take_index] = '.'
      disk_data[put_index] = val
    end
  end
  disk_data
end

disk_data = unpack_data(encoded_seq)
disk_data = defrag_data(disk_data)
checksum = calculate_checksum(disk_data)
p "D9P1: checksum is: #{checksum}"

# D9P2
def defrag_whole_files(disk_data)
  file_start = disk_data.size - 1
  file_end = disk_data.size - 1
  while file_end >= 0
    if disk_data[file_end] == '.'
      file_end -= 1
      file_start = file_end
    elsif disk_data[file_start - 1] == disk_data[file_end]
      file_start -= 1
    else
      input_start = 0
      input_end = 0
      while input_start < file_start
        if disk_data[input_start] != '.'
          input_start += 1
          input_end = input_start
        elsif disk_data[input_end + 1] == disk_data[input_end]
          input_end += 1
        elsif (input_end - input_start) >= (file_end - file_start) && input_start < file_start
          disk_data[input_start..(input_start+(file_end - file_start))] = disk_data[file_start..file_end]
          disk_data[file_start..file_end] = Array.new((file_end - file_start + 1), '.')
          input_start = disk_data.size
        else
          input_start = input_end + 1
          input_end = input_start
        end
      end
      file_start -= 1
      file_end = file_start
    end
  end
  disk_data
end

disk_data = unpack_data(encoded_seq)
disk_data = defrag_whole_files(disk_data)
checksum = calculate_checksum(disk_data)
p "D9P2: checksum is: #{checksum}"
