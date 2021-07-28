class ahb_transaction extends uvm_sequence_item; 

  rand logic [31:0] haddr;
  rand logic        hmastlock;
  rand logic [2:0]  hsize;
  rand logic [1:0]  htrans;
  rand logic [31:0] hwdata;
  rand logic        hwrite;
  rand logic [31:0] hrdata;
  rand logic        hready;
  rand logic        hresp;
              

     `uvm_object_utils_begin(trace_cplex_transaction_c)

        `uvm_field_int (haddr,  UVM_ALL_ON)
        `uvm_field_int (hmastlock,  UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_int (hsize,  UVM_ALL_ON)
        `uvm_field_int (htrans,  UVM_ALL_ON)
        `uvm_field_int (hwdata,  UVM_ALL_ON)
        `uvm_field_int (hwrite,  UVM_ALL_ON)
         `uvm_field_int (hrdata,  UVM_ALL_ON)
        `uvm_field_int (hready,  UVM_ALL_ON)
        `uvm_field_int (hresp,  UVM_ALL_ON)
       


    `uvm_object_utils_end

    // Function: new()
    //
    // Create a new instance of this type, giving it the optional ~name~
  function new(string name="ahb_transaction");
        super.new(name);
    endfunction : new

constraint dist_addr{
                     haddr dist { [40'h0 : 40'hFFF] :/ 10 ,
                                 [40'h1FFFF : 40'hFFFFFF] :/ 10  ,
                                 [40'h1FFFFFF : 40'HFFFFFFFFFF] :/ 10 };
                    }


constraint dist_hwdata{
                       hwdata dist { [32'h0     : 32'hFFF]   :/ 10 ,
                                        [32'h1FFF  : 32'hFFFF]   :/ 10 ,
                                        [32'h1FFFF : 32'hFFFFFFFF]  :/ 10  };
                      }

endclass : ahb_transaction

