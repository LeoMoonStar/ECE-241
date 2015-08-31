module ALU(input [7:0] A, B, input [2:0]Q, output [7:0]M);

	reg [7:0]Z;
	always@(A, B, Q)
	case(Q)
		3'b000: Z = ~A | B;
		3'b001: Z = A | ~B;
		3'b010: Z = ~A;
		3'b011: Z = A & B;
		3'b100: Z = A + B;
		3'b101: Z = ~(A | B);
		3'b110: Z = A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] + A[7]; 
		3'b111: Z = A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] + A[7] + B[0] + B[1] + B[2] + B[3] + B[4] + B[5] + B[6] + B[7];
	endcase
	assign M = Z;
	
endmodule 