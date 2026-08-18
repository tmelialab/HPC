#!/bin/bash
#SBATCH --job-name=11_trnascan
#SBATCH --output=trnascan_%j.log
#SBATCH --error=trnascan_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=32G
#SBATCH --time=24:00:00

set -euo pipefail

ENV_NAME="training_qc"
GENOME_MASKED="/mgpfs/home/damedihardjo/repeatmodeler/acacia_final.fasta.masked"
OUTDIR="trna_result"

echo "=== Mulai tRNAscan-SE ==="
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "${ENV_NAME}"

command -v tRNAscan-SE >/dev/null || { echo "ERROR: tRNAscan-SE belum terinstall!"; exit 1; }

mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

echo "Menjalankan tRNAscan-SE pada genome soft-masked..."
tRNAscan-SE \
    -o trna.out \
    -m trna.stats \
    -f trna.fa \
    --thread "${SLURM_CPUS_PER_TASK}" \
    "${GENOME_MASKED}"

echo "=== tRNAscan-SE selesai ==="
