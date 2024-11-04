class conv_comp extends uvm_component;
  uvm_analysis_port #(dut_txn) conv_port;
  uvm_sequencer #(l1_item) seqr;
  `uvm_component_utils(conv_comp)
  
  function new(string name = "conv_comp",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    conv_port = new("conv_port",this);
  endfunction : build_phase
 
  task run_phase(uvm_phase phase);
    dut_txn item;
    l1_item req;
    
    seqr.get_next_item(req);
    item = dut_txn :: type_id :: create("item");
    //req.print();
    if(req.m_command == UVM_TLM_WRITE_COMMAND) item.wr_rd = 1'b1;
    if(req.m_command == UVM_TLM_READ_COMMAND) item.wr_rd = 1'b0;
    item.data = req.m_data[0];
    item.addr = req.m_address;
    //item.print();
    conv_port.write(item);
    seqr.item_done(req);
  endtask : run_phase
endclass : conv_comp