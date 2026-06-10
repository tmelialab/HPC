#!/bin/bash
#SBATCH --job-name=02_repeatmodeler
#SBATCH --output=repeatmodeler_%j.log
#SBATCH --error=repeatmodeler_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=24:00:00          # Max 24 jam (HPC limit)

source ~/miniconda3/etc/profile.d/conda.sh
conda activate repeats

echo "--- Mulai/Resume RepeatModeler ---"
# RepeatModeler OTOMATIS resume dari checkpoint folder RM_*/
# Jika timeout, SUBMIT ULANG script ini, akan lanjut dari checkpoint
RepeatModeler -database acacia_db -pa 62 -LTRStruct

echo "--- RepeatModeler Selesai ---"