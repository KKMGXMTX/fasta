rule all:
    input:
        "fastqc/sample1.html",
        "fastqc/sample2.html"

rule fastqc:
    input:
        "SRR12534681_1.fastq",
        "SRR12534681_2.fastq"
    output:
        html1 = "fastqc/sample1.html",
        html2 = "fastqc/sample2.html"
    shell:
        "fastqc -o fastqc {input} && mv fastqc/SRR12534681_1_fastqc.html {output.html1} && mv fastqc/SRR12534681_2_fastqc.html {output.html2}"
