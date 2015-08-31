module D_flip_flop(input w, clk, output z);

	reg z;
	always@(posedge clk)
		z <= w;

endmodule 