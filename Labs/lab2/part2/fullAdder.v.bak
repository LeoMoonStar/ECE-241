module fullAdder(input a, b, cI, output s, cO);

	wire d = a ^ b;
	assign s = cI ^ d;
	mux2to1 call(b, cI, d, cO);
	
endmodule 