module Part5(input [9:0]SW, input [0:0]KEY, output [15:0]LEDR, output [6:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
wire clock = KEY;
wire [2:0]Q;
wire LoadEnable1 = SW[8];
wire LoadEnable2 = SW[9];
wire [7:0]DATA_A= SW[7:0];
reg [7:0] A,B;
wire [15:0]Z;
assign LEDR = Z;
always @(posedge clock)
		if(LoadEnable1 == 1)
			A <= DATA_A;
		else if(LoadEnable2 == 1)
			B <= DATA_A;

ALU call(A, B, Z);
hex_decoder hex0(Z[3:0], HEX0);
hex_decoder hex1(Z[7:4], HEX1);
hex_decoder hex2(Z[11:8], HEX2);
hex_decoder hex3(Z[15:12], HEX3);
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
assign HEX6 = 7'b1111111;
assign HEX7 = 7'b1111111;

endmodule 