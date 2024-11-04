class translation_seq extends uvm_sequence#(dut_txn);
   `uvm_object_utils(translation_seq)

   uvm_sequencer #(l1_item) up_sequencer;
   
   function new(string name = "translation_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      l1_item l;
      dut_txn d;

      up_sequencer.get_next_item(l);
         d = dut_txn :: type_id :: create("d");

         start_item(d);
         if(l.m_command == UVM_TLM_WRITE_COMMAND) d.wr_rd = 1'b1;
         if(l.m_command == UVM_TLM_READ_COMMAND)  d.wr_rd = 1'b0;
         d.data = l.m_data[0];
         d.addr = l.m_address;
         finish_item(d);

      up_sequencer.item_done(l);

   endtask : body  
   
endclass : translation_seq
