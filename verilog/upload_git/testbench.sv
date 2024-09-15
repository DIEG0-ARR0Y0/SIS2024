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
    P1 = 2'b11;
    P2 = 2'b01;
    Simulate();         
    #20;
    Output();   //1

    
    START = 1'b0;
    P1 = 2'b11;
    P2 = 2'b10;
    Simulate();         
    #20;
    Output();   //2

    P1 = 2'b01;
    P2 = 2'b01;
    Simulate();     
    #20;
    Output();   //3

    P1 = 2'b10;
    P2 = 2'b00;
    Simulate();     
    #20;
    Output();   //4
    

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();     
    #20;
    Output();   //5
    

    START = 1'b1;
    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();         
    #20;
    Output();   //6
    

    START = 1'b0; 
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();     
    #20;
    Output();   //7
    

    P1 = 2'b00; 
    P2 = 2'b11;
    Simulate(); 
    #20;
    Output();   //8
    

    P1 = 2'b10; 
    P2 = 2'b01;
    Simulate(); 
    #20;
    Output();   //9
    

    P1 = 2'b01; 
    P2 = 2'b00;
    Simulate(); 
    #20;
    Output();   //10
    

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();         
    #20;
    Output(); //11
    

    P1 = 2'b00;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //12
    

    START = 1'b1;  
    P1 = 2'b11;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //13
    

    
    START = 1'b0;
    
    P1 = 2'b11;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //14
    

    P1 = 2'b11;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //15
    

    P1 = 2'b10;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //16
    

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //17
    

    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //18
    

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //19
    

    P1 = 2'b00;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //20
    

    P1 = 2'b11;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //21
    

    P1 = 2'b01;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //22
    

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //23
    

    P1 = 2'b00;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //24
    
        
    P1 = 2'b01;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //25

    P1 = 2'b10;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //26

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //27

    START = 1'b1;
    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //28

    START = 1'b0;
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //29

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //30

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //31

    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //32

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //33

    P1 = 2'b00;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //34

    P1 = 2'b11;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //35

    P1 = 2'b01;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //36

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //37

    P1 = 2'b00;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //38

    START = 1'b0;
    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //39

    START = 1'b0;
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //40

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //41

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //42


    START = 1'b1;
    P1 = 2'b00;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //43

    START = 1'b0;
    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //44

    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //45

    P1 = 2'b11;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //46


    START = 1'b0;
    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //47

    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //48

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //49


    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //50

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //51

    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //52

    START = 1'b1;
    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //53

    START = 1'b0;
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //54

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //55

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //56

    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //57

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //58

    P1 = 2'b00;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //59

    P1 = 2'b11;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //60

    P1 = 2'b01;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //61

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //62

    P1 = 2'b00;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //63


    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //64

    P1 = 2'b00;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //65


    START = 1'b1;
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //66

    START = 1'b0;
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //67

    P1 = 2'b00;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //68

    P1 = 2'b10;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //69

    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //70

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //71

    P1 = 2'b00;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //72

    START = 1'b1;
    P1 = 2'b01;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //73

    START = 1'b0;
    P1 = 2'b11;
    P2 = 2'b00;
    Simulate();
    #20;
    Output();   //74 1 

    P1 = 2'b01;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //75 2 

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //76 3

    P1 = 2'b11;
    P2 = 2'b10;
    Simulate();
    #20;
    Output();   //77 4

    P1 = 2'b01;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //78 5

    P1 = 2'b01;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //79 6

    P1 = 2'b10;
    P2 = 2'b11;
    Simulate();
    #20;
    Output();   //80 7


    P1 = 2'b01;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //81 8 

    P1 = 2'b01;
    P2 = 2'b01;
    Simulate();
    #20;
    Output();   //82 9
    
    $fdisplay(script, "quit");
    $fclose(script);
    $fclose(out);
    $finish;


  end
endmodule
