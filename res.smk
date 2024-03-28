##FASTQC

import os
import glob

SRA, FRR = glob_wildcards("FQfl/{sra}_{frr}.fastq")

rule all:
    input:
        expand("output_file/{sra}_{frr}_fastqc.{extension}", sra=SRA, frr=FRR, extension=["zip", "html"]),
     
        expand("trim/{sra}_1.fastq", sra=SRA),
        expand("trim/{sra}_2.fastq", sra=SRA)

rule rawFastqc:
    input:
        rawread="FQfl/{sra}_{frr}.fastq"
    output:
        zip="output_file/{sra}_{frr}_fastqc.zip",
        html="output_file/{sra}_{frr}_fastqc.html"
    threads: 1
    params:
        path="output_file/"
    shell:
        """
        fastqc {input.rawread} --threads {threads} -o {params.path}
        """



##TRIMMING 

rule tri:
    input:
        R1="FQfl/{sra}_1.fastq",
        R2="FQfl/{sra}_2.fastq"
    output:
        F="trim/{sra}_1.fastq",
        R="trim/{sra}_2.fastq"
    threads: 4
    params: 
        ad="\\wsl.localhost\\Ubuntu\\home\\kritika\\TruSeq3-PE-2.fa"
    shell:
        """
        trimmomatic PE -threads 4 {input.R1} {input.R2} {output.F} {output.R} ILLUMINACLIP:{params.ad}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
      
        """