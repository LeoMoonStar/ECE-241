module part3(input [4:1]SW, output [0:0]LEDR);

	wire [3:0]x = SW;
	assign LEDR[0] = x[1] & x[3] | x[0] & ~x[1];
	
endmodule 