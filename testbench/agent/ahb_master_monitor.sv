class ahb_master_monitor extends uvm_monitor;

    string tID;
    virtual ahb_if ahb_mon_if;
    bit ahb_cg_en = 'h0;


  `uvm_component_utils(ahb_master_monitor)

    protected ahb_transaction_c item; 

    // sb_post: TLM port for Monitor/scoreboard communication
  uvm_analysis_port #(ahb_transaction_c) sb_post;


   covergroup ahb_master_cg;

   endgroup

    function new(string name, uvm_component parent);
        super.new(name,parent);
        tID=get_type_name();
        tID=tID.toupper();
      //if (ahb_cg_en == 1) begin
          ahb_master_cg=new();
        //end  
        sb_post=new("sb_post",this);
    endfunction : new

    // Function: build_phase()
   // Call super class build function to generate driver 
    // Perform vif check
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

           if(!uvm_config_db#(virtual trace_cplex_if)::get(this,"", "cplex_vif",cplex_if))
             `uvm_fatal(this.get_type_name(),"failed to get ahb master virtual interface handle")

    endfunction : build_phase

    // Task: end_of_elaboration_phase()
    // This function is used for back pointer  
    function void end_of_elaboration_phase(uvm_phase phase);
        
    endfunction: end_of_elaboration_phase
    // Task: run_phase()
    // This task collectes the Write and Read Transfer  
    task run_phase(uvm_phase phase);
        `uvm_info(tID,"MONITOR RUNNING:",UVM_MEDIUM)
       forever
       begin
         
         `uvm_info(tID,$sformatf("CVG::ahb_cg_en  : \n %0s",ahb_cg_en),UVM_LOW)
         `uvm_info(tID,"ENTERED FOREVER LOOP:",UVM_MEDIUM)
         
        item = ahb_master_transaction_c::type_id::create("item");
        collect_data(item);
       end
    endtask : run_phase


  task collect_data(ahb_master_transaction_c item);
   
        `uvm_info(tID,"ENTERED COLLECT DATA TASK:",UVM_MEDIUM)
    @(posedge ahb_if.hclk)
      begin
        
      end 
              
endtask

endclass : ahb_master_monitor
