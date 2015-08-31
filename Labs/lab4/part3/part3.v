module part3(SW, KEY, HEX0, HEX1, HEX2, HEX3);
	input [11:0] SW;
	input [0:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3;

	wire clock = KEY;
	wire [7:0]DATA = SW[7:0];
	wire [2:0]OPCODE = SW[10:8];
	wire reset = SW[11];
	wire [7:0]B;
	reg [7:0] B_IN;
	parameter hex_cleared = 8'h0;

	ALU call(DATA, B_IN, OPCODE, B);
	
	hex_decoder hex0(B_IN[3:0], HEX0);
	hex_decoder hex1(B_IN[7:4], HEX1);
	hex_decoder hex2(DATA[3:0], HEX2);
	hex_decoder hex3(DATA[7:4], HEX3);

	always @(negedge reset or posedge clock)
		if(!reset)
			B_IN <= hex_cleared;
		else
			B_IN <= B;

endmodule 