class ahb_master_env extends uvm_env;
     
    // agent0: Handle of ahb_master_agent class
    ahb_master_agent agent0;

    // subscriber: Handle of ahb_master_subscriber class
    // ahb_master_subscriber subscriber;
    ahb_master_scoreboard scoreboard;

  `uvm_component_utils(ahb_master_env)
 
    // Create a new instance of this type, giving it the optional ~name~
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction : new

    // Function: build_phase()
    // Create a new instance of agent0 i.e. ahb_master_agent ,subscriber i.e. ahb_master_subscriber
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent0=ahb_master_agent::type_id::create("agent0",this);
        //subscriber=ahb_master_subscriber::type_id::create("subscriber",this);
 
        scoreboard=ahb_master_scoreboard::type_id::create("scoreboard",this); 
    endfunction : build_phase

    // Function: connect_phase()
    // Connects monitor and subscriber
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //agent0.monitor.sb_post.connect(subscriber.analysis_export);

        agent0.driver.drv_sb.connect(scoreboard.drv_ap);
        agent0.monitor.sb_post.connect(scoreboard.ap);
    endfunction : connect_phase

endclass : ahb_master_env

