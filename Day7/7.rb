input = File.read('input.txt')
hands = input.split("\n")

def hand_type(cards)
  types = {
    1 => [1,1,1,1,1], # High Card
    2 => [2,1,1,1],   # One Pair
    3 => [2,2,1],     # Two Pairs
    4 => [3,1,1],     # Three of a Kind
    5 => [3,2],       # Full House
    6 => [4,1],       # Four of a Kind
    7 => [5]          # Five of a Kind
  }

  # Part 2
  sorted_set = cards.split('').tally.sort_by { |k, v| [v, k] }.reverse.to_h
  
  if sorted_set.has_key?("J") && sorted_set.keys.length > 1
    j = sorted_set["J"]
    sorted_set.delete("J")
    sorted_set[sorted_set.keys[0]] += j
  end
  
  types.index(sorted_set.values.sort.reverse)

  # Part 1
  # types.index(cards.split('').tally.values.sort.reverse) 
end

def sort_string(cards)
  # card_values = ['2','3','4','5','6','7','8','9','T','J','Q','K','A'] # Part 1
  card_values = ['J','2','3','4','5','6','7','8','9','T','Q','K','A'] # Part 2
  sort_values = ['A','B','C','D','E','F','G','H','I','J','K','L','M']
  sort_string = ""
  cards.split('').each do |card|
    sort_string << sort_values[card_values.index(card)]
  end
  sort_string
end


total = 0
hand_details = {}
hands.each do |hand|
  cards = hand.split(' ')[0]
  bet = hand.split(' ')[1]

  hand_details[cards] = {}
  hand_details[cards][:bet] = bet
  hand_details[cards][:hand_type] = hand_type(cards)
  
  hand_details[cards][:sort_string] = sort_string(cards)
end

hand_details.sort_by { |k, v| [ v[:hand_type], v[:sort_string] ] }.each.with_index(1) do |(k, v), index|
  total += index * v[:bet].to_i
end

p total