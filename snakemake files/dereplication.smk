# Snakemake file for dereplication using vsearch

# Define input and output file paths
input_fastq_1 = "trimmed_output_file_SRR12534681_1.fastq"
input_fastq_2 = "trimmed_output_file_SRR12534681_2.fastq"
output_dereplicated = "dereplicated.fasta"

# Rule to perform dereplication
rule dereplicate:
    input:
        fastq1 = input_fastq_1,
        fastq2 = input_fastq_2
    output:
        dereplicated = output_dereplicated
    params:
        tmpdir = "/tmp"  # Temporary directory for vsearch
    shell:
        """
        vsearch --fastx_uniques {input.fastq1} --fastaout dereplicated_file1.fasta &&
        vsearch --fastx_uniques {input.fastq2} --fastaout dereplicated_file2.fasta &&
        cat dereplicated_file1.fasta dereplicated_file2.fasta > {output.dereplicated}
        """

