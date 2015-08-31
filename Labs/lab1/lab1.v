module lab1(a, b, c, f1, f2, f3);
	input a, b, c;
	output f1, f2, f3;
	assign f1 = (a & !b & !c) | (!a & b & !c) | (!a & !b & c);
	assign f2 = a & b & c;
	assign f3 = (!f1 & !f2) & (a | b | c);
endmodule
