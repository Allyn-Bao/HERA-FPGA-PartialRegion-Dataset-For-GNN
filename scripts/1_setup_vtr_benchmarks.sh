# Stage 1: Clone VTR and Extract BLIF Files from VTR benchmark storing netlists
# the BLIF netlists are saved into netlist_graphs directory

#!/bin/bash

# Exit on error
set -e

# Define target directory
ROOT_DIR=$(pwd)
DATA_DIR="${ROOT_DIR}/netlist_graphs"
VTR_DIR="${ROOT_DIR}/vtr-verilog-to-routing"

echo "[INFO] Cloning VTR repository..."
if [ ! -d "$VTR_DIR" ]; then
    git clone --recursive https://github.com/verilog-to-routing/vtr-verilog-to-routing.git
else
    echo "[INFO] VTR repo already exists. Skipping clone."
fi

echo "[INFO] Creating output directory: $DATA_DIR"
mkdir -p "$DATA_DIR"

# Copy all .blif files into netlist_graphs/
echo "[INFO] Extracting .blif netlists from VTR benchmarks..."
find "$VTR_DIR/vtr_flow/benchmarks/blif" -name "*.blif" | while read blif_file; do
    cp "$blif_file" "$DATA_DIR/"
done

echo "[INFO] Copied all .blif netlists to $DATA_DIR"
echo "[DONE] Setup complete."

# to run this script, use:
# chmod +x scripts/setup_vtr_benchmarks.sh
# ./scripts/setup_vtr_benchmarks.sh