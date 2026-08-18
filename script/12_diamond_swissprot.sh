#!/bin/bash
#SBATCH --job-name=12_diamond_swissprot
#SBATCH --output=diamond_sp_%j.log
#SBATCH --error=diamond_sp_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=32G
#SBATCH --time=06:00:00

set -euo pipefail

ENV_NAME="training_qc"
QUERY_PROTEIN="/mgpfs/home/damedihardjo/swissprot/brakerclean.aa"
DB_DMND="/mgpfs/home/damedihardjo/swissprot/swissprot.dmnd"
OUT_TSV="/mgpfs/home/damedihardjo/swissprot/diamond_swissprot.tsv"

echo "=== Mulai Diamond BLASTp vs Swiss-Prot ==="
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "${ENV_NAME}"

diamond blastp \
    --query "${QUERY_PROTEIN}" \
    --db "${DB_DMND}" \
    --out "${OUT_TSV}" \
    --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore \
    --sensitive \
    --max-target-seqs 1 \
    --threads "${SLURM_CPUS_PER_TASK}" \
    --evalue 1e-5

echo "=== Diamond BLASTp Swiss-Prot selesai ==="
echo "Jumlah protein teranotasi:"
cut -f1 "${OUT_TSV}" | sort | uniq | wc -l
echo "Hasil: ${OUT_TSV}"
