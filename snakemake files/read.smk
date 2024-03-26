rule copy_fastq:
    input:
        "SRR12534681_1.fastq",
        "SRR12534681_2.fastq"
    output:
        "processed_reads/SRR12534681_1.fastq",
        "processed_reads/SRR12534681_2.fastq"
    shell:
        "cp {input} processed_reads/"


