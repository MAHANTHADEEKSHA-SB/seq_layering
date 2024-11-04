class layer_env extends uvm_env;
   `uvm_component_utils(layer_env)
   
   //l2p_layer layer_agent;
   dut_agent d_agent;

   function new(string name = "layer_env",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //layer_agent = l2p_layer ::type_id :: create("layer_agent",this);
      d_agent     = dut_agent :: type_id :: create("d_agent",this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      //layer_agent.d_agent = d_agent;
      //layer_agent.convert_comp.conv_port.connect(d_agent.seqr.layer_imp);
      //d_agent.ap.connect(layer_agent.analysis_export);
   endfunction : connect_phase
endclass : layer_env
