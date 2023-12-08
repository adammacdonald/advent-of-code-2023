input = File.read('input.txt')
directions, list_of_nodes = input.split("\n\n")

nodes = {}
list_of_nodes.split("\n").map do |node|
  n = node.split(' = ')
  next_nodes = n[1].gsub!('(','').gsub!(')','').split(', ')
  nodes[n[0]] = {L: next_nodes[0], R: next_nodes[1]}
end

hops_to_locate = []
#current_nodes = ['AAA']
current_nodes = nodes.keys.select { |k| k.end_with?('A') }

current_nodes.each do |current_node|
  hops = 0
  until current_node.end_with?('Z')
    instruction = directions[hops % directions.length]
    current_node = nodes[current_node][instruction.to_sym]
    hops += 1
  end
  hops_to_locate << hops
end

p hops_to_locate.reduce(1, :lcm)