/* NOTE:

	- rivedere struttura switch-case per decretare il vincitore del match
	- completare struttura switch-case

*/

module MorraCienese(
	
	input clk,
	input[1:0] P1,
	input[1:0] P2,
	input START,

	output reg[1:0] ROUND = 2'b00,
	output reg[1:0] GAME = 2'b00
);


	reg[2:0] CURRENT_STATE = 3'b000;
	reg[2:0] NEXT_STATE;

	reg[1:0] CURRENT_ROUND_WINNER = 2'b00;
	reg[1:0] PREV_ROUND_WINNER = 2'b00;
	reg[1:0] PREV_WINNING_MOVE = 2'b00;

	reg[4:0] PLAYED = 5'b00000;
	reg[4:0] TO_PLAY = 5'b00000;

	reg[3:0] ADV = 4'b0100;



	always @(posedege clk) begin : UPDATE_STATE
		STATE = NEXT_STATE;
	end


	// datapath

	always @(posedge clk) begin : DATAPATH
		if(START) begin
			CURRENT_STATE = 3'b000;
			CURRENT_ROUND_WINNER = 2'b00;
			PREV_ROUND_WINNER = 2'b00;
			PREV_WINNING_MOVE = 2'b00;
			PLAYED = 5'b00000;
			TO_PLAY = {P1, P2} + 4;
			ADV = 4'b01000
		end else begin

			// IF per determinare se ci sono le condizioni per disputare il round
			if((ADV > 4'b0010 && ADV < 4'b0110) || PLAYED != TO_PLAY) begin

				// IF per determinare se il round e' nulla
				if(PREV_ROUND_WINNER == b'01 && PREV_WINNING_MOVE == P1 || PREV_ROUND_WINNER == b'10 && PREV_WINNING_MOVE == P2 || {P1, P2} == 4'b0000 || {P1, P2} == 4'b1000 || {P1, P2} == 4'b0100 || {P1, P2} == 4'b0010 || {P1, P2} == 4'b0001) begin
					CURRENT_ROUND_WINNER = 2'b00;
					PREV_ROUND_WINNER = PREV_ROUND_WINNER;
					PREV_WINNING_MOVE = PREV_WINNING_MOVE;

				// SWITCH-CASE per determinare il vincitore del round
				end else begin
					case({P1, P2}) begin
						// vince 1				
						4'0111, 4'1001, 4'1110: begin
							CURRENT_ROUND_WINNER = 2b'01;
							PREV_ROUND_WINNER = 2b'01;
							PREV_WINNING_MOVE = P1;
							ADV = ADV + 1;
						end
						// vince 2
						4'1101, 4'0110, 4'1011: begin
							CURRENT_ROUND_WINNER = 2b'10;
							PREV_ROUND_WINNER = 2b'10;
							PREV_WINNING_MOVE = {P2};
							ADV = ADV - 1;
						end
						// pari
						4'b0101, 4'b1010, 4'1111: begin
							CURRENT_ROUND_WINNER = b'11;
							PREV_ROUND_WINNER = 2b'00;
							PREV_WINNING_MOVE = 2b'00;
						end
				endcase
				PLAYED = PLAYED + 1;
			end
