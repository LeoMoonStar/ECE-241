module Part4(input CLOCK_50, output [6:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
parameter [2:0]a = 3'b0;
parameter [2:0]b = 3'b001;
parameter [2:0]c = 3'b010;
parameter [2:0]d = 3'b010;
wire [6:0]H0, H1, H2, H3;
assign HEX0 = H0;
assign HEX1 = H1;
assign HEX2 = H2;
assign HEX3 = H3;
integer i;
call U0(D, H0);
call U1(C, H1);
call U2(B, H2);
call U3(A, H3);
reg[2:0]A = a;
reg[2:0]B = b;
reg[2:0]C = c;
reg[2:0]D = d;
always@( posedge CLOCK_50)
begin
i = i + 1;
if(i == 50000000)
begin
A <= D;
D <= C;
C <= B;
B <= A;
i = 0;
end
end

assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
assign HEX6 = 7'b1111111;
assign HEX7 = 7'b1111111;
endmodule



module call(input [2:0]c, output [6:0]H);

	wire [6:0]temp;  

	assign temp[0] = ~c[2];
	assign temp[1] = ~c[1] | (c[0] & ~c[2]);
	assign temp[2] = (~c[1] & (c[0] | c[2])) | (~c[2] & c[1] & ~c[0]);
	assign temp[3] = ~c[2] & c[1];
	assign temp[4] = ~c[2] & (~c[1] | c[0]);
	assign temp[5] = ~((c[1] | c[2]) & (c[1] | c[0]) & (c[2] | c[0]));
	assign temp[6] = ~c[2] | ~(c[0] | c[1]);
	
	assign H = ~temp;
	
endmodule 