module D_flip_flop(input w, clk, clr, A, output reg z);

	always@(posedge clk)
		if(!clr)
			z <= A;
		else
			z <= w;

endmodule 