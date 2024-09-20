module MorraCinese(
	
	// Inputs
	input clk,
	input[1:0] P1,
	input[1:0] P2,
	input START,

	// Outputs
	output reg[1:0] ROUND = 2'b00,
	output reg[1:0] GAME = 2'b00
);


	// Registers and variables
	reg[2:0] CURRENT_STATE = 3'b000;
	reg[2:0] NEXT_STATE;

	reg[1:0] CURRENT_ROUND_WINNER = 2'b00;
	reg[1:0] PREV_ROUND_WINNER = 2'b00;
	reg[1:0] PREV_WINNING_MOVE = 2'b00;

	reg[4:0] PLAYED = 5'b00000;
	reg[4:0] TO_PLAY = 5'b00000;

	reg[3:0] ADV = 4'b0100;



	// FSM Update state
	always @(posedge clk) begin : UPDATE_STATE
		CURRENT_STATE = NEXT_STATE;
	end



	// Datapath
	always @(posedge clk) begin : DATAPATH

	/*	Case 1:
		If Start signal True or Current state equal to
		reset state "000", then every value must be setted
		to its default configuration.

		In case Start signal is True the {P1, P2} bits con-
		figuration has to be concatenated and added to def-
		ault value '4' to set the rounds to play.
	*/
		if(START || CURRENT_STATE == 3'b000) begin
			CURRENT_ROUND_WINNER = 2'b00;
			PREV_ROUND_WINNER = 2'b00;
			PREV_WINNING_MOVE = 2'b00;
			PLAYED = 5'b00000;
			ADV = 4'b0100;
			if(START) begin
				TO_PLAY = TO_PLAY + {P1, P2};
			end else begin
				TO_PLAY = 5'b00100;
			end

	/*	Case 2:
		If we're not in Case 1 it means FSM state is any other
		but the reset state "000", which are valid state to play
		a round.
		So, from now on 2 things could happen:
			1. We have   valid condition to play the round
			2. We have invalid condition to play the round
		So we check condition 1:
	*/
		end else if(((ADV > 4'b0010 && ADV < 4'b0110) && PLAYED < TO_PLAY) || PLAYED < 4) begin
			
			/*	If we have a valid condition we have other 2 possible
				scenarios:
					1. Round outcome is invalid
					2. Round outcome is   valid
			*/
			// If round outcome is INVALID:
			if({PREV_ROUND_WINNER, PREV_WINNING_MOVE} == {2'b01, P1} || {PREV_ROUND_WINNER, PREV_WINNING_MOVE} == {2'b10, P2} || P1 == 2'b00 || P2 == 2'b00) begin
				CURRENT_ROUND_WINNER = 2'b00;

			// If round outcome is   VALID:
			end else begin
				case({P1, P2})
					// Wins P1
					4'b0111, 4'b1001, 4'b1110: begin
						CURRENT_ROUND_WINNER = 2'b01;
						PREV_ROUND_WINNER = 2'b01;
						PREV_WINNING_MOVE = P1;
						ADV = ADV + 1;
					end
					// Wins P2
					4'b1101, 4'b0110, 4'b1011: begin
						CURRENT_ROUND_WINNER = 2'b10;
						PREV_ROUND_WINNER = 2'b10;
						PREV_WINNING_MOVE = P2;
						ADV = ADV - 1;
					end
					// Draw
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



	// FSM


	/* FSM STATE SUMMARY:

	+------------------------------------------------------------------------+
	|Encode		Name		Description										 |
	+------------------------------------------------------------------------+
	|																		 |
	| 000		START		Reset state, set Datapath to default values		 |
	| 001		INIT		Initialize state, iff Start signal evaulate True |
	| 010		WIN1		Round is won by P1								 |
	| 011		WIN2		Round is won by P2								 |
	| 100		DRAW		Round draws										 |
	| 101		INVALID		Round is invalid								 |
	|																		 |
	+------------------------------------------------------------------------+

	*/

	always @(posedge clk) begin : FSM

	/*	Case 1:
		Start signal evaluates True, no matter the state, the FSM
		transits to INIT state.
	*/	
		if(START) begin
			NEXT_STATE = 3'b001;
			ROUND = 2'b00;
			GAME = 2'b00;

	/*	Case 2:
		Start signal evaluates False, if current state is reset state
		then FSM slef-transits to reset state.
	*/
		end else if(CURRENT_STATE == 3'b000) begin
			NEXT_STATE = 3'b000;
			ROUND = 2'b00;
			GAME = 2'b00;

	/* Case 3:
		Start signal evaluates False, if current state is any other state
		but reset state, FSM transits to next state based on the round outcome
	*/
		end else begin

			ROUND = CURRENT_ROUND_WINNER;

			// If game not done yet
			if(((ADV > 4'b0010 && ADV < 4'b0110) && PLAYED < TO_PLAY) || PLAYED < 4) begin
				GAME = 2'b00;

				// Case to determins the Next State
				case (ROUND)
					2'b00: NEXT_STATE = 3'b101;
					2'b01: NEXT_STATE = 3'b010;
					2'b10: NEXT_STATE = 3'b011;
					2'b11: NEXT_STATE = 3'b100;
				endcase
			
			// If game is done
			end else begin
				// Game winner:
				if(ADV > 4'b0100) begin				// Game won by P1
					GAME = 2'b01;
				end else if(ADV < 4'b0100) begin	// Game won by P2
					GAME = 2'b10;
				end else if(ADV == 4'b0100) begin	// Game draws
					GAME = 2'b11;
				end
				NEXT_STATE = 3'b000;
			end
		end
	end
endmodule
