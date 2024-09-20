`timescale 1ns / 1ps

module tb_MorraCinese;

	// File descriptors
	integer tbf, outf;

	reg clk;
	reg START;
	reg [1:0] P1;
	reg [1:0] P2;
	reg [1:0] ROUND;
	reg [1:0] GAME;

	MorraCinese testing(
		clk,
		P1, P2, START,
		ROUND, GAME);

	always #10 clk = ~clk;

	initial begin
		$dumpfile("dump.vdc");
		$dumpvars(1);
		tbf = $fopen("testbench.script", "w");
		outf = $fopen("output_verilog.txt", "w");
		$fdisplay(tbf,"read_blif FSMD.blif");

		clk = 1'b0;

		//1. Game 1, Round 0, To play 4
		START = 1'b1;	
		P1 = 2'b00;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//2. Game 1, Round 1, ADV +0
		START = 1'b0;
		P1 = 2'b01;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//3. Game 1, Round 2, ADV +0
		P1 = 2'b10;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//4. Game 1, Round 3, ADV +0
		P1 = 2'b11;
		P2 = 2'b11;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//5. Game 1, Round 4, ADV +0
		P1 = 2'b00;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//6. Game 1, Round 4, ADV -1, END
		P1 = 2'b01;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//7. Stand by
		P1 = 2'b01;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//8. Game 2, Round 0, To play 4
		START = 1'b1;
		P1 = 2'b00;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//9. Game 2, Round 0, To play 5
		P1 = 2'b00;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//10. Game 2, Round 1, ADV -1
		START = 1'b0;
		P1 = 2'b01;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//11. Game 2, Round 2, ADV +0
		P1 = 2'b01;
		P2 = 2'b11;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//12. Game 2, Round 3, ADV +1
		P1 = 2'b10;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//13. Game 2, Round 4, ADV +1
		P1 = 2'b11;
		P2 = 2'b11;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//14. Game 2, Round 5, ADV +1
		P1 = 2'b11;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//15. Game 2, Round 5, ADV +2, END
		P1 = 2'b10;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//16. Stand by
		P1 = 2'b00;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);
		
		//17. Game 3, Round 0, To play 5
		START = 1'b1;
		P1 = 2'b00;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//18. Game 3, Round 1, ADV +0
		START = 1'b0;
		P1 = 2'b10;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//19. Game 3, Round 2, ADV +1
		P1 = 2'b01;
		P2 = 2'b11;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//20. Game 3, Round 3, ADV +2
		P1 = 2'b10;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//21. Game 3, Round 4, ADV +2
		P1 = 2'b11;
		P2 = 2'b11;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//22. Stand by
		P1 = 2'b11;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//23. Standy by
		P1 = 2'b10;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//24. Stand by
		P1 = 2'b00;
		P2 = 2'b00;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//25. Game 4, To play 6 
		START = 1'b1;
		P1 = 2'b00;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//26. Game 4, Round 1, ADV +0  
		START = 1'b0;
		P1 = 2'b01;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//27. Game 4, Round 2, ADV +1  
		START = 1'b0;
		P1 = 2'b11;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//28. Game 4, Round 3, ADV +1 
		START = 1'b0;
		P1 = 2'b11;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//29. Game 4, Round 3, ADV +0 
		START = 1'b0;
		P1 = 2'b10;
		P2 = 2'b11;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//29. Game 4, Round 4, ADV +0 
		START = 1'b0;
		P1 = 2'b01;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//29. Game 5, Round 4, ADV +0 
		START = 1'b0;
		P1 = 2'b01;
		P2 = 2'b01;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		//29. Game 4, Round 4, ADV -1, END
		START = 1'b0;
		P1 = 2'b01;
		P2 = 2'b10;
		$fdisplay(tbf, "simulate %b %b %b %b %b", P1[1], P1[0], P2[1], P2[0], START);			 
		#20;
		$fdisplay(outf, "Outputs: %b %b %b %b", ROUND[1], ROUND[0], GAME[1], GAME[0]);

		$fdisplay(tbf, "quit");
		$fclose(tbf);
		$fclose(outf);
		$finish;
	end
endmodule
