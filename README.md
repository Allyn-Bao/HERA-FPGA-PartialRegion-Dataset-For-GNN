# HERA-FPGA-PartialRegion-Dataset-For-GNN
A modular pipeline for generating datasets to train GNN models that predict performance metrics for FPGA partial region placements.


## setup
### Scripts
There are a list of bash/python scripts under ./scripts, which of which are index in order of execution. 
it is important to run each script in the parent directory level. so instead of running:
<pre>
```
/scripts % python script1.py
```
</pre>
you should run under project parent directory:
<pre>
```
project % python ./scripts/script1.py
```
</pre>


### build vtr-verilog-to-routing repository after cloning
After running ./scripts/1_setup_vtr_benchmarks.sh, the VTR repository should be cloned. We need to build VTR in order to run it to generate placement for a given netlist .BLIF file. 


<pre>
```
cd vtr-verilog-to-routing

python3 -m venv venv
source .venv/bin/activate
pip install -r requirements.txt

# if you don't have wget:
brew install wget

make

# verify installation
./vtr_flow/scripts/run_vtr_task.py ./vtr_flow/tasks/regression_tests/vtr_reg_basic/basic_timing
```
</pre>

