class l1_item extends uvm_tlm_generic_payload;
   `uvm_object_utils(l1_item)
   
   constraint c1 {m_address inside {[1 : 10]};}
   constraint c2 {m_data.size() == 1;}

   function  new(string name = "l1_item");
      super.new();
   endfunction : new

endclass : l1_item
