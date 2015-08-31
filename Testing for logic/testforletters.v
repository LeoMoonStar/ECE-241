module testforletters(hex_make_code,the_letter);
input [7:0] hex_make_code;
output reg[7:0] the_letter;
always @ (hex_make_code)
		begin
			if (hex_make_code == 8'h2B)
				the_letter <= 8'b001; ///F
			else if (hex_make_code == 8'h4B)
				 the_letter <= 8'b010; //L
			else if (hex_make_code == 8'h2D)
				the_letter <= 8'b011; //R
			else if (hex_make_code == 8'h23)
				the_letter<=8'b100;//D
			else
				 the_letter <= 8'b0;//8'b0 0
		end
endmodule 