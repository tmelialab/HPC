#!/bin/bash
#SBATCH --job-name=12_diamond_sp
#SBATCH --output=/mgpfs/home/damedihardjo/rerunacacia/annotation/logs/diamond_sp_%j.log
#SBATCH --error=/mgpfs/home/damedihardjo/rerunacacia/annotation/logs/diamond_sp_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=06:00:00
#SBATCH --partition=short

set -euo pipefail

ENV_NAME="training_qc"
QUERY="/mgpfs/home/damedihardjo/rerunacacia/annotation/braker/braker.clean.aa"
# fallback: if clean not exists, create from braker.aa
if [ ! -f "$QUERY" ]; then
  echo "Cleaning * from braker.aa -> $QUERY"
  tr -d '*' < /mgpfs/home/damedihardjo/rerunacacia/annotation/braker/braker.aa > "$QUERY"
fi
DB="/mgpfs/home/damedihardjo/acacia_project/refdata/swissprot/swissprot.dmnd"
# alternative DB path if above not found
if [ ! -f "$DB" ]; then
  DB="/mgpfs/home/damedihardjo/acacia_project/refdata/swissprot.dmnd"
fi
OUTDIR="/mgpfs/home/damedihardjo/rerunacacia/annotation/diamond"
OUT_TSV="${OUTDIR}/diamond_swissprot.tsv"

echo "=== Mulai Diamond BLASTp vs Swiss-Prot $(date) ==="
echo "Query: $QUERY ($(grep -c "^>" "$QUERY") proteins)"
echo "DB: $DB ($(ls -lh "$DB" | awk '{print $5}'))"
echo "Out: $OUT_TSV"
mkdir -p "$OUTDIR"

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "${ENV_NAME}"
diamond --version 2>&1 | head -1

diamond blastp \
    --query "${QUERY}" \
    --db "${DB}" \
    --out "${OUT_TSV}" \
    --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore \
    --sensitive \
    --max-target-seqs 1 \
    --threads "${SLURM_CPUS_PER_TASK}" \
    --evalue 1e-5

echo "=== Diamond BLASTp Swiss-Prot selesai $(date) ==="
echo "Jumlah protein teranotasi:"
cut -f1 "${OUT_TSV}" | sort | uniq | wc -l
echo "Hasil: ${OUT_TSV} ($(wc -l < "${OUT_TSV}") hits)"
ls -lh "${OUT_TSV}"
