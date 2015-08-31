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
		VGA_B   						   //	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;					//	Button[3:0]
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
	assign resetn = KEY[3];
	reg [7:0]X;
   reg [6:0]Y;

	// Create the color, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] color;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	//assign writeEn=KEY[1]; 
	
	assign color=SW[17:15];
	assign x=X;
	assign y=Y;
	
	parameter A=5'b00000,B=5'b00001,C=5'b00010,D=5'b00011,E=5'b00100,F=5'b00101,G=5'b00110,
          H=5'b00111,I=5'b01000,J=5'b01001,K=5'b01010,L=5'b01011,M=5'b01100,N=5'b01101,
			 O=5'b01110,P=5'b01111,Q=5'b10000,R=5'b10001,S=5'b10010,TS=5'b10011,U=5'b10100,
			 V=5'b10101,W=5'b10110,XS=5'b10111,YS=5'b11000,Z=5'b11001,RESET=5'b11001;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color),
			.x(x),
			.y(y),
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
			
reg enbl;
assign writeEn = enbl;
			 
reg [4:0]Ttemp,t,T;
always @(posedge CLOCK_50)
begin
enbl = 1;
	case(t)
	   A: begin
		  if(~KEY[1]) T=B;
		  else T=A;
		  end
		B: begin
			 X=SW[7:0];
	       Y=SW[14:8];
			 T=C;
			 end
	   C: begin
		    X=SW[7:0]+3'b001; 
			 Y=SW[14:8]; 
			 T=D;
			 end
		D: begin
		    X=SW[7:0]+3'b010; 
			 Y=SW[14:8]; 
			 T=E;
			 end
	   E: begin
		    X=SW[7:0]+3'b011; 
			 Y=SW[14:8]; 
			 T=F;
			 end
		F: begin
		    X=SW[7:0]+3'b100; 
			 Y=SW[14:8]; 
			 T=G;
			 end
		G: begin
			 X=SW[7:0];
	       Y=SW[14:8]+3'b001;
			 T=H;
			 end
	   H: begin
		    X=SW[7:0]+3'b001; 
			 Y=SW[14:8]+3'b001; 
			 T=I;
			 end
		I: begin
		    X=SW[7:0]+3'b010; 
			 Y=SW[14:8]+3'b001; 
			 T=J;
			 end
	   J: begin
		    X=SW[7:0]+3'b011; 
			 Y=SW[14:8]+3'b001; 
			 T=K;
			 end
		K: begin
		    X=SW[7:0]+3'b100; 
			 Y=SW[14:8]+3'b001; 
			 T=L;
			 end
		L: begin
			 X=SW[7:0];
	       Y=SW[14:8]+3'b010;
			 T=M;
			 end
	   M: begin
		    X=SW[7:0]+3'b001; 
			 Y=SW[14:8]+3'b010; 
			 T=N;
			 end
		N: begin
		    X=SW[7:0]+3'b010; 
			 Y=SW[14:8]+3'b010; 
			 T=O;
			 end
	   O: begin
		    X=SW[7:0]+3'b011; 
			 Y=SW[14:8]+3'b010; 
			 T=P;
			 end
		P: begin
		    X=SW[7:0]+3'b100; 
			 Y=SW[14:8]+3'b010; 
			 T=Q;
			 end
		Q: begin
			 X=SW[7:0];
	       Y=SW[14:8]+3'b011;
			 T=R;
			 end
	   R: begin
		    X=SW[7:0]+3'b001; 
			 Y=SW[14:8]+3'b011; 
			 T=S;
			 end
		S: begin
		    X=SW[7:0]+3'b010; 
			 Y=SW[14:8]+3'b011; 
			 T=TS;
			 end
	   TS: begin
		    X=SW[7:0]+3'b011; 
			 Y=SW[14:8]+3'b011; 
			 T=U;
			 end
		U: begin
		    X=SW[7:0]+3'b100; 
			 Y=SW[14:8]+3'b011; 
			 T=V;
			 end
		V: begin
			 X=SW[7:0];
	       Y=SW[14:8]+3'b100;
			 T=W;
			 end
	   W: begin
		    X=SW[7:0]+3'b001; 
			 Y=SW[14:8]+3'b100; 
			 T=XS;
			 end
		XS: begin
		    X=SW[7:0]+3'b010; 
			 Y=SW[14:8]+3'b100; 
			 T=YS;
			 end
	   YS: begin
		    X=SW[7:0]+3'b011; 
			 Y=SW[14:8]+3'b100; 
			 T=Z;
			 end
		Z: begin
		    X=SW[7:0]+3'b100; 
			 Y=SW[14:8]+3'b100; 
			 T=A;
			 end
			 endcase 
          end	
 always @ (posedge CLOCK_50)
	begin
		if(KEY[0] == 0) t <= A;
		else t <= T;
	end
endmodule
