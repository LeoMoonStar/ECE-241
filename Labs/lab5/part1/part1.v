module part1(input [0:0]KEY, input [1:0]SW, output [1:0]LEDR, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

	wire Clock = KEY[0];
	wire Clear = SW[0];
	wire Enable = SW[1];
	
	wire [7:0]Q;
	wire [6:0]T;
		
	T_flip_flop call1(Enable, Clock, Clear, Q[0]);
	
	assign T[0] = Enable & Q[0];
	T_flip_flop call2(T[0], Clock, Clear, Q[1]);
	
	assign T[1] = T[0] & Q[1];
	T_flip_flop call3(T[1], Clock, Clear, Q[2]);
	
	assign T[2] = T[1] & Q[2];
	T_flip_flop call4(T[2], Clock, Clear, Q[3]);
		
	assign T[3] = T[2] & Q[3];
	T_flip_flop call5(T[3], Clock, Clear, Q[4]);
	
	assign T[4] = T[3] & Q[4];
	T_flip_flop call6(T[4], Clock, Clear, Q[5]);
	
	assign T[5] = T[4] & Q[5];
	T_flip_flop call7(T[5], Clock, Clear, Q[6]);
		
	assign T[6] = T[5] & Q[6];
	T_flip_flop call8(T[6], Clock, Clear, Q[7]);
	
	assign LEDR = SW;

	hex_decoder inst1(Q[3:0], HEX0);
	hex_decoder inst2(Q[7:4], HEX1);
	
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	assign HEX6 = 7'b1111111;
	assign HEX7 = 7'b1111111;
		
endmodule 