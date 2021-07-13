class ahb_master_driver extends uvm_driver #(ahb_master_transaction_c);

    string tID;
    virtual ahb_if vif;
    
  `uvm_component_utils(ahb_master_driver)
  
  //analysis port to connect the driver and scoreboard 
  uvm_analysis_port #(ahb_master_transaction_c) drv_sb;

    function new(string name, uvm_component parent);
        super.new(name,parent);
        tID=get_type_name();
        tID=tID.toupper();
        drv_sb=new("drv_sb",this);
    endfunction : new

    // Function: build_phase()
     // Call super class build function to generate driver 
    // Perform vif check  
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(virtual ahb_if)::get(this ,"*", "ahb_vif",vif))
       `uvm_fatal(get_type_name(),"virtual interface not found");

    endfunction : build_phase

    // Task: run_phase()
    // This task drives the Write and Read Transfer  
  
    task run_phase(uvm_phase phase);
     fork 
        reset_dut ();
        get_and_drive();
     join
    endtask : run_phase

    //
    // This task collects the packet and send to drive_data() task
    task get_and_drive();
        forever begin
          wait (vif.hreset_n ==0);
          @(posedge vif.hclk);
            seq_item_port.get_next_item(req);
            `uvm_info(tID,$sformatf("Transaction Item sent is: \n %0s",req.sprint()),UVM_LOW)
             drive (req);
            seq_item_port.item_done();
        end// !forever begin
    endtask : get_and_drive



 task reset_dut();

  forever begin 
    @(negedge vif.reset_axi_n);
     `uvm_info(tID,$sformatf("In Reset \n "),UVM_LOW)
      vif.itrace0_valid='b0;
      vif.itrace0_insn='b0;
      vif.itrace0_iaddr='b0;
      vif.itrace0_exception='b0;
      vif.itrace0_tval='b0;
      vif.itrace0_interrupt='b0;
      vif.itrace0_cpuhalt='b0;
      vif.itrace0_priv='b0;
      vif.itrace0_cause='b0;

     
end 
endtask 
     


