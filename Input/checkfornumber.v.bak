module test2 (CLOCK_50, KEY, PS2_CLK, PS2_DAT, HEX2, HEX3, store_the_firstletter, store_the_number_first);
input				CLOCK_50;
input		   [0:0]	KEY;
output		[6:0]	HEX2;
output		[6:0]	HEX3;
reg       	[32:0]counter;
wire     [7:0]store_the_number_first;
reg		[7:0]hex_make_code_numbers_first;
wire     [7:0]store_hex_make_code_numbers_first;
wire     [7:0]store_the_firstletter;
wire		[7:0]	ps2_key_data1;
wire				ps2_key_pressed1;

always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		hex_make_code_numbers_first <= 8'h00;
	else if (ps2_key_pressed1 == 1'b1)
		begin 
			hex_make_code_numbers_first <= ps2_key_data1;
		end
		
end

always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		hex_make_code_firstletter <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		begin 
			hex_make_code_firstletter <= ps2_key_data;
		end
		
end
assign store_hex_make_code_numbers_first = hex_make_code_numbers_first;
testfornumbersfirst callfornumbers_first(store_hex_make_code_numbers_first,store_the_number_first);

always @ (posedge CLOCK_50)
begin
	counter <= counter + 1;
		case (store_the_firstletter) //which direction?
			8'b1: //F
				begin
					if (counter < store_the_number_first*500000000)// && store_the_secondletter == 8'b100)//50,000,000 CC = 1 se
						LEDG[1] <= 1;
					else
							LEDG[1] <= 0;
				end	
		endcase
end
	

PS2_Controller PS21 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data1),
	.received_data_en	(ps2_key_pressed1)
);
Hexadecimal_To_Seven_Segment Segment1 (
	// Inputs
	.hex_number			(hex_make_code_numbers_first[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX2)
);

Hexadecimal_To_Seven_Segment Segment5 (
	// Inputs
	.hex_number			(hex_make_code_numbers_first[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX3)
);
endmodule 