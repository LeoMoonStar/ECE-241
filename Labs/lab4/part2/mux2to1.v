module mux2to1(input x, y, s, output m);

	assign m = (~s & x) | (s & y);
	
endmodule 