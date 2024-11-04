interface intf (input logic clock);
   logic          wr_rd;
   logic          reset;
   logic [31 : 0] addr;
   logic [7 : 0]  data_in;
   logic [7 : 0]  data_out;
endinterface : intf
