class layer_seq extends uvm_sequence#(l1_item);
   `uvm_object_utils(layer_seq)
   l1_item item_wr;
   l1_item item_rd;   

   function new(string name = "layer_seq");
      super.new(name);
   endfunction : new 
   
   task body();
      item_wr = l1_item :: type_id :: create("item");
      start_item(item_wr);
     assert(item_wr.randomize() with {m_command == UVM_TLM_WRITE_COMMAND;});
      finish_item(item_wr);
      /*item_rd = l1_item :: type_id :: create("item");
      start_item(item_rd);
      assert(item_rd.randomize() with {m_command == UVM_TLM_READ_COMMAND;m_address == item_wr.m_address;});
      finish_item(item_rd);*/
   endtask : body
endclass : layer_seq
