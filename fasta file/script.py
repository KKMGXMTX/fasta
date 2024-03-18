import re

def separate_sequences(fasta_file):
    """Separates nucleotide and protein sequences from a FASTA file.

    Args:
        fasta_file: The path to the FASTA file containing sequences.

    Returns:
        A tuple of two lists, the first containing the nucleotide sequences and the
        second containing the protein sequences.
    """
    
    nucleotide_sequences = []
    protein_sequences = []

    with open(fasta_file, "r") as f:
        for line in f:
            if line.startswith(">"):
                # This is a header line, so skip it.
                continue

            # This is a sequence line.
            sequence = line.strip()

            # Check if the sequence is a nucleotide sequence.
            if re.match("[A,C,G,T]+", sequence):
                nucleotide_sequences.append(sequence)
            else:
                # The sequence is a protein sequence.
                protein_sequences.append(sequence)

    return nucleotide_sequences, protein_sequences

# Save the nucleotide and protein sequences to separate files.
nucleotide_sequences, protein_sequences = separate_sequences("C:\\Users\\hp\\OneDrive\\Desktop\\code\\seq.fasta")

with open("nucleoseq.fasta", "w") as f:
    for sequence in nucleotide_sequences:
        f.write("{}\n".format(sequence))
    f.write("\n")  # Add a blank line after the sequence

with open("proseq.fasta", "w") as f:
    for sequence in protein_sequences:
        f.write("{}\n".format(sequence))
    f.write("\n")  # Add a blank line after the sequence
 