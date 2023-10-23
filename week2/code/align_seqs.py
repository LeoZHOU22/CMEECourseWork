#align_seqs.py
# Two example sequences to match
seq2 = "ATCGCCGGATTACGGG"
seq1 = "CAATTCGGAT"

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)

def read_sequences_from_file(filename):
    with open(filename, 'r') as file:
        seq1 = file.readline().strip()
        seq2 = file.readline().strip()
    return seq1, seq2

def write_to_file(filename, s1, best_align, best_score):
    with open(filename, 'w') as file:
        file.write("Best Alignment:\n")
        file.write(s1 + "\n")
        file.write(best_align + "\n")
        file.write("Best Score: " + str(best_score))

# Reading sequences from an external file
seq1, seq2 = read_sequences_from_file('../data/sequences.csv')

# ... [The rest of the code remains unchanged till the best alignment calculation]

# Write the best alignment to an output file
write_to_file('../results/alignment_result.txt', s1, my_best_align, my_best_score)