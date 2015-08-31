module part2(input [0:0]KEY, input [1:0]SW, output [1:0]LEDR, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

	wire Clock = KEY[0];
	wire Clear = SW[0];
	wire Enable = SW[1];
	
	reg [7:0]Q;
	
	always@(negedge Clear, posedge Clock)
		if(!Clear)
			Q <= 0;
		else if(Enable)
			Q <= Q + 1;
			
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