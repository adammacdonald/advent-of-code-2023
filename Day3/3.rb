def load_schematic(input)
  input.split("\n").each_with_index do |row, ri|
    @schematic << row.split("")
    row.each_char.with_index do |char, ci|
      next if char == "."
      next if char =~ /\d/
      @symbols << [ri, ci]
      @gears << [ri, ci] if char == "*"
    end
  end
end

def check_for_parts
  # check for parts around symbols
  found_part_numbers = []
  checks = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  @symbols.each do |(x,y)|
    checks.each do |(x_offset, y_offset)|
      x_check = x + x_offset
      y_check = y + y_offset
      
      found_part_numbers << [x_check, y_check] if @schematic[x_check][y_check] =~ /\d/
    end
  end

  # find the start of part number
  part_numbers_start_locations = []
  found_part_numbers.each do |x,y|
    y -= 1 while @schematic[x][y-1] =~ /\d/
    part_numbers_start_locations << [x,y]
  end
  
  part_numbers_start_locations.uniq.each do |x,y|
    @parts << @schematic[x][y..].join.to_i
  end
end

def check_for_geared_parts
  # check for parts around symbols
  checks = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  @gears.each do |(x,y)|
    found_part_numbers = []
    checks.each do |(x_offset, y_offset)|
      x_check = x + x_offset
      y_check = y + y_offset
      
      found_part_numbers << [x_check, y_check] if @schematic[x_check][y_check] =~ /\d/
    end

    # find the start of part number
    part_numbers_start_locations = []
    geared_parts = []
    found_part_numbers.each do |x,y|
      y -= 1 while @schematic[x][y-1] =~ /\d/
      part_numbers_start_locations << [x,y]
    end
    if part_numbers_start_locations.uniq.length == 2
      part_numbers_start_locations.uniq.each do |x,y|
        geared_parts << @schematic[x][y..].join.to_i
      end

      @gear_ratios << geared_parts[0] * geared_parts[1]
    end
  end
end

input = File.read('input.txt')

@schematic = []
@symbols = []
@gears = []
@gear_ratios = []
@parts = []

load_schematic(input)

check_for_parts
p @parts.sum

check_for_geared_parts
p @gear_ratios.sum
