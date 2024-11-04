// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg :: *;

`include "interface.sv"
//`include "memory_dut.sv"
`include "dut_txn.sv"
`include "l1_item.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "translation_seq.sv"
`include "d2l_monitor.sv"
`include "conv_comp.sv"
`include "l2p_layer.sv"
`include "dut_agent.sv"
`include "layer_env.sv"
`include "layer_seq.sv"
`include "my_test1.sv"

module tb_top;
   reg clock;

   initial begin
      clock = 1'b1;
   end

   always #5 clock = ~clock;

   intf intf_ (.clock(clock));

   memory_dut DUT (.clock(clock),
                   .reset(intf_.reset),
                   .addr(intf_.addr),
                   .data_in(intf_.data_in),
                   .data_out(intf_.data_out),
                   .wr_rd(wr_rd)
                   );

   initial begin
      uvm_config_db #(virtual intf) :: set (uvm_root :: get(), "*" ,"vif",intf_);
      run_test("my_test1");
     
   end

   initial begin
     $dumpfile("dump.vcd");
     $dumpvars(0, tb_top);
                       intf_.reset <= 1'b1;
      #15              intf_.reset <= 1'b0;
      @(posedge clock) intf_.reset <= 1'b1;
   end

endmodule : tb_top