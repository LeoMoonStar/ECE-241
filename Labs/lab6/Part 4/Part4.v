module Part4(input [2:0]SW, input [1:0]KEY, input CLOCK_50, output reg [0:0]LEDR);

	wire Reset = KEY[0];
	wire Change = KEY[1];
	wire Clock = CLOCK_50;
	wire [2:0] Switch = SW;
	integer timer = 0, i = 0, limit;
	
	parameter Q = 14'b01110101110111, R = 14'b01011101, S = 14'b010101, T = 14'b0111, U = 14'b01110101, V = 14'b0111010101, W = 14'b0111011101, X = 14'b011101010111;
	
	parameter C_Q = 4'b1110, C_R = 4'b1000, C_S = 4'b110, C_T = 4'b100, C_U = 4'b1000, C_V = 4'b1010, C_W = 4'b1010, C_X = 4'b1100;
	
	reg [13:0] display;
	reg [3:0] count;
	
	parameter A = 3'b0, B = 3'b1, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
		
	always@(negedge Reset, negedge Change)
		if(!Reset)
			begin
				display = 0;
				count = 0;
			end
		else
		begin
			case(Switch)
				A: begin display = Q; count = C_Q; end
				B: begin display = R; count = C_R; end
				C: begin display = S; count = C_S; end
				D: begin display = T; count = C_T; end
				E: begin display = U; count = C_U; end
				F: begin display = V; count = C_V; end
				G: begin display = W; count = C_W; end
				H: begin display = X; count = C_X; end
			endcase
			limit = (count[0] + (count[1] * 2) + (count[2] * 4) + (count[3] * 8));
		end
	
	always@(posedge Clock)
		begin
			timer = timer + 1;
			if(timer == 25000000)
				begin
					if(i < limit)
					begin
						LEDR[0] = display[i];
						i = i + 1;
					end
					else
						i = 0;
					timer = 0;
				end	
		end
		
endmodule 
