#!/bin/bash
#SBATCH --job-name=03_repeatmasker
#SBATCH --output=repeatmasker_%j.log
#SBATCH --error=repeatmasker_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=24:00:00

source ~/miniconda3/etc/profile.d/conda.sh
conda activate repeats

echo "--- Mulai RepeatMasker ---"
RepeatMasker -pa 62 -lib acacia_db-families.fa -gff -xsmall acacia_final.fasta
echo "--- RepeatMasker Selesai ---"