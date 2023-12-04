input = File.read('input.txt')
cards = input.split("\n")


result = 0
card_set = {}

cards.each.with_index(1) do |card, card_index|
  parts = card.split(":")[1].split("|")
  winners = parts[0].split(" ")
  numbers = parts[1].split(" ")

  winning_matches = winners & numbers
  result += 2**(winning_matches.length-1) unless winning_matches.empty?
  card_set[card_index] = { runs: 1, winning_matches: winning_matches }
end
p result


card_set.each do |card_index, card|
  (1..card[:runs]).each do
    (1..card[:winning_matches].length).each.with_index(1) do |_, update_counter|
      card_set[card_index + update_counter][:runs] += 1 if card_set.key?(card_index + update_counter)
    end
  end
end

p card_set.map { |k, v| v[:runs] }.inject(:+)