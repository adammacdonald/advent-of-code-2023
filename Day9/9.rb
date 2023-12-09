input = File.read('input.txt')
histories = input.split("\n")

def find_next_number(sequence)
  next_number = sequence.last
  until sequence.uniq == [0]
    sequence = sequence.each_cons(2).map{|a,b| b - a}
    next_number += sequence.last
  end
  next_number
end

total = 0
reverse_total = 0
histories.each do |history|
  history = history.split.map(&:to_i)
  total += find_next_number(history)
  reverse_total += find_next_number(history.reverse)
end

p total
p reverse_total

