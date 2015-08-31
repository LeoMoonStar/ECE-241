//VGA Controller
//xcounter and ycounter are pixel position currently drawn (when displayen is high)
//vsync and hsync outputs are active HIGH here (need to invert later)

module Crtc(
	input resetn,
	input vclk, 
	output reg [9:0] xcounter, 
	output reg [9:0] ycounter, 
	output displayen, 
	output reg hsync, 
	output reg vsync,
	output bufferSwap);

	wire xcounter_clear, ycounter_clear;
	
	//Timing information
	parameter C_VERT_NUM_PIXELS  = 10'd480;
	parameter C_VERT_SYNC_START  = 10'd493;
	parameter C_VERT_SYNC_END    = 10'd494; //(C_VERT_SYNC_START + 2 - 1); 
	parameter C_VERT_TOTAL_COUNT = 10'd525;

	parameter C_HORZ_NUM_PIXELS  = 10'd640;
	parameter C_HORZ_SYNC_START  = 10'd659;
	parameter C_HORZ_SYNC_END    = 10'd754; //(C_HORZ_SYNC_START + 96 - 1); 
	parameter C_HORZ_TOTAL_COUNT = 10'd800;

	
	//--- Horizontal Counter
	assign xcounter_clear = (xcounter == (C_HORZ_TOTAL_COUNT-1));

	always @(posedge vclk or negedge resetn)
	begin
		if (!resetn)
			xcounter <= 10'd0;
		else if (xcounter_clear)
			xcounter <= 10'd0;
		else
			xcounter <= xcounter + 1'b1;
	end


	//--- Vertical Counter
	assign ycounter_clear = (ycounter == (C_VERT_TOTAL_COUNT-1)); 

	always @(posedge vclk or negedge resetn)
	begin
		if (!resetn)
			ycounter <= 10'd0;
		else if (xcounter_clear && ycounter_clear)
			ycounter <= 10'd0;
		else if (xcounter_clear)		//Increment when x counter resets
			ycounter <= ycounter + 1'b1;
	end


	//--- Sync Generator (ACTIVE LOW)
	always @(posedge vclk)
	begin
		hsync <= ~((xcounter >= C_HORZ_SYNC_START) && (xcounter <= C_HORZ_SYNC_END));
		vsync <= ~((ycounter >= C_VERT_SYNC_START) && (ycounter <= C_VERT_SYNC_END));
	end


	//--- Current X and Y is valid pixel range
	assign displayen = ((xcounter < C_HORZ_NUM_PIXELS) && (ycounter < C_VERT_NUM_PIXELS));

	//Swap buffers at end of line
	assign bufferSwap = ((xcounter == C_HORZ_NUM_PIXELS) && (ycounter < C_VERT_NUM_PIXELS));

endmodule
