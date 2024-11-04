class l2p_layer extends uvm_component;
   uvm_analysis_port #(l1_item) ap;
   uvm_analysis_export #(dut_txn) analysis_export;

   d2l_monitor mon;
   uvm_sequencer #(l1_item) seqr;
   translation_seq xl_seq;
   //dut_agent d_agent;
   conv_comp convert_comp;
  
   `uvm_component_utils(l2p_layer)   

   function new(string name = "l2p_layer",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      seqr    = uvm_sequencer #(l1_item) :: type_id :: create("seqr",this);
      mon     = d2l_monitor :: type_id :: create("mon",this);
      //d_agent = dut_agent :: type_id :: create("d_agent",this);
     convert_comp = conv_comp :: type_id :: create("convert_comp",this);
      ap   = new("ap",this);
      analysis_export = new("analysis_export",this);
   endfunction : build_phase
   
   function void connect_phase(uvm_phase phase);
      mon.ap.connect(ap);
      analysis_export.connect(mon.analysis_export);
      //convert_comp.seqr = seqr;
   endfunction : connect_phase
/*
   function void write(dut_txn d);
      d.print();      
   endfunction : write	   */

   virtual task run_phase(uvm_phase phase);
      //xl_seq = translation_seq :: type_id :: create("xl_seq");
      //xl_seq.up_sequencer = seqr;
      //xl_seq.start(d_agent.seqr);
      convert_comp.seqr = seqr;
   endtask : run_phase
endclass : l2p_layer
