
module  hexexample( //PS2_Demo
	// Inputs
	CLOCK_50,
	KEY, LEDG, LEDR,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
	GPIO_0,
	
	// Outputs
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,
	
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input				CLOCK_50;
input		[3:0]	KEY;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

output [0:0] LEDG;


// Outputs
output		[6:0]	HEX0;
output		[6:0]	HEX1;
output		[6:0]	HEX2;
output		[6:0]	HEX3;
output		[6:0]	HEX4;
output		[6:0]	HEX5;
output		[6:0]	HEX6;
output		[6:0]	HEX7;
output 	   reg[7:0] LEDR;
output reg [5:0]GPIO_0;
/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;

// Internal Registers
reg			[7:0]	last_data_received;

integer  j =0;
reg [32:0]i;

parameter cw = 2'b01, ccw = 2'b10, stop = 2'b0;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		last_data_received <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		begin 
			last_data_received <= ps2_key_data;
		end
		
end

always @ (posedge CLOCK_50)
begin
		i <= i + 1;
		if (i > 2600000000)
		begin
			LEDR[4] <= 0; 
			LEDR[1] <= 0;
			LEDR[2] <= 0;
			LEDR[3] <= 0;
			GPIO_0[0] <= 0;//enable for motor 1
			GPIO_0[5] <= 0;//enable for motor 2
			i<=0;
			j = j+1;
		end
		
		else if (i < 2600000000 && j == 0) //16 and 8 zeroes
			begin 
				case(last_data_received)
					8'h23:	//D
						begin
							if (i < 500000000)//forward
								begin
									LEDR[1] <= 1; //turn on LEDR[0] for 10 second
									GPIO_0[0] <= 1;//enable for motor 1
									GPIO_0[2] <= 1;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 1;//for moving the motor 2 clockwise
									GPIO_0[5] <= 1;//enable for motor 2
								end
								
							else if (i > 500000000 && i < 700000000) // left -> left motor must be turning cw
								begin
									LEDR[1] <= 0;
									GPIO_0[0] <= 1;//enable for motor 1
									GPIO_0[2] <= 1;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 0;//for moving the motor 2 clockwise
									GPIO_0[5] <= 0;//enable for motor 2
								end
							
							else if (i > 700000000 && i < 1200000000) // on for 10 seconds
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 1;
									GPIO_0[0] <= 1;//enable for motor 1
									GPIO_0[2] <= 1;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 1;//for moving the motor 2 clockwise
									GPIO_0[5] <= 1;//enable for motor 2
								end
				
							else if (i > 1200000000 && i < 1400000000) //off for 4 seconds
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									GPIO_0[0] <= 0;//enable for motor 1
									GPIO_0[2] <= 0;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 1;//for moving the motor 2 clockwise
									GPIO_0[5] <= 1;//enable for motor 2
								end

							else if (i > 1400000000 && i < 1900000000)//on for 10
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									LEDR[3] <= 1;
									GPIO_0[0] <= 1;//enable for motor 1
									GPIO_0[2] <= 1;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 1;//for moving the motor 2 clockwise
									GPIO_0[5] <= 1;//enable for motor 2
								end
								
							else if (i > 1900000000 && i < 2100000000)//off for 4
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									LEDR[3] <= 0;
									GPIO_0[0] <= 1;//enable for motor 1
									GPIO_0[2] <= 1;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 0;//for moving the motor 2 clockwise
									GPIO_0[5] <= 0;//enable for motor 2
								end

							else if (i > 2100000000 && i < 2600000000)//on for 10
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									LEDR[3] <= 0;
									LEDR[4] <= 1;
									GPIO_0[0] <= 1;//enable for motor 1
									GPIO_0[2] <= 1;//for moving the motor 1 clockwise
									GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
									GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
									GPIO_0[3] <= 1;//for moving the motor 2 clockwise
									GPIO_0[5] <= 1;//enable for motor 2
								end
						end
				endcase
			end
end
/*
always @ (posedge CLOCK_50)
begin
		i = i + 1;
		if (i > 2600000000)
		begin
			LEDR[4] <= 0; 
			LEDR[1] <= 0;
			LEDR[2] <= 0;
			LEDR[3] <= 0;
			i=0;
			j = j+1;
		end
		
		else if (i < 2600000000 && j == 0) //16 and 8 zeroes
			begin 
				case(last_data_received)
					8'h23:	//D
						begin
							if (i < 500000000)
								LEDR[1] <= 1; //turn on LEDR[0] for 10 second
							
							else if (i > 500000000 && i < 700000000) // off
								begin
									LEDR[1] <= 0;
								end
							
							else if (i > 700000000 && i < 1200000000) // on for 10 seconds
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 1;
								end
				
							else if (i > 1200000000 && i < 1400000000) //off for 4 seconds
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
								end

							else if (i > 1400000000 && i < 1900000000)//on for 10
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									LEDR[3] <= 1;
								end
								
							else if (i > 1900000000 && i < 2100000000)//off for 4
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									LEDR[3] <= 0;
								end

							else if (i > 2100000000 && i < 2600000000)//on for 10
								begin
									LEDR[1] <= 0;
									LEDR[2] <= 0;
									LEDR[3] <= 0;
									LEDR[4] <= 1;
								end
						end
				endcase
			end
end
*/
/*8'h4B: //L
						begin
							LEDR[1] <= 1'b1;
						end
	
					8'h2D: //R
						begin
							LEDR[2] <= 1'b1;
						end
					
					8'h1B: //S
						begin
							LEDR[3] <= 1'b1;
						end*/
/*always @ (posedge CLOCK_50)
begin
		i = i + 1;
		if (i > 25000000) 
		begin
			LEDR[1] <= 0;
			LEDR[2] <= 0;
			i = 0;
		end
		
		else if (i < 25000000 )
			begin 
				case(last_data_received)
					8'h1D: //W
						begin
							LEDR[1] <= 1; //
						end
	
					8'h2B: //F
						begin
							LEDR[2] <= 1;
						end
				endcase
			end
end*/

/*always @ (last_data_received)
begin
			if (last_data_received==8'h15) //Q
					LEDR[0]= 1'b1;
			else if (last_data_received==8'h1D) //W 
					LEDR[1]=1'b1;
			else if (last_data_received == 8'b00100100)//E
					LEDR[2]=1'b1;
end*/

/*always @ (last_data_received)
if(last_data_received == 8'h15)
LEDR[0]<=1;
else LEDR[1]<=1;*/

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

assign HEX2 = 7'h7F;
assign HEX3 = 7'h7F;
assign HEX4 = 7'h7F;
assign HEX5 = 7'h7F;
assign HEX6 = 7'h7F;
assign HEX7 = 7'h7F;


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

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
//assign LEDR = last_data_received;
Hexadecimal_To_Seven_Segment Segment0 (
	// Inputs
	.hex_number			(last_data_received[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX0)
);

Hexadecimal_To_Seven_Segment Segment1 (
	// Inputs
	.hex_number			(last_data_received[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX1)
);


endmodule


module Hexadecimal_To_Seven_Segment (
	// Inputs
	hex_number,

	// Bidirectional

	// Outputs
	seven_seg_display
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input		[3:0]	hex_number;

// Bidirectional

// Outputs
output		[6:0]	seven_seg_display;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires

// Internal Registers

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/


/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

assign seven_seg_display =
		({7{(hex_number == 4'h0)}} & 7'b1000000) |
		({7{(hex_number == 4'h1)}} & 7'b1111001) |
		({7{(hex_number == 4'h2)}} & 7'b0100100) |
		({7{(hex_number == 4'h3)}} & 7'b0110000) |
		({7{(hex_number == 4'h4)}} & 7'b0011001) |
		({7{(hex_number == 4'h5)}} & 7'b0010010) |
		({7{(hex_number == 4'h6)}} & 7'b0000010) |
		({7{(hex_number == 4'h7)}} & 7'b1111000) |
		({7{(hex_number == 4'h8)}} & 7'b0000000) |
		({7{(hex_number == 4'h9)}} & 7'b0010000) |
		({7{(hex_number == 4'hA)}} & 7'b0001000) |
		({7{(hex_number == 4'hB)}} & 7'b0000011) |
		({7{(hex_number == 4'hC)}} & 7'b1000110) |
		({7{(hex_number == 4'hD)}} & 7'b0100001) |
		({7{(hex_number == 4'hE)}} & 7'b0000110) |
		({7{(hex_number == 4'hF)}} & 7'b0001110); 

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

