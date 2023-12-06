seed_range_list = []
map_list_list = []

class Range
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end

  def length
    self.end - self.begin
  end

  def to_human
    "#{self.begin.to_s.gsub(/\B(?=(...)*\b)/, ',')}..#{self.end.to_s.gsub(/\B(?=(...)*\b)/, ',')}"
  end
end

def new_range(range, delta)
  (range.begin + delta)..(range.end + delta)
end

File.read("input.txt").split("\n\n").each_with_index do |data_set, line_index|
  if line_index == 0
    num_list = data_set.match(/seeds: (?<nums>.*)/)[:nums].split(" ").map(&:to_i)

    num_list.each_slice(2) do |start, length|
      seed_range_list.push(
        start..(start + length - 1)
      )
    end

    next
  end

  line_list = data_set.split("\n")
  current_map_list = []
  line_list[1..-1].each do |line|
    data = line.split(" ").map(&:to_i)
    current_map_list.push({
      range: data[1]..(data[1] + data[2]),
      length: data[2],
      delta: data[0] - data[1],
    })
  end

  current_map_list.sort_by! { |x| x[:range].begin }
  map_list_list.push(current_map_list)
end

seed_range_list.sort_by!(&:begin)

lowest = Float::INFINITY

map_list_list.each_with_index do |map_list, map_list_index|
  new_seed_range_list = []

  map_list.each_with_index do |map, map_index|
    seed_index = 0
    while seed_index < seed_range_list.length
      puts "progress: #{map_list_index}/#{map_list_list.length} #{map_index}/#{map_list.length} -> #{seed_index}/#{seed_range_list.length}"
      seed_range = seed_range_list[seed_index]

      if seed_range.nil?
        nil
      elsif seed_range.overlaps?(map[:range]) == false
        nil
      elsif map[:range].begin <= seed_range.begin && map[:range].end >= seed_range.end
        # <----(......)----->
        new_seed_range_list.push(new_range(seed_range, map[:delta]))
        seed_range_list[seed_index] = nil
      elsif seed_range.begin < map[:range].begin && map[:range].end < seed_range.end
        # (......<----->....)
        seed_range_list.push(
          seed_range.begin..(map[:range].begin - 1)
        )

        seed_range_list.push(
          (map[:range].end + 1)..seed_range.end
        )

        seed_range_list[seed_index] = nil

        new_seed_range_list.push(
          new_range(
            map[:range].begin..map[:range].end,
            map[:delta],
          )
        )
      elsif seed_range.begin <= map[:range].begin && seed_range.end <= map[:range].end
        # (....<----......)----->   => (.....)<!!!!!!!><------->
        if seed_range.begin != map[:range].begin
          seed_range_list[seed_index] = seed_range.begin..(map[:range].begin - 1)
        end

        new_seed_range_list.push(
          new_range(
            map[:range].begin..seed_range.end,
            map[:delta],
          )
        )
      elsif map[:range].begin <= seed_range.begin && map[:range].end < seed_range.end
        # <----------(.....---->....)   => <----------><!!!!!!!>(.....)
        if map[:range].end != seed_range.end
          seed_range_list[seed_index] = map[:range].end..seed_range.end
        end

        new_seed_range_list.push(
          new_range(
            seed_range.begin..map[:range].end,
            map[:delta],
          )
        )
      else
        pp map
        pp seed_range
        raise "unhandled case"
      end

      seed_index += 1
    end
  end

  seed_range_list = seed_range_list.compact
  seed_range_list = new_seed_range_list + seed_range_list
  seed_range_list.sort_by!(&:begin)

  seed_index = 0
  while seed_index < seed_range_list.length - 1
    if seed_range_list[seed_index].overlaps?(seed_range_list[seed_index + 1])
      seed_range_list[seed_index] = seed_range_list[seed_index].begin..seed_range_list[seed_index + 1].end
      seed_range_list.delete_at(seed_index + 1)
    else
      seed_index += 1
    end
  end
end

pp seed_range_list.sort_by(&:begin).first.begin
pp seed_range_list.count