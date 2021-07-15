
class ahb_master_sequencer extends uvm_sequencer#(trace_cplex_transaction_c); 
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
  `uvm_component_utils(ahb_master_sequencer)

    function new (string name = "trace_cplex_master_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction : new


endclass : ahb_master_sequencer

