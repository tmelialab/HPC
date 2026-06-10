#!/bin/bash
#SBATCH --job-name=04_braker_final
#SBATCH --output=braker_final_%j.log
#SBATCH --error=braker_final_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=24:00:00

export GENEMARK_PATH=/mgpfs/home/damedihardjo/etpbraker/bin

# Initialize Conda for non-interactive shell
# If 'conda' command is not found, you may need to use the full path to your conda executable:
# eval "$(/mgpfs/home/damedihardjo/miniconda3/bin/conda shell.bash hook)"
eval "$(conda shell.bash hook)"
conda activate training_qc

# Mendefinisikan lokasi file BAM berdasarkan output STAR Anda
RNA_DIR="rnaseq"
BAMS="${RNA_DIR}/SRR1168433_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25080411_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25080412_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25816559_Aligned.sortedByCoord.out.bam"

echo "--- Menjalankan BRAKER3 dengan RNA-seq + Protein ---"

braker.pl \
    --genome=acacia_final.fasta.masked \
    --bam=$BAMS \
    --prot_seq=Viridiplantae.fa \
    --softmasking \
    --threads=32 \
    --GENEMARK_PATH=/mgpfs/home/damedihardjo/etpbraker/bin \
    --species=acacia_crassicarpa \
    --workingdir=./braker_combined_result \
    --gff3

echo "--- BRAKER Selesai ---"


1. coba pakai rna seq dulu aja
2. 