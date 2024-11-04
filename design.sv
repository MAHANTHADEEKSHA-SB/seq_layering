// Code your design here
module memory_dut(
   input               clock,
   input               reset,
   input wire          wr_rd,
   input wire [31 : 0] addr,
   input wire [7 : 0]  data_in,
   output reg [7 : 0]  data_out);

   reg [31 : 0] mem [7 : 0];

   always @(posedge clock or negedge reset) begin
      if(!reset)begin
         data_out <= '0;
      end
      else begin
        if(wr_rd) begin
           mem[addr] <= data_in;
        end
        else begin
           data_out  <= mem[addr]; 
        end
      end
   end

endmodule : memory_dut