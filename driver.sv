class driver extends uvm_driver #(dut_txn);
   virtual intf vif;   

   `uvm_component_utils(driver)
    
   function new(string name= "driver",uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual intf) :: get (this, "", "vif", vif))begin
      `uvm_fatal(get_type_name(), "Unable to get interface from config_db")end
   endfunction : build_phase
   
   task run_phase(uvm_phase phase);
      wait(vif.reset == 0);
      vif.addr    <= '0;
      vif.data_in <= '0;
      @(posedge vif.reset);
      forever begin
         seq_item_port.get_next_item(req);
         req.print();
            vif.addr <= req.addr;
        if(req.wr_rd) begin
           vif.wr_rd <= 1'b1;
           vif.data_in <= req.data;
        end
        else begin
           vif.wr_rd <= 1'b0;
        end
            req.print();
         seq_item_port.item_done(req);
      end
   endtask : run_phase
   
endclass : driver
