#!/bin/bash
#SBATCH --job-name=13_diamond_uniref90
#SBATCH --output=diamond_uniref_%j.log
#SBATCH --error=diamond_uniref_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=20:00:00

set -euo pipefail

ENV_NAME="training_qc"
QUERY_PROTEIN="/mgpfs/home/damedihardjo/swissprot/brakerclean.aa"
DB_DMND="/mgpfs/home/damedihardjo/uniref90/uniref90db.dmnd"
OUT_TSV="/mgpfs/home/damedihardjo/uniref90/diamond_uniref90.tsv"

echo "=== Mulai Diamond BLASTp vs UniRef90 ==="
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

echo "=== Diamond BLASTp UniRef90 selesai ==="
echo "Jumlah protein teranotasi:"
cut -f1 "${OUT_TSV}" | sort | uniq | wc -l
echo "Hasil: ${OUT_TSV}"
