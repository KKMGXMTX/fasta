fastq_samples = ["wsl.localhost/Ubuntu/home/kritika/FQfl/"]

rule names:
  input:
    fastqs = expand("{sample}", sample=fastq_samples)
  shell:
    """
    for file in {input.fastqs}:
      echo "Processing file: ${{file}}"
    """



##FASTQC

import os
import glob

SRA, FRR = glob_wildcards("FQfl/{sra}_{frr}.fastq")

rule all:
    input:
        expand("output_file/{sra}_{frr}_fastqc.{extension}", sra=SRA, frr=FRR, extension=["zip", "html"])

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
  
rule trimm:
    input:
        R1="FQfl/{ids}_1P.fastq",
        R2="FQfl/{ids}_2P.fastq"
    output:
        F="trim/{ids}_1P.fastq",
        R="trim/{ids}_2P.fastq"
    threads: 4
    params:
        basename="trim/{sra}.fastq"
    shell:
        """
        trimmomatics PE -threads {threads} {input.R1} {input.R2} {output.F} {output.R} ILLUMINACLIP:Trus
        """