module part3(input [2:0]KEY, input [17:0]SW, output [2:0]LEDG, output [17:0]LEDR);

	wire [2:0] s, U, V, W, X, Y, Z, M;
	
	assign s = KEY;
	assign U = SW[2:0];
	assign V = SW[5:3];
	assign W = SW[8:6];
	assign X = SW[11:9];
	assign Y = SW[14:12];
	assign Z = SW[17:15];
	assign LEDR = SW;
	assign LEDG = M;
	
	mux6to1 call1(s, U[0], V[0], W[0], X[0], Y[0], Z[0], M[0]);
	mux6to1 call2(s, U[1], V[1], W[1], X[1], Y[1], Z[1], M[1]);
	mux6to1 call3(s, U[2], V[2], W[2], X[2], Y[2], Z[2], M[2]);

endmodule 	

module mux6to1(input [2:0]s, input u, v, w, x, y, z, output m);

	wire a, b, c, d;
	
	mux2to1 inst1(u, v, s[0], a);
	mux2to1 inst2(w, x, s[0], b);
	mux2to1 inst3(a, b, s[1], c);
	mux2to1 inst4(y, z, s[0], d);
	mux2to1 inst5(c, d, s[2], m);

endmodule

module mux2to1(input x, y, s, output m);

	assign m = (~s & x) | (s & y);
	
endmodule 