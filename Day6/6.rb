input = File.read('input.txt')

times     = input.split("\n")[0].split(":")[1].split.map(&:to_i)
records = input.split("\n")[1].split(":")[1].split.map(&:to_i)

# Part 1
wins = []
times.each_with_index do |time, index|
  wins_for_time = 0
  (0...time).each do |hold_time|
    distance = (time - hold_time) * hold_time
    wins_for_time += 1 if distance > records[index]
  end
  wins << wins_for_time
end

p wins.inject(:*)

# Part 2
time = times.join.to_i
record = records.join.to_i

first_win = 0
(0...time).each do |hold_time|
  distance = (time - hold_time) * hold_time
  first_win = hold_time if distance > record
  break if first_win > 0
end

wins = time - (first_win * 2) + 1

p wins