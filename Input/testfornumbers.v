module testfornumbersfirst(hex_make_code,the_number);
input [7:0] hex_make_code;
output reg[7:0] the_number;

always @ (hex_make_code) 
		begin
			if (hex_make_code == 8'h16 || hex_make_code == 8'h69)//1
				the_number <= 8'b1; ///1
			else if (hex_make_code == 8'h72 || hex_make_code == 8'h1E)
				 the_number <= 8'b10; //8'b10 2
			else if (hex_make_code == 8'h26 || hex_make_code == 8'h7A)
				the_number <= 8'b11; //8'b11 3
			else if (hex_make_code == 8'h25 || hex_make_code == 8'h6B)
				 the_number <= 8'b100;//8'b100 4
			else if (hex_make_code == 8'h2E || hex_make_code == 8'h73)
				 the_number <= 8'b101;//8'b101 5
			else if (hex_make_code == 8'h36 || hex_make_code == 8'h74)
				 the_number <= 8'b110;//8'b110 6
			else if (hex_make_code == 8'h3D || hex_make_code == 8'h6C)
				 the_number <= 8'b111;//8'b111 7
			else if (hex_make_code == 8'h3E || hex_make_code == 8'h75)
				 the_number <= 8'b1000;//8'b1000 8
			else if (hex_make_code == 8'h46 || hex_make_code == 8'h7D)
				 the_number <= 8'b1001;//8'b1001 9
			else
				 the_number <= 8'b0;//8'b0 0
		end
		
	endmodule 
	
	
	
	
	
	
	
	