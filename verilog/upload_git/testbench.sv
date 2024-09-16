module MorraCinese_TB;
    reg [1:0] P1;
    reg [1:0] P2;
    reg START;
    reg [1:0] ROUND;
    reg [1:0] GAME;
    reg clk;

    integer out;
    integer script;

  MorraCinese test14 (
    .P1(P1),
    .P2(P2),
    .START(START),
    .clk(clk),
    .ROUND(ROUND),
    .GAME(GAME)
    );

    task Simulate();
      $fdisplay(script, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);
    endtask

    task Output();   
      $fdisplay(out, "Outputs: %b %b %b %b", ROUND[1],ROUND[0],GAME[1], GAME[0]);
      endtask



    always
    #10 clk = ~clk;
  
  initial begin
    
    script = $fopen("testbench.script", "w");
    out = $fopen("output_verilog.txt", "w");

    $dumpfile("tb.vcd");
    $dumpvars(1);
    
    $fdisplay(script,"rl FSMD.blif");
    
    clk = 1'b0;

    START = 1'b1;  
    P1 = 2'b00;
    P2 = 2'b01;
    Simulate();         
    #20;
    Output();   //1


    START = 1'b0;
    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();         
    #20;
    Output();   //2

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();     
    #20;
    Output();   //3

    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();     
    #20;
    Output();   //4
    

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();     
    #20;
    Output();   //5
    

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();         
    #20;
    Output();   //6
    

    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();     
    #20;
    Output();   //7
    

    P1 = 2'b00; 
    P2 = 2'b00;
    Simulate(); 
    #20;
    Output();   //8
    

    P1 = 2'b01; 
    P2 = 2'b10;
    Simulate(); 
    #20;
    Output();   //9

    
    $fdisplay(script, "quit");
    $fclose(script);
    $fclose(out);
    $finish;


  end
endmodule
