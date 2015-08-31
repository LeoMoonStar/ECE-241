module D_flip_flop(input w, clk, clr, output reg z);

	always@(negedge clr, posedge clk)
		if(!clr)
			z <= 0;
		else
			z <= w;

endmodule 