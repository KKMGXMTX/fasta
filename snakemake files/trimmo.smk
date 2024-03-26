rule trim_reads:
    input:
        "SRR12534681_1.fastq",
        "SRR12534681_2.fastq"
    output:
        "trimmed_output_file_SRR12534681_1.fastq",
        "trimmed_output_file_SRR12534681_2.fastq"
    params:
        adapters="path/to/adapters.fa",
        quality="20",
        minlen="50"
    shell:
        """
        trimmomatic PE -phred33 {input[0]} {input[1]} \
        {output[0]} {output[0]}.unpaired \
        {output[1]} {output[1]}.unpaired \
        ILLUMINACLIP:{params.adapters}:2:30:10 \
        LEADING:{params.quality} TRAILING:{params.quality} \
        SLIDINGWINDOW:4:15 MINLEN:{params.minlen}
        """
