# Stage 3: Run VTR Flow to Get Placements
# The BLIF files has the netlist information, but to train the GNN model, we need example placements for any give netlists
# to get an example placement for a netlist, we use VTR flow to run the placement algorithm on the BLIF files
# The placements will be stored in the vtr_runs directory


#!/bin/bash

set -e

# Paths
VTR_DIR="./vtr-verilog-to-routing"
BENCH_DIR="./netlist_graphs"
OUTPUT_DIR="./vtr_runs"
ARCH_FILE="$VTR_DIR/vtr_flow/arch/timing/k6_N10_frac_N10_mem32K_40nm.xml"
VTR_SCRIPT="$VTR_DIR/vtr_flow/scripts/run_vtr_flow.pl"

mkdir -p "$OUTPUT_DIR"

for blif_file in "$BENCH_DIR"/*.blif; do
    design_name=$(basename "$blif_file" .blif)
    echo "[INFO] Running VTR flow for $design_name"

    "$VTR_SCRIPT" "$blif_file" "$ARCH_FILE" \
        --temp_dir "$OUTPUT_DIR/$design_name"

    echo "[DONE] Finished $design_name"
done

# To run this script, use:
# chmod +x scripts/3_run_vtr_flow_get_placements.sh
# ./scripts/3_run_vtr_flow_get_placements.sh