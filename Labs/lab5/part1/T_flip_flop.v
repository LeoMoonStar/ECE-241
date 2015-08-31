module T_flip_flop(input T, clk, clr, output q);

	wire d = T ^ q;
	
	D_flip_flop call(d, clk, clr, q);
	
endmodule 