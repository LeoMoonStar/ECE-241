module part2(input [17:0]SW, output [17:0]LEDR, output [7:0]LEDG);
	
	wire [7:0] X, Y, M;
	wire s;
			
	assign X = SW[7:0];
	assign Y = SW[15:8];
	assign s = SW[17];
	assign LEDR[15:0] = SW[15:0];
	assign LEDR[17] = SW[17];
	assign LEDG[7:0] = M;
	
	mux2to1 call1(X[0], Y[0], s, M[0]);
	mux2to1 call2(X[1], Y[1], s, M[1]);
	mux2to1 call3(X[2], Y[2], s, M[2]);
	mux2to1 call4(X[3], Y[3], s, M[3]);
	mux2to1 call5(X[4], Y[4], s, M[4]);
	mux2to1 call6(X[5], Y[5], s, M[5]);
	mux2to1 call7(X[6], Y[6], s, M[6]);
	mux2to1 call8(X[7], Y[7], s, M[7]);	
	
endmodule 

module mux2to1(input x, y, s, output m);

	assign m = (~s & (x | y)) | (s & (x & y));
	
endmodule 