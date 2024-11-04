class d2l_monitor extends uvm_component;
   uvm_analysis_port #(l1_item) ap;
   uvm_analysis_imp  #(dut_txn, d2l_monitor) analysis_export;
   
   `uvm_component_utils(d2l_monitor)
   
   function new(string name = "d2l_monitor",uvm_component parent);
      super.new(name,parent);
   endfunction : new
 
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ap = new("ap",this);
      analysis_export = new("analysis_export",this);
   endfunction : build_phase

   virtual function void write(dut_txn d);
      l1_item l;
      l = l1_item :: type_id :: create("l");
      l.m_data    = new[1];
      l.m_length  = 1;
      l.m_address = d.addr;
      l.m_data[0] = d.data;
      if(d.wr_rd) l.m_command = UVM_TLM_WRITE_COMMAND;
      if(!d.wr_rd) l.m_command = UVM_TLM_READ_COMMAND;
      //l.print();
      ap.write(l);
   endfunction : write
endclass : d2l_monitor
