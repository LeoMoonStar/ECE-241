module DisplayExample(
	input resetn,
	input clk, 
	output reg [15:0] color,
	output reg [9:0] x,
	output reg [8:0] y,
	output reg write,
	input done,
	input testing);
	
	reg [17:0] slowCount;
	
	
	//--- pixel counters
	wire xClear, yClear;
	reg  xCount;
	
	assign xClear = (x == 10'd639);

	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			x <= 10'd0;
		else if (xCount)
		begin
			if (xClear)	x <= 10'd0;
			else		x <= x + 1'b1;
		end
	end
	
	
	assign yClear = (y == 10'd479);

	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			y <= 9'd0;
		else if (xCount)
		begin
			if (xClear && yClear)	y <= 9'd0; //New frame
			else if (xClear)		y <= y + 1'b1;
		end
	end


	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			slowCount <= 18'd0;
		else if (xCount)
		begin
			if (xClear && yClear)	slowCount <= slowCount + 1'b1; //New frame
		end
	end


	//--- Color generator
	always @(posedge clk) //must be registered - results in errors without it (why???)
	begin
		/*
		color[4:0] <= (x[6:2] ^ y[6:2]) ^ (slowCount[7:3]);
		color[9:5] <= (x[7:3] ^ y[7:3]) ^ (slowCount[7:3]);
		color[14:10] <= (x[8:4] ^ y[8:4]) ^ (slowCount[7:3]);
		color[15] <= 1'b0;
		*/

		//color[15:0] <= {6'b0,  ((x[9:0] == 10'd0) | ((x[9:0] > 10'd254) & (x[9:0] < 10'd258)) | ((x[9:0] > 10'd510) & (x[9:0] < 10'd514))) & (y[8:0] == 9'd100) ,9'b0};
		//color[15:0] <= {6'b0,  (x[9:0] == 10'd638), 9'b0};

		color[15:0] <= {6'b0, ((y[8:0] == slowCount[9:1]) || (x[9:0] == slowCount[10:1])), 9'b0};

		//color[15:0] <= {6'b0,  ((x[9:0] == 10'd638) || (x[9:0] == 10'd0) || (y[8:0] == 9'd479) || (y[8:0] == 9'd0)), 9'b0};

		//color[15:0] <= {6'b0,  ((x[9:0] == 10'd639) || (x[9:0] == 10'd0) || (y[8:0] == 9'd0) || (y[8:0] == 9'd479)), 9'b0};

		/*
		color[4:0] <= x[9:5];
		color[9:5] <= y[8:4];
		color[14:10] <= x[6:2] ^ y[6:2];
		color[15] <= 1'b0;
		*/
		
		//color[15:0] <= 16'b0000001111100000;
		//color[15:0] <= {x[9:0],y[5:0]};
		//color[15:0] <= {y[7:0],y[7:0]};
		//color[15:0] <= {6'b0,y[8:8],9'b0};
		//color[15:0] <= {6'b0,x[9:9],9'b0};
	end
	

	
	//--- Write state machine (full handshaking)
	parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;
	
	reg [1:0] s, S;
	
	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			s <= S0;
		else
			s <= S;
	end
	
	always @(s or done or testing)
	begin
		case (s)
			S0: //Increment counter
			begin
				write <= 1'b0;
				xCount <= 1'b1;
				
				if (testing)
					S <= S1;
				else 
					S <= S0;
			end
			
			S1: //Wait - results in errors without it (why???)
			begin
				write <= 1'b0;
				xCount <= 1'b0;
				S <= S2;
			end
			
			S2: //request write and wait for acknowledgement
			begin
				write <= 1'b1; 
				xCount <= 1'b0;
				
				if (done == 1'b1)	S <= S2;
				else				S <= S3;
			end
			
			S3: //Wait for it to finish after writing
			begin
				write <= 1'b0;
				xCount <= 1'b0;
				
				if (done == 1'b0)	S <= S3; 
				else				S <= S0;
			end	
		
			default:
			begin
				write <= 1'bx;
				xCount <= 1'bx;
				S <= 2'bxx; 
			end	
			
		endcase
	end
	
endmodule