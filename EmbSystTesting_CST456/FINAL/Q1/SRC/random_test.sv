//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
`include "environment.sv"
program test(intf i_intf);
  
  //declaring environment instance
  environment env;
  
  initial begin
    //creating environment
    env = new(i_intf);
    
    //setting the repeat count of generator as 20
    env.gen.repeat_count = 20;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
  end
endprogram