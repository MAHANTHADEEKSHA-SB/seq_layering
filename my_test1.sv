class my_test1 extends uvm_test;
   layer_env env;
   layer_seq my_seq;

   `uvm_component_utils(my_test1)

   function new(string name = "my_test1",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = layer_env :: type_id :: create("env",this);
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      my_seq = layer_seq :: type_id :: create("my_seq");
      phase.raise_objection(this);
     repeat(1)begin
       my_seq.start(env.d_agent.seqr_1);
       #30;end
      phase.drop_objection(this);
   endtask : run_phase
endclass : my_test1