task drive(trace_cplex_transaction_c req);
   
   if(req.wr_rd==1'b1)begin  //Write
     `uvm_info(tID,$sformatf("DEBUG item sent is: \n "),UVM_LOW)
     `uvm_info(tID,$sformatf("DRIVER ITEM IS: \n %0s",req.sprint()),UVM_LOW)
      drv_sb.write(this.req);
      case(req.trace_num)
      3'b000: begin
               vif.itrace0_valid=req.valid;
               vif.itrace0_iaddr=req.addr;
               vif.itrace0_insn=req.insn;
               vif.itrace0_tval=req.tvalue;
               vif.itrace0_exception=req.exception;
               vif.itrace0_interrupt=req.interrupt;
               vif.itrace0_priv=req.priv;
               vif.itrace0_cause=req.cause;
               vif.itrace0_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace0_valid=1'b0;
               vif.itrace0_iaddr=40'b0;
               vif.itrace0_insn=32'b0;
               vif.itrace0_tval=40'b0;
	       vif.itrace0_exception='b0;
               vif.itrace0_interrupt='b0;
               vif.itrace0_priv='b0;
               vif.itrace0_cause='b0;
               vif.itrace0_cpuhalt='b0;

            
      end
      3'b001: begin
               vif.itrace1_valid=req.valid;
               vif.itrace1_iaddr=req.addr;
               vif.itrace1_insn=req.insn;
               vif.itrace1_tval=req.tvalue;
               vif.itrace1_exception=req.exception;
               vif.itrace1_interrupt=req.interrupt;
               vif.itrace1_priv=req.priv;
               vif.itrace1_cause=req.cause;
               vif.itrace1_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace1_valid=1'b0;
               vif.itrace1_iaddr=40'b0;
               vif.itrace1_insn=32'b0;
               vif.itrace1_tval=40'b0;
               vif.itrace1_exception='b0;
               vif.itrace1_interrupt='b0;
               vif.itrace1_priv='b0;
               vif.itrace1_cause='b0;
               vif.itrace1_cpuhalt='b0;


      end
      3'b010: begin
               vif.itrace2_valid=req.valid;
               vif.itrace2_iaddr=req.addr;
               vif.itrace2_insn=req.insn;
               vif.itrace2_tval=req.tvalue;
               vif.itrace2_exception=req.exception;
               vif.itrace2_interrupt=req.interrupt;
               vif.itrace2_priv=req.priv;
               vif.itrace2_cause=req.cause;
               vif.itrace2_cpuhalt=req.cpuhalt;

            @(posedge vif.clk_cpu)
               vif.itrace2_valid=1'b0;
               vif.itrace2_iaddr=40'b0;
               vif.itrace2_insn=32'b0;
               vif.itrace2_tval=40'b0;
               vif.itrace2_exception='b0;
               vif.itrace2_interrupt='b0;
               vif.itrace2_priv='b0;
               vif.itrace2_cause='b0;
               vif.itrace2_cpuhalt='b0;
      end
      3'b011: begin
               vif.itrace3_valid=req.valid;
               vif.itrace3_iaddr=req.addr;
               vif.itrace3_insn=req.insn;
               vif.itrace3_tval=req.tvalue;
               vif.itrace3_exception=req.exception;
               vif.itrace3_interrupt=req.interrupt;
               vif.itrace3_priv=req.priv;
               vif.itrace3_cause=req.cause;
               vif.itrace3_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace3_valid=1'b0;
               vif.itrace3_iaddr=40'b0;
               vif.itrace3_insn=32'b0;
               vif.itrace3_tval=40'b0;
               vif.itrace3_exception='b0;
               vif.itrace3_interrupt='b0;
               vif.itrace3_priv='b0;
               vif.itrace3_cause='b0;
               vif.itrace3_cpuhalt='b0;

      end
      3'b100: begin
               vif.itrace4_valid=req.valid;
               vif.itrace4_iaddr=req.addr;
               vif.itrace4_insn=req.insn;
               vif.itrace4_tval=req.tvalue;
               vif.itrace4_exception=req.exception;
               vif.itrace4_interrupt=req.interrupt;
               vif.itrace4_priv=req.priv;
               vif.itrace4_cause=req.cause;
               vif.itrace4_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace4_valid=1'b0;
               vif.itrace4_iaddr=40'b0;
               vif.itrace4_insn=32'b0;
               vif.itrace4_tval=40'b0;
               vif.itrace4_exception='b0;
               vif.itrace4_interrupt='b0;
               vif.itrace4_priv='b0;
               vif.itrace4_cause='b0;
               vif.itrace4_cpuhalt='b0;


      end
    3'b101: begin
            fork
              begin
               vif.itrace0_valid=req.valid;
               vif.itrace0_iaddr=req.addr;
               vif.itrace0_insn=req.insn;
               vif.itrace0_tval=req.tvalue;
               vif.itrace0_exception=req.exception;
               vif.itrace0_interrupt=req.interrupt;
               vif.itrace0_priv=req.priv;
               vif.itrace0_cause=req.cause;
               vif.itrace0_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace0_valid=1'b0;
               vif.itrace0_iaddr=40'b0;
               vif.itrace0_insn=32'b0;
               vif.itrace0_tval=40'b0;
	       vif.itrace0_exception='b0;
               vif.itrace0_interrupt='b0;
               vif.itrace0_priv='b0;
               vif.itrace0_cause='b0;
               vif.itrace0_cpuhalt='b0;
            end
            begin
               vif.itrace1_valid=req.valid;
               vif.itrace1_iaddr=req.addr;
               vif.itrace1_insn=req.insn;
               vif.itrace1_tval=req.tvalue;
               vif.itrace1_exception=req.exception;
               vif.itrace1_interrupt=req.interrupt;
               vif.itrace1_priv=req.priv;
               vif.itrace1_cause=req.cause;
               vif.itrace1_cpuhalt=req.cpuhalt;

            @(posedge vif.clk_cpu)
               vif.itrace1_valid=1'b0;
               vif.itrace1_iaddr=40'b0;
               vif.itrace1_insn=32'b0;
               vif.itrace1_tval=40'b0;
               vif.itrace1_exception='b0;
               vif.itrace1_interrupt='b0;
               vif.itrace1_priv='b0;
               vif.itrace1_cause='b0;
               vif.itrace1_cpuhalt='b0;
            end
            begin
              vif.itrace2_valid=req.valid;
               vif.itrace2_iaddr=req.addr;
               vif.itrace2_insn=req.insn;
               vif.itrace2_tval=req.tvalue;
               vif.itrace2_exception=req.exception;
               vif.itrace2_interrupt=req.interrupt;
               vif.itrace2_priv=req.priv;
               vif.itrace2_cause=req.cause;
               vif.itrace2_cpuhalt=req.cpuhalt;

            @(posedge vif.clk_cpu)
               vif.itrace2_valid=1'b0;
               vif.itrace2_iaddr=40'b0;
               vif.itrace2_insn=32'b0;
               vif.itrace2_tval=40'b0;
               vif.itrace2_exception='b0;
               vif.itrace2_interrupt='b0;
               vif.itrace2_priv='b0;
               vif.itrace2_cause='b0;
               vif.itrace2_cpuhalt='b0;
            end
            begin
               vif.itrace3_valid=req.valid;
               vif.itrace3_iaddr=req.addr;
               vif.itrace3_insn=req.insn;
               vif.itrace3_tval=req.tvalue;
               vif.itrace3_exception=req.exception;
               vif.itrace3_interrupt=req.interrupt;
               vif.itrace3_priv=req.priv;
               vif.itrace3_cause=req.cause;
               vif.itrace3_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace3_valid=1'b0;
               vif.itrace3_iaddr=40'b0;
               vif.itrace3_insn=32'b0;
               vif.itrace3_tval=40'b0;
               vif.itrace3_exception='b0;
               vif.itrace3_interrupt='b0;
               vif.itrace3_priv='b0;
               vif.itrace3_cause='b0;
               vif.itrace3_cpuhalt='b0;
            end
            begin
               vif.itrace4_valid=req.valid;
               vif.itrace4_iaddr=req.addr;
               vif.itrace4_insn=req.insn;
               vif.itrace4_tval=req.tvalue;
               vif.itrace4_exception=req.exception;
               vif.itrace4_interrupt=req.interrupt;
               vif.itrace4_priv=req.priv;
               vif.itrace4_cause=req.cause;
               vif.itrace4_cpuhalt=req.cpuhalt;
            @(posedge vif.clk_cpu)
               vif.itrace4_valid=1'b0;
               vif.itrace4_iaddr=40'b0;
               vif.itrace4_insn=32'b0;
               vif.itrace4_tval=40'b0;
               vif.itrace4_exception='b0;
               vif.itrace4_interrupt='b0;
               vif.itrace4_priv='b0;
               vif.itrace4_cause='b0;
               vif.itrace4_cpuhalt='b0;
            end
            join

end 
endcase
    end

endtask


endclass : ahb_master_driver 

