input = File.read('input.txt')
games = input.split("\n")

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

game_sum = 0
game_power_sum = 0

games.each do |game|
  game_parts = game.split(':')
  game_id = game_parts[0].split(' ').last.to_i
  pulls = game_parts[1]
  game_valid = true

  max_required_red = 0
  max_required_blue = 0
  max_required_green = 0

  pulls.split(';').each do |pull|
    pull_parts = pull.split(',')
    pull_parts.each do |pull_part|
      block_parts = pull_part.split(' ')
      block_colour = block_parts[1]
      block_count = block_parts[0].strip.to_i

      case block_colour
      when 'red'
        max_required_red = block_count if block_count > max_required_red
        game_valid = false if block_count > MAX_RED
      when 'green'
        max_required_green = block_count if block_count > max_required_green
        game_valid = false if block_count > MAX_GREEN
      when 'blue'
        max_required_blue = block_count if block_count > max_required_blue
        game_valid = false if block_count > MAX_BLUE
      end
    end
  end

  game_sum += game_id if game_valid
  game_power_sum += max_required_red * max_required_blue * max_required_green
end

puts game_sum
puts game_power_sum