
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
