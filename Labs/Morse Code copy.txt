module Morse_Code(LEDR, SW, KEY, CLOCK_50);
	input [2:0]SW;
	input [1:0]KEY;
	input CLOCK_50;
	output[0:0] LEDR;
	wire elapsed, enable, load, reset, isCountZero, shiftOut;
	wire [3:0] morseCode;
	wire [1:0] numBits;
	
	FSM(KEY[1], shiftOut, CLOCK_50, elapsed, isCountZero, enable, load, reset, LEDR[0], KEY[0]);
	one_half_sec_timer(CLOCK_50, elapsed, reset);
	symbol_decoder(SW[2:0], morseCode, numBits);
	symbol_shift_reg(enable, load, CLOCK_50, morseCode, shiftOut);
	symbol_down_counter(enable, load, CLOCK_50, numBits, isCountZero);
endmodule

module one_half_sec_timer(CLOCK_50, delay, reset);
	output reg delay;
	input	CLOCK_50, reset;
	reg [25:0] count;
	
	initial begin
		delay = 0;
		count = 0;
	end
	
	always @(posedge CLOCK_50 or posedge reset)
	begin
		if(reset)begin
			count <= 0;
			delay <= 0;
		end
		else if(count==26'd24_999_999)
		begin
			count<=0;
			delay<=1;
		end
		else
		begin
			count<=count+1;
			delay<=0;
		end
	end
endmodule

module symbol_decoder(symbolCode, morseCode, numBits);
	input [2:0] symbolCode;
	output reg [3:0] morseCode; // 1 dots, 0 dashes
	output reg [1:0] numBits;
	
	always @ (symbolCode)
	begin
		case(symbolCode)
			3'b000: begin 	morseCode = 4'b0100; //Q
								numBits = 2'd3;	end
			3'b001: begin 	morseCode = 4'b0101; //R
								numBits = 2'd2;	end
			3'b010: begin 	morseCode = 4'b0111; //S
								numBits = 2'd2;	end
			3'b011: begin 	morseCode = 4'b0000; //T
								numBits = 2'd0;	end
			3'b100: begin 	morseCode = 4'b0011; //U
								numBits = 2'd2; 	end
			3'b101: begin 	morseCode = 4'b0111; //V
								numBits = 2'd3; 	end
			3'b110: begin 	morseCode = 4'b0001; //W
								numBits = 2'd2; 	end
			3'b111: begin 	morseCode = 4'b0110; //X
								numBits = 2'd3;	end
		endcase
	end
	
endmodule

module symbol_shift_reg(enable, load, clock, morseCode, shiftOut);
	input enable, load, clock;
	input [3:0] morseCode;
	output reg shiftOut; //0 = 1.5s, 1 = .5s
	
	reg [3:0] current;	
	
	always @ (posedge clock)
	begin
		if(load) begin
			current[0] = morseCode[1];
			current[1] = morseCode[2];
			current[2] = morseCode[3];
			shiftOut = morseCode[0];
		end
		if(enable) begin
			current[0] <= current[1];
			current[1] <= current[2];
			shiftOut <= current[0];
		end
	end
	
	
endmodule

module symbol_down_counter(enable, load, clock, numBits, isCountZero);
	input enable, load, clock;
	input [1:0] numBits;
	output reg isCountZero;
	
	reg [1:0] count;
	
	always @ (posedge clock)
	begin
		if(enable) begin
			isCountZero <= 0;
			count <= count - 1;
		end
		else if(load) begin
			count <= numBits;
			isCountZero <= 0;
		end
		if(count == 2'd0)
			isCountZero <= 1;
	end
endmodule

module FSM(start, shiftOut, CLOCK_50, elapsed, isCountZero, enable, load, reset, out, clear);
	input start, shiftOut, elapsed, isCountZero, CLOCK_50, clear;
	output out, enable, load, reset;
	reg [2:0] currentState, nextState;
	reg [1:0] count;
	parameter IDLE = 3'b001, LOAD = 3'b010, COMPUTE = 3'b011, DOT = 3'b100, DASH = 3'b101, PAUSE = 3'b110, RELOAD = 3'b111;
	initial
	begin
		count <= 0;
		currentState = IDLE;
		nextState = IDLE;
	end
	
	always @ (currentState or start)
	begin
		case(currentState)
			IDLE: begin
						if(~start) nextState = LOAD;
						else nextState = IDLE;
					end
			LOAD: begin
						nextState = COMPUTE;
					end
			COMPUTE: begin
							if(isCountZero) nextState = IDLE;
							else begin 
								if(shiftOut) nextState = DOT;
								else nextState = DASH;
							end
						end
			DOT: begin
						nextState = PAUSE;
					end
			DASH: begin
						nextState = PAUSE;
					end
			PAUSE:begin
						nextState = RELOAD;
					end
			RELOAD:	begin
						nextState = COMPUTE;
						end
		endcase
	end
	
	assign out = (currentState == DOT)|(currentState == DASH);
	assign enable = (currentState == RELOAD);
	assign load = (currentState == LOAD);
	assign reset = (currentState == LOAD);
	
	always @ (posedge CLOCK_50, negedge clear)
	begin
		if(~clear) currentState <= IDLE;
		else if(currentState == IDLE | currentState == LOAD | currentState == COMPUTE | currentState == RELOAD) begin
			currentState <= nextState;	
		end
		else if(currentState == DOT | currentState == PAUSE) begin
			count = 0;
			if(elapsed)
				currentState <= nextState;
		end
		else begin
			if(elapsed)
				count = count + 1;
			if(count == 3)
				currentState <= nextState;
		end
	end
	
endmodule
