//`uvm_analysis_imp_decl(_layr)
class sequencer extends uvm_sequencer #(dut_txn);
  uvm_analysis_imp #(dut_txn,sequencer) layer_imp;
  dut_txn item;
   `uvm_component_utils(sequencer)
   
   function new(string name = "sequencer",uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    layer_imp = new("layer_imp",this);
    item = dut_txn :: type_id :: create("item");
  endfunction : build_phase
  
  virtual function void write(dut_txn item);
    this.item = item;
    //this.item.print();
  endfunction : write
  
  virtual task get_next_item(output dut_txn t);
    m_req_fifo.put(item);
    super.get_next_item(t);
  endtask : get_next_item
  
  virtual function void item_done(dut_txn item);
    super.item_done(item);
  endfunction : item_done
endclass : sequencer
