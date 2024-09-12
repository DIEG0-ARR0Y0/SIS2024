// Code your testbench here
// or browse Examples

// come viene simulato il file verilog? su eda playground non capisco come è possibile vedere i file di output e soprattutto non capisco se vengono generati
module testbench;
  
  reg [1:0] P1, P2; 
  reg START;
  reg [1:0] ROUND;  // eventualmente modificare in wire
  reg [1:0] GAME;  // eventualmente modificare in wire
  reg clk;

  integer output;  // servirà per gestire il file creato "output_verilog.txt", vedi begin
  integer test_script; // servirà per gestire il file creato "testbench.script", vedi begin
  
  MorraCinese Morracin(
    .clk(clk), 
    .P1(P1), 
    .P2(P2), 
    .START(START), 
    .ROUND(ROUND), 
    .GAME(GAME)
    );
    
    //tasks
    // Task per scrivere gli input nel file testbench.script
    task Simulate();
        $fdisplay(test_script, "simulate %b %b %b", P1, P2, START);
    endtask
  
    // Task per scrivere l'output nel file output_verilog.txt
    task Output();
        $fdisplay(output, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);
    endtask
    
    // alterno il segnale di clock
    always #10 clk = ~clk;  
  
    initial begin

        // apertura file di output
        output = $fopen("output_verilog.txt","w");
        test_script = $fopen("testbench.script", "w");

        // Dump delle variabili per la visualizzazione delle forme d'onda (approfondire)
        $dumpfile("dump.vcd");
        $dumpvars(1);

        // scrive il comando per caricare il modello SIS nello script
        $fdisplay(test_script,"rl FSMD.blif"); // eventualmente adattare nome "FSMD.blif", è utilizzata per scrivere la stringa "rl FSMD.blif" nel file gestito dalla variabile test_script, aperta precedentemente con $fopen
        // rl FSMD.blif fa parte dello script necessario per eseguire correttamente il modello SIS in ambiente SIS

        //inzializzo il clock
        clk = 1'b0;

        // test 1: start alzato, decido n manche
        INIZIA = 1'b1;  
        PRIMO = 2'b01;  // nmanche=1+2=3 (da aggiungere alle 4 manche di base?) 
        SECONDO = 2'b10; 
        Simulate();			
        #20;
        Output();   

        //test 2: 
        INIZIA = 1'b0;  //setto start a 0 senza poi settarlo nuovamente se non cambia
        PRIMO = 2'b00;  // no mossa
        SECONDO = 2'b01; // sasso
        Simulate();			
        #20;
        Output();

        //test 3: 
        PRIMO = 2'b01;  
        SECONDO = 2'b11; 
        Simulate();			
        #20;
        Output();

        //test 4: 
        PRIMO = 2'b10;  
        SECONDO = 2'b00; 
        Simulate();			
        #20;
        Output();

        //test 5: 
        PRIMO = 2'b11;  
        SECONDO = 2'b11; 
        Simulate();			
        #20;
        Output();

        // chiusura dei file di output e script
        $fdisplay(test_script, "quit");  // chiusura script SIS
        $fclose(test_script);
        $fclose(output);
        $finish;  // Termina la simulazione

    end    
endmodule
    
