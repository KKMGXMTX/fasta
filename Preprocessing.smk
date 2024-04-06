##FASTQC

import os
import glob

SRR, FRR = glob_wildcards("FASTQ_FILE_FOLDER_NAME/{srr}_{frr}.fastq")

rule all:
    input:
        expand("OUTPUT_FILE_FOLDER_FASTQC/{srr}_{frr}_fastqc.{extension}", srr=SRR, frr=FRR, extension=["zip", "html"]),
     
        expand("OUTPUT_FILE_FOLDER_TRIMMING/{srr}_1.fastq", srr=SRR),
        expand("OUTPUT_FILE_FOLDER_TRIMMING/{srr}_2.fastq", srr=SRR)

rule rawFastqc:
    input:
        rawread="FASTQ_FILE_FOLDER_NAME/{srr}_{frr}.fastq"
    output:
        zip="OUTPUT_FILE_FOLDER_FASTQC/{srr}_{frr}_fastqc.zip",
        html="OUTPUT_FILE_FOLDER_FASTQC/{srr}_{frr}_fastqc.html"
    threads: 1
    params:
        path="OUTPUT_FILE_FOLDER_FASTQC/"
    shell:
        """
        fastqc {input.rawread} --threads {threads} -o {params.path}
        """



##TRIMMING 

rule tri:
    input:
        R1="FASTQ_FILE_FOLDER_NAME/{srr}_1.fastq",
        R2="FASTQ_FILE_FOLDER_NAME/{srr}_2.fastq"
    output:
        F="OUTPUT_FILE_FOLDER_TRIMMING/{srr}_1.fastq",
        R="OUTPUT_FILE_FOLDER_TRIMMING/{srr}_2.fastq"
    threads: 4
    params: 
        adapter="PATH_TO_ADAPTER_FILE_TruSeq3-PE-2.fa"
    shell:
        """
        trimmomatic PE -threads 4 {input.R1} {input.R2} {output.F} {output.R} ILLUMINACLIP:{params.adapter}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
      
        """