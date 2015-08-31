module LogicTesting(
	CLOCK_50,
	KEY,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,
);
input				CLOCK_50;
input		   [0:0]	KEY;
output		[6:0]	HEX0;
output		[6:0]	HEX1;
output		[6:0]	HEX2;
output		[6:0]	HEX3;
output		[6:0]	HEX4;
output		[6:0]	HEX5;
output		[6:0]	HEX6;
output		[6:0]	HEX7;

wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;
reg      [7:0] hex_make_code_lastletter;
wire     [7:0]store_hex_make_code_lastletter;
wire     [7:0]store_the_lastletter;
wire     [7:0]store_the_firstletter;
wire     [7:0]store_the_number_first;
always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		hex_make_code_lastletter <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		begin 
			hex_make_code_lastletter <= ps2_key_data;
		end
		
end

assign store_hex_make_code_lastletter = hex_make_code_lastletter;
testforletters callforletterslast(store_hex_make_code_lastletter,store_the_lastletter);

always @ (posedge CLOCK_50)
begin
		case (store_the_lastletter)
			8'b100: //D
				begin
				checkforinput firstletter(CLOCK_50, KEY, PS2_CLK, PS2_DAT,HEX0,HEX1, store_the_firstletter);
				test2 firstnumber(CLOCK_50, KEY, PS2_CLK, PS2_DAT, HEX2, HEX3, store_the_firstletter, store_the_number_first);
				end	
		endcase
end
	
PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);


Hexadecimal_To_Seven_Segment Segment0 (
	// Inputs
	.hex_number			(hex_make_code_firstletter[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX4)
);

Hexadecimal_To_Seven_Segment Segment4 (
	// Inputs
	.hex_number			(hex_make_code_firstletter[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX5)
);
endmodule 