class dut_txn extends uvm_sequence_item;

   rand bit [31 : 0] addr;
   rand bit [7 : 0]  data;
   rand bit          wr_rd;
   constraint c1 {soft addr inside {[1 : 10]};}
   
   `uvm_object_utils_begin(dut_txn)
      `uvm_field_int(addr,UVM_DEFAULT)
      `uvm_field_int(data,UVM_DEFAULT)
      `uvm_field_int(wr_rd,UVM_DEFAULT)
   `uvm_object_utils_end
   
   function new(string name = "dut_txn");
      super.new(name);
   endfunction : new

endclass : dut_txn
