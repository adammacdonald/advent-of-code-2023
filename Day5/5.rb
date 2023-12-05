require './input.rb'

def get_data_set(data)
  data.split("\n").map { |value| value.split(" ") }.map { |value| value.map(&:to_i) }
end

def find_destination_for_target_in_set(target, set)
  set = get_data_set(set)
  set.each do |map|
    destination = map[0]
    source = map[1]
    range = map[2]

    lower_bound = source
    upper_bound = source + range
    destination_found = target.between?(lower_bound, upper_bound)

    return destination + (target - lower_bound) if destination_found
  end
  return target
end

lowest_location = nil

seeds_values = @seeds.split(" ")

seed_sets = []
(0...seeds_values.length).step(2).each do |seed|
  seed_sets << [seeds_values[seed].to_i, seeds_values[seed + 1].to_i]
end

# Part 1
seeds_to_plant = seeds_values

# Part 2
#seed_sets.each do |seed_set|
#  seed_start = seed_set[0]
#  seed_end = seed_set[0] + seed_set[1]
#  seeds_to_plant = (seed_start..seed_end).to_a

  seeds_to_plant.each do |seed|
    seed = seed.to_i
    # for seed find soil
    soil = find_destination_for_target_in_set(seed, @soil)

    # for soil find fertilizer
    fertilizer = find_destination_for_target_in_set(soil, @fertilizer)

    # for fertilizer find water
    water = find_destination_for_target_in_set(fertilizer, @water)

    # for water find light
    light = find_destination_for_target_in_set(water, @light)

    # for light find temperature
    temperature = find_destination_for_target_in_set(light, @temperature)

    # for temperature find humidity
    humidity = find_destination_for_target_in_set(temperature, @humidity)

    # for humidity find location
    location = find_destination_for_target_in_set(humidity, @location)

    # if location is lower than lowest_location, update lowest_location
    lowest_location = location if lowest_location.nil? || location < lowest_location
  end
#end

puts "lowest_location: #{lowest_location}"