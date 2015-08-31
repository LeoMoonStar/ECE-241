module Part3(input CLOCK_50, output [17:0]LEDR);

	wire Clock = CLOCK_50;
	integer count = 0;
	reg [17:0]Q = 18'b1;
	reg dir_left = 1;
	
	always@(posedge Clock)
		begin
		count = count + 1;
		if(count == 50000000)
			begin
				if(dir_left)
				begin	
					Q = Q * 2;
					dir_left <= ~Q[17];
				end
				else
				begin
					Q = Q / 2;
					dir_left <= Q[0];
				end
				count = 0;
			end
		end
	
	assign LEDR = Q;
	
endmodule 	