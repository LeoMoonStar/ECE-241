module shift_reg_parallel(input right, left, load_left, D, load_n, clock, output q);

	wire [1:0]in;
	
	mux2to1 call1(right, left, load_left, in[0]);
	mux2to1 call2(D, in[0], load_n, in[1]);
	
	D_flip_flop call(in[1], clock, q);
	
endmodule 