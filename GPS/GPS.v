
module GPS( //PS2_Demo
	// Inputs
	CLOCK_50,
	KEY, LEDG, LEDR, SW,

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
	VGA_CLK,   						//	VGA Clock
	VGA_HS,							//	VGA H_SYNC
	VGA_VS,							//	VGA V_SYNC
	VGA_BLANK,						//	VGA BLANK
	VGA_SYNC,						//	VGA SYNC
	VGA_R,   						//	VGA Red[9:0]
	VGA_G,	 						//	VGA Green[9:0]
	VGA_B	 
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input    [7:0]SW;
input				CLOCK_50;
input		[3:0]	KEY;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

output reg [7:0] LEDG;

wire enable;
assign enable = KEY[1];
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
integer  k =0;
reg [32:0]l;
integer  n =0;
reg [32:0]m;
integer  p =0;
reg [32:0]o;
integer  r =0;
reg [32:0]q;
integer  t =0;
reg [32:0]s;
integer  u =0;
reg [32:0]y;
integer  w =0;
reg [32:0]v;
integer  z =0;
reg [32:0]x;
integer  b =0;
reg [32:0]a;
// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/
background image
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[0:0]
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B	  						//	VGA Blue[9:0]
	);
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK;				//	VGA BLANK
	output	VGA_SYNC;				//	VGA SYNC
	output	[9:0] VGA_R;   			//	VGA Red[9:0]
	output	[9:0] VGA_G;	 		//	VGA Green[9:0]
	output	[9:0] VGA_B;  
	
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
			case(last_data_received)
					8'h2D: //R 
						begin
							i <= i + 1;
								if (i > 125000000)
									begin
										LEDR[0] <= 0;
										LEDR[1] <= 0;
										GPIO_0[0] <= 0;//enable for motor 1
										GPIO_0[5] <= 0;//enable for motor 2
										i <= 0;
										j = j +1;
									end
								else if (i < 125000000 && j == 0) //15 move forward
									begin 
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[1] <= 1; 
												LEDR[0] <= 1;
									end
						end
					8'h33:     //H
							begin
							l <= l + 1;
								if (l > 525000000)
									begin
										LEDG[0] <= 0;
										LEDG[1] <= 0;
										GPIO_0[0] <= 0;//enable for motor 1
										GPIO_0[5] <= 0;//enable for motor 2
										l <= 0;
										k = k +1;
									end
								else if (l < 200000000 && k == 0) // uturn
									begin 
												GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDG[1] <= 0; 
												LEDG[0] <= 1;
									end
								else if (l > 200000000 && l < 325000000 && k == 0) // move forward
									begin
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDG[1] <= 1; 
												LEDG[0] <= 1;
									end
									else if (l > 325000000 && l < 525000000 && k == 0) // u turn
									begin
												GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDG[1] <= 1; 
												LEDG[0] <= 0;
									end
						end
					8'h3A:        //M
							begin
							m <= m + 1;
								if (m > 350000000)
									begin
										LEDR[0] <= 0;
										LEDR[1] <= 0;
										GPIO_0[0] <= 0;//enable for motor 1
										GPIO_0[5] <= 0;//enable for motor 2
										m <= 0;
										n = n +1;
									end
								else if (m < 25000000 && n == 0) //move forward
									begin
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[1] <= 1; 
												LEDR[0] <= 1;
									end
									
									else if (m > 25000000 && m < 125000000 && n == 0) //TURN left
									begin 
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 0;//for moving the motor 2 clockwise
												GPIO_0[5] <= 0;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
									end
									
								else if (m > 125000000 && n == 0 && m < 200000000 ) //move forward 
									begin 
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[1] <= 1; 
												LEDR[0] <= 1;
									end
								
								else if (m > 200000000 && n == 0 && m < 300000000 ) //right
									begin 
												GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
									end
									else if (m > 300000000 && n == 0 && m < 350000000) //forward
									begin 
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[1] <= 1; 
												LEDR[0] <= 1;
									end
								
							end
				
					8'h31:        //N
							begin
							o <= o + 1;
								if (o > 750000000)
									begin
										LEDR[0] <= 0;
										LEDR[1] <= 0;
										GPIO_0[0] <= 0;//enable for motor 1
										GPIO_0[5] <= 0;//enable for motor 2
										o <= 0;
										p = p +1;
									end
								else if (p == 0 && o < 200000000) //uturn
									begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 0;//for moving the motor 2 clockwise
											GPIO_0[5] <= 0;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 0;
									end
								
								else if (o > 200000000 && p == 0 && o < 250000000 )//forward
									begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
									end
								
								else if (o > 250000000 && p == 0 && o < 350000000) //left
									begin 
											GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 0;//for moving the motor 2 clockwise
												GPIO_0[5] <= 0;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
									end
									
								else if (o > 350000000 && p == 0 && o < 425000000 ) //move forward
									begin 
									      GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
									end
								else if (o > 425000000 && p == 0 && o < 525000000) //move right
									begin 
												GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
									end
								else if (o > 525000000 && p == 0 &&  o < 550000000) //move forward
									begin 
									      GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
									end
								else if (o > 550000000 && p == 0 && o < 750000000) //u turn
									begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 0;//for moving the motor 2 clockwise
											GPIO_0[5] <= 0;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 0;
									end
							end
				
						8'h1B: //S
								
								begin
									q <= q + 1; //q and r
								if (q > 500000000)
									begin
										LEDR[0] <= 0;
										LEDR[1] <= 0;
										GPIO_0[0] <= 0;//enable for motor 1
										GPIO_0[5] <= 0;//enable for motor 2
										q <= 0;
										r = r +1;
									end
								else if (r == 0 && q < 200000000)//u turn
										begin 
										   GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 0;//for moving the motor 2 clockwise
											GPIO_0[5] <= 0;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 0;
										end
								
								
									else if (q > 200000000 && r == 0 && q < 325000000 ) //forward
										begin
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
										end
								
									else if (q > 325000000 && r == 0 && q < 425000000)//left
										begin 
										  GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 0;//for moving the motor 2 clockwise
												GPIO_0[5] <= 0;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
										end
									else if (q > 425000000 && r == 0 && q < 500000000)//forward
										begin 
										  GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
										end					
								
								end
									
						8'h2C: // T
								begin
									s <= s + 1;
									if (s > 500000000)
									begin
										LEDR[0] <= 0;
										LEDR[1] <= 0;
										GPIO_0[0] <= 0;//enable for motor 1
										GPIO_0[5] <= 0;//enable for motor 2
										s <= 0;
										t = t +1;
									end
							
									else if ( t == 0 && s < 200000000) //uturn
									begin
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 0;//for moving the motor 2 clockwise
											GPIO_0[5] <= 0;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 0;
									end
								
									else if (s > 200000000 && t == 0 && s < 275000000)//forward
										begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
										end	
									
									else if (s > 275000000 && t == 0 && s < 375000000 ) //right 
										begin 
												GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
										end
									
									else if (s > 375000000 && t == 0 && s < 500000000)//forward
										begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
										end
								end
							
							8'h3B: //J
									begin
										y <= y + 1;
											if (y > 625000000)
												begin
													LEDR[0] <= 0;
													LEDR[1] <= 0;
													GPIO_0[0] <= 0;//enable for motor 1
													GPIO_0[5] <= 0;//enable for motor 2
													y <= 0;
													u = u +1;
												end
											else if (u == 0 && y < 200000000)//uturn
												begin 
													GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDG[1] <= 0; 
												LEDG[0] <= 1;
												end
												
											else if (y > 200000000 && u == 0 && y < 250000000 ) //forward 
												begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
												
											else if (y > 250000000 && u == 0 && y < 350000000)//right
												begin 
													GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
											
											else if (y > 350000000 && u == 0 && y < 450000000)//forward
												begin
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
											
											else if (y > 450000000 && u == 0 && y < 550000000)//left
												begin 
													GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 0;//for moving the motor 2 clockwise
												GPIO_0[5] <= 0;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
											else if (y > 550000000 && u == 0 && y < 625000000)//forward
												begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
										end
								8'h43: // I
										begin
											v <= v + 1;
											if (v > 625000000)
												begin
													LEDR[0] <= 0;
													LEDR[1] <= 0;
													GPIO_0[0] <= 0;//enable for motor 1
													GPIO_0[5] <= 0;//enable for motor 2
													v <= 0;
													w = w + 1;
												end
												if (w == 0 && v < 200000000) //uturn
													begin
														GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDG[1] <= 0; 
												LEDG[0] <= 1;
													end
													
												else if (v > 200000000 && w == 0 && v < 275000000)//forward
													begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
													end
												
												else if (v > 275000000 && w == 0 && v < 375000000)//right
												begin
													GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
												
												else if (v > 375000000 && w == 0 && v < 475000000)//forward
													begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
													end
													
												else if (v > 475000000 && w == 0 && v < 575000000)//left
												begin
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 0;//for moving the motor 2 clockwise
												GPIO_0[5] <= 0;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
												
												else if (v > 575000000 && w == 0 && v < 625000000)//forward
													begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
													end
											end
								8'h1C: //A
									begin
										x <= x + 1;
											if (x > 200000000)
												begin
													LEDR[0] <= 0;
													LEDR[1] <= 0;
													GPIO_0[0] <= 0;//enable for motor 1
													GPIO_0[5] <= 0;//enable for motor 2
													x <= 0;
													z = z +1;
												end
											else if (x < 25000000 && z == 0) //forward
												begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
											else if (x > 25000000 && z == 0 && x < 125000000) //right
												begin 
													GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
											else if (x < 125000000 && z == 0 && x < 200000000) //forward
												begin 
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
									end
								8'h32: //B
									begin
										a <= a + 1;
											if (a > 600000000)
												begin
													LEDG[0] <= 0;
													LEDG[1] <= 0;
													GPIO_0[0] <= 0;//enable for motor 1
													GPIO_0[5] <= 0;//enable for motor 2
													a <= 0;
													b = b +1;
												end
											else if (a < 200000000 && b == 0) //u turn 
												begin 
													GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDG[1] <= 0; 
												LEDG[0] <= 1;
												end
											else if (a > 200000000 && a < 275000000 && b == 0) // forward
												begin
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
											else if (a > 275000000 && a < 375000000 && b == 0) // right
												begin
													GPIO_0[0] <= 0;//enable for motor 1
												GPIO_0[2] <= 0;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 1;//for moving the motor 2 clockwise
												GPIO_0[5] <= 1;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
											else if (a > 375000000 && a < 475000000 && b == 0) // forward
												begin
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
											else if (a > 475000000 && a < 575000000 && b == 0) // left
												begin
												GPIO_0[0] <= 1;//enable for motor 1
												GPIO_0[2] <= 1;//for moving the motor 1 clockwise
												GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
												GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
												GPIO_0[3] <= 0;//for moving the motor 2 clockwise
												GPIO_0[5] <= 0;//enable for motor 2
												LEDR[0] <= 0; 
												LEDR[1] <= 1;
												end
											else if (a > 575000000 && a < 625000000 && b == 0) // forward
												begin
											GPIO_0[0] <= 1;//enable for motor 1
											GPIO_0[2] <= 1;//for moving the motor 1 clockwise
											GPIO_0[4] <= 0;//for moving the motor 1 anti clockwise 
											GPIO_0[1] <= 0;//for moving the motor 2 anti clockwise
											GPIO_0[3] <= 1;//for moving the motor 2 clockwise
											GPIO_0[5] <= 1;//enable for motor 2
											LEDR[0] <= 1; 
											LEDR[1] <= 1;
												end
								end	
				endcase
end


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


