module part4(input [2:0]SW, output [2:0]LEDR, output [6:0]HEX0);

	wire [2:0]c = SW;
	wire [6:0]temp;
	
	assign LEDR = SW;  
	
	assign temp[0] = ~c[2];
	assign temp[1] = ~c[1] | (c[0] & ~c[2]);
	assign temp[2] = (~c[1] & (c[0] | c[2])) | (~c[2] & c[1] & ~c[0]);
	assign temp[3] = ~c[2] & c[1];
	assign temp[4] = ~c[2] & (~c[1] | c[0]);
	assign temp[5] = ~((c[1] | c[2]) & (c[1] | c[0]) & (c[2] | c[0]));
	assign temp[6] = ~c[2] | ~(c[0] | c[1]);
	
	assign HEX0 = ~temp;
	
endmodule 