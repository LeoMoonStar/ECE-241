module part2(input [8:0]SW, output [8:0]LEDR, output [4:0]LEDG);

	wire [3:0] A, B, S;
	wire [2:0] C;
	wire cIN, cOUT;
	
	assign A = SW[7:4];
	assign B = SW[3:0];
	assign cIN = SW[8];
	
	assign LEDR = SW;
	assign LEDG[3:0] = S;
	assign LEDG[4] = cOUT;
	
	fullAdder FA1(A[0], B[0], cIN, S[0], C[0]);
	fullAdder FA2(A[1], B[1], C[0], S[1], C[1]);
	fullAdder FA3(A[2], B[2], C[1], S[2], C[2]);
	fullAdder FA4(A[3], B[3], C[2], S[3], cOUT);
	
 endmodule 