module checkforletter (CLOCK_50, KEY, PS2_CLK, PS2_DAT,HEX0,HEX1, store_the_firstletter);

input				CLOCK_50;
input		[0:0]	KEY;
inout				PS2_CLK;
inout				PS2_DAT;
output		[6:0]	HEX0;
output		[6:0]	HEX1;
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;
reg      [7:0] hex_make_code_firstletter;
wire     [7:0]store_hex_make_code_firstletter;
output     [7:0]store_the_firstletter;
always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		hex_make_code_firstletter <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		begin 
			hex_make_code_firstletter <= ps2_key_data;
		end
		
end

assign store_hex_make_code_firstletter = hex_make_code_firstletter;
testforletters callforlettersfirst(store_hex_make_code_firstletter,store_the_firstletter);

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
	.seven_seg_display	(HEX0)
);
Hexadecimal_To_Seven_Segment Segment8 (
	// Inputs
	.hex_number			(hex_make_code_firstletter[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX2)
	);
endmodule 