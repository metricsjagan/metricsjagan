//Metrics AHB VIP 
//Ahb agent verifiation compoent consistes of AHB driver, AHB Monitor and AHB sequener instatiated 

class ahb_master_agent extends uvm_agent;

    // is_active: uvm_active_passive_enum
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    // sequencer: Handle of ahb_master_sequencer class
    ahb_master_sequencer sequencer,m_sequencer;

    //driver: Handle of ahb_master_driver class
    ahb_master_driver driver;

    // monitor: Handle of ahb_master_monitor class
    ahb_master_monitor monitor;

    // m_cfg: Handle for trace_cplex_agent_config class
    ahb_master_agent_config m_cfg;


  `uvm_component_utils_begin(ahb_master_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction : new

    // Function: build_phase()
    // Create a new instance of monitor, if UVM_ACTIVE enum set
    
  virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
       monitor=ahb_master_monitor::type_id::create("monitor",this);
        if (is_active == UVM_ACTIVE) begin
            sequencer=ahb_master_sequencer::type_id::create("sequencer",this);
            m_sequencer=ahb_master_sequencer::type_id::create("m_sequencer",this);
            driver=ahb_master_driver::type_id::create("driver",this);
        end
    
    endfunction : build_phase

    // Function: connect_phase()
    // Creates a TLM connection between sequencer and driver if UVM_ACTIVE enum set
  
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_sequencer = sequencer;
        if (is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
            //driver.drv2mon_port.connect(monitor.drv2mon_port);
            //monitor.drv2mon_port.connect(driver.drv2mon_port);
        end
    endfunction : connect_phase

endclass : ahb_master_agent 
