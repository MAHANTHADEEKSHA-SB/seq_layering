class monitor extends uvm_monitor;
   virtual intf vif;

   uvm_analysis_port #(dut_txn) ap;

   `uvm_component_utils(monitor)

   function new(string name = "monitor",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual intf) :: get (this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Unable to get interface from config_db")end
      ap = new("ap",this);
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      dut_txn txn;
      txn = dut_txn :: type_id :: create("txn");
      wait(vif.reset == 0);
      @(posedge vif.reset);
      forever begin
         @(posedge vif.clock)
         txn.addr = vif.addr;
        if(!vif.wr_rd) begin
          txn.data = vif.data_out;
          txn.wr_rd = 1'b0;
        end
        else begin
          txn.wr_rd = 1'b1;
          txn.data = vif.data_in;
        end
         //txn.print();
         ap.write(txn);
      end
   endtask : run_phase
endclass : monitor
