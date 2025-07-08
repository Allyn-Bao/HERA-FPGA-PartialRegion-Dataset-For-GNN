"""
Stage 2: Parse BLIF to JSON
This script parses BLIF files and converts them into a JSON format suitable for graph representation.
This is the second step in the dataset preparation pipeline. At this stage the BLIF files should be extracted from vtr-verlog-to-routing repository and stored in netlist_graphs directory.
The output JSON files will be stored in the netlist_graphs_json directory.
Each JSON file contains nodes and edges representing the circuit's structure, where nodes are defined by their
type (INPUT, OUTPUT, LUT) and edges represent connections between inputs and outputs.
"""

import os
import json

def parse_blif(blif_path):
    nodes = {}
    edges = []

    with open(blif_path, 'r') as f:
        lines = f.readlines()

    for line in lines:
        tokens = line.strip().split()
        if not tokens:
            continue

        # .inputs and .outputs define the primary I/O
        if tokens[0] == '.inputs':
            for name in tokens[1:]:
                nodes[name] = {"id": name, "type": "INPUT"}
        elif tokens[0] == '.outputs':
            for name in tokens[1:]:
                nodes[name] = {"id": name, "type": "OUTPUT"}
        elif tokens[0] == '.names':
            output = tokens[-1]
            inputs = tokens[1:-1]
            nodes[output] = {"id": output, "type": "LUT", "inputs": inputs}
            for inp in inputs:
                edges.append([inp, output])

    return {
        "nodes": list(nodes.values()),
        "edges": edges
    }

def main():
    blif_dir = "netlist_graphs"
    output_dir = "netlist_graphs_json"
    os.makedirs(output_dir, exist_ok=True)

    for fname in os.listdir(blif_dir):
        if fname.endswith(".blif"):
            blif_path = os.path.join(blif_dir, fname)
            result = parse_blif(blif_path)
            json_path = os.path.join(output_dir, fname.replace(".blif", ".json"))
            with open(json_path, 'w') as f:
                json.dump(result, f, indent=2)
            print(f"Converted {fname} -> {json_path}")

if __name__ == "__main__":
    main()