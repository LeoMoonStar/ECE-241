module Diwali(output [6:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, output [17:0]LEDR, output [7:0]LEDG);
/*assign HEX6 = 7'b1111111;
assign HEX5 = 7'b0001001;
assign HEX4 = 7'b0001000;
assign HEX3 = 7'b0001100;
assign HEX2 = 7'b0001100;
assign HEX1 = 7'b0010001;
assign HEX0 = 7'b1111111;
assign HEX6 = 7'b1111111;
assign HEX7 = 7'b1111111;*/
assign LEDR = 18'b111111111111111111;
assign LEDG = 8'b11111111;
assign HEX7 = 7'b1000000;
assign HEX6 = 7'b1001111;
assign HEX5 = 7'b1000011;
assign HEX4 = 7'b1100001;
assign HEX3 = 7'b0001000;
assign HEX2 = 7'b1000111;
assign HEX1 = 7'b1001111;
assign HEX0 = 7'b1111111;
endmodule
