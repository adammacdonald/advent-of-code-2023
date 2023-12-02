# Commented code solves part 2

input = File.read('input.txt')
items = input.split("\n")
numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
sum = 0

items.each do |item|
  first_numeric_index = first_word_index = item.length
  last_numeric_index = last_word_index = -1
  first_word = last_word = nil

  #numbers.each do |number|
  #  word_index = item.index(number)
  #  next if word_index.nil?
  #
  #  r_word_index = item.rindex(number)
  #  
  #  if first_word_index > word_index
  #    first_word = number
  #    first_word_index = word_index
  #  end
  #
  #  if last_word_index < r_word_index
  #    last_word = number
  #    last_word_index = r_word_index 
  #  end
  #end
  
  
  first_number = item[/\d/]
  last_number = item.reverse[/\d/]

  #first_numeric_index = item.index(first_number)
  #last_numeric_index =  item.rindex(last_number)
  
  first = first_number
  #first = numbers.index(first_word) unless first_word.nil? || first_word_index > first_numeric_index

  last = last_number
  #last = numbers.index(last_word) unless last_word.nil? || last_word_index < last_numeric_index

  sum += "#{first.to_s}#{last.to_s}".to_i
end

puts sum