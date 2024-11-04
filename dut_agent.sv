class dut_agent extends uvm_agent;
   uvm_analysis_port #(dut_txn)ap;
   monitor   mon;
   driver    drv;
   sequencer seqr;
   uvm_sequencer #(l1_item) seqr_1;
   l2p_layer layer_agent;

   `uvm_component_utils(dut_agent)
   
   function new(string name = "dut_agent",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ap = new("ap",this);
      mon  = monitor :: type_id :: create("mon",this);
      drv  = driver :: type_id :: create("drv",this);
      seqr = sequencer :: type_id :: create("seqr",this);
      layer_agent = l2p_layer ::type_id :: create("layer_agent",this);
      seqr_1 = uvm_sequencer#(l1_item) :: type_id :: create("seqr_1",this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      layer_agent.seqr = seqr_1;
      drv.seq_item_port.connect(seqr.seq_item_export);
      layer_agent.convert_comp.conv_port.connect(seqr.layer_imp);
      ap.connect(layer_agent.analysis_export);
      ap = mon.ap;
   endfunction : connect_phase
endclass : dut_agent
