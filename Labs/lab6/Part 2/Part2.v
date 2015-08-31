module Part2(input [0:0]KEY, input [1:0]SW, output [0:0]LEDG, output [2:0]LEDR);

wire Clock, w, Resetn, z;
assign Clock = KEY;
assign w = SW[1];
assign Resetn = SW[0];
reg[2:0]y,Y;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;
parameter G = 3'b110;
parameter H = 3'b111;

always@(w,y)
case(y)
A: if(!w) Y = B;
	else Y = A;
B: if(!w) Y = C;
	else Y = F;
C: if(!w) Y = D;
	else Y = F;
D: if(!w) Y = E;
	else Y = F;
E: if(!w) Y = E;
	else Y = F;
F: if(!w) Y = B;
	else Y = G;
G: if(!w) Y = H;
	else Y = A;
H: if(!w) Y = C;
	else Y = F;
endcase

always@(posedge Clock)
if(Resetn == 0)
y <= A;
else 
y <= Y;

assign LEDR = y;
assign LEDG = z;
assign z = (y == E | y == H);
endmodule
