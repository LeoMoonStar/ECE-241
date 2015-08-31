// Etch-and-sketch

module sketch
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[3:0]
		SW,								//	DPDT Switch[17:0]
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input	[1:0]	KEY;					//	Button[3:0]
	input	[17:0]	SW;						//	Switches[0:0]
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	
	// Create the color, x, y and writeEn wires that are inputs to the controller.
	wire clock;
	assign clock = CLOCK_50;
	wire [2:0] color;
	wire [7:0] x;
	wire [7:0] wir_x;
	wire [6:0] wir_y;
	wire [6:0] y;
	wire writeEn;
	assign resetn = KEY[0];
	//mux2to1 casecolor(resetn, SW, clock, color);
	assign x = SW[7:0];
	assign y = SW[14:8];
	assign WriteEn = KEY[1];
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color),
			.x(wir_x),
			.y(wir_y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "display.mif";
		square case1(x,y,clock, wir_x, wir_y);
		endmodule
		
		module mux2to1(input resetn, clock, input [17:15]SW, output reg[2:0]color);
		always@(posedge clock)
		begin
/*			if(~resetn)
				color = 3'b0;
			else
				color = SW[17:15];
*/		end
		endmodule
		
		module square (input [7:0]x,input [6:0]y, input clock, output [7:0] wir_x, output [6:0] wir_y);
		reg [2:0] countx = 3'b000; 
		reg [2:0] county = 3'b000;  
		
		always@ (posedge clock)
			begin
			if(countx == 3'b101)						
				countx <= 3'b000;
			else
				countx <=  countx + 1;
			end
			
		always@ (posedge clock)
			begin
			if(county == 3'b101)
				county <= 3'b000;
			else if(countx == 3'b101)
				county <= county + 1;
			end
		 
		 assign wir_x = x+countx;
		 assign wir_y = y+county;
		 
endmodule 
