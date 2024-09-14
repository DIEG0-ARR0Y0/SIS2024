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
		CURRENT_STATE = NEXT_STATE;
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
			ADV = 4'b0100;
		end else begin
			// ......................................
			if CURRENT_STATE == 3'b001 begin
				TO_PLAY = {P1, P2} + 4;
			end

			// IF per determinare se ci sono le condizioni per disputare il round
			if((ADV > 4'b0010 && ADV < 4'b0110) && PLAYED < TO_PLAY) begin

				// IF per determinare se il round e' nulla
				if({PREV_ROUND_WINNER, PREV_WINNING_MOVE} == {2'b01, P1} || {PREV_ROUND_WINNER, PREV_WINNING_MOVE} == {2'b10, P2} || P1 == 2'b00 || P2 == 2'b00) begin
					CURRENT_ROUND_WINNER = 2'b00;
					PREV_ROUND_WINNER = PREV_ROUND_WINNER;
					PREV_WINNING_MOVE = PREV_WINNING_MOVE;

				// SWITCH-CASE per determinare il vincitore del round
				end else begin
					case({P1, P2}) begin
						// vince 1				
						4'b0111, 4'b1001, 4'b1110: begin
							CURRENT_ROUND_WINNER = 2'b01;
							PREV_ROUND_WINNER = 2'b01;
							PREV_WINNING_MOVE = {P1};
							ADV = ADV + 1;
						end
						// vince 2
						4'b1101, 4'b0110, 4'b1011: begin
							CURRENT_ROUND_WINNER = 2'b10;
							PREV_ROUND_WINNER = 2'b10;
							PREV_WINNING_MOVE = {P2};
							ADV = ADV - 1;
						end
						// pari
						4'b0101, 4'b1010, 4'b1111: begin
							CURRENT_ROUND_WINNER = 2'b11;
							PREV_ROUND_WINNER = 2'b00;
							PREV_WINNING_MOVE = 2'b00;
						end
					endcase
					PLAYED = PLAYED + 1;
				end
			end
		end
	end


	always @(posedge clk) begin : FSM
		if(START) begin
			NEXT_STATE = 3'b000;
			ROUND = 2'b00;
			GAME = 2'b00;

		end else if(!START && CURRENT_STATE == 3'b000) begin
			NEXT_STATE = 3'b001;
			ROUND = 2'b00;
			GAME = 2'b00;

		end else if(!START && CURRENT_STATE >= 3'b001):
			if(((ADV > 4'b0010 && ADV < 4'b0110) && PLAYED < TO_PLAY) || PLAYED < 4) begin
				GAME = 2'b00;
				ROUND = CURRENT_ROUND_WINNER;
				case(ROUND) begin
					2'b00: begin
						NEXT_STATE = 3'b101
					end
					2'b01: begin
						NEXT_STATE = 3'b010
					end
					2'b10: begin
						NEXT_STATE = 3'b011
					end
					2'b11: begin
						NEXT_STATE = 3'b100
				endcase
			end
		end else begin
			if(ADV < 4'b0100) begin
				GAME == 2'b01;
			end else if(ADV > 4'b0100) begin
				GAME == 2'b10;
			end else if(ADV == 4'b0100) begin
				GAME == 2'b11;
			end
			NEXT_STATE = 3'b000;
		end
	endmodule
