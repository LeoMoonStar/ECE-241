module char_7seg(input [2:0]c, output [6:0]Display);

	wire [6:0]temp;
	
	assign temp[0] = ~c[2];
	assign temp[1] = ~c[1] | (c[0] & ~c[2]);
	assign temp[2] = (~c[1] & (c[0] | c[2])) | (~c[2] & c[1] & ~c[0]);
	assign temp[3] = ~c[2] & c[1];
	assign temp[4] = ~c[2] & (~c[1] | c[0]);
	assign temp[5] = ~((c[1] | c[2]) & (c[1] | c[0]) & (c[2] | c[0]));
	assign temp[6] = ~c[2] | ~(c[0] | c[1]);
	
	assign Display = ~temp;
	
endmodule 