from itertools import combinations

input = ['a', 'b', 'c', 'd']

output = sum([map(list, combinations(input, i)) for i in range(len(input) + 1)], [])
