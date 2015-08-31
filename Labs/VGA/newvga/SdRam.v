module SdRam(
	input resetn,
	input clk,
	input [15:0] color,
	input [9:0] x,
	input [8:0] y,
	input writeRequest, // handshaking
	output reg writeDone, // handshaking
	output [9:0] bufferAddr,
	output reg [15:0] bufferData,
	output reg bufferWriteEn,
	input bufferSwap,
	input [8:0] displayY,
	
	inout  reg [15:0] DRAM_DQ,
	output reg [11:0] DRAM_ADDR,
	output DRAM_LDQM,	
	output DRAM_UDQM,
	output DRAM_WE_N,
	output DRAM_CAS_N,
	output DRAM_RAS_N,
	output DRAM_CS_N,
	output DRAM_BA_0,
	output DRAM_BA_1,
	output DRAM_CLK,
	output DRAM_CKE, 
	output reg [4:0] currentState);

	
	//--- Register write data
/*	reg [15:0] colorWrite;
	reg [9:0] xWrite;
	reg [8:0] yWrite;

	always @(posedge clk)
	begin
		if (currentState == S_IDLE)
		begin
			colorWrite <= color;
			xWrite <= x;
			yWrite <= y;
		end
	end
*/

	//--- Read the next line to be displayed
	reg [8:0] nextY;
	
	always @(displayY) //using posedge clk results in errors (why???)
	begin
		if (displayY[8:0] == 9'd478)
			nextY <= 9'd0;
		else if (displayY[8:0] == 9'd479)
			nextY <= 9'd1;
		else
			nextY <= displayY + 2'd2;
	end


	//--- Buffer swap flag and transition
	reg bufferFlag;
	reg bufferSwapOld;
	
	always @(posedge clk)
		bufferSwapOld <= bufferSwap;
	
	always @(posedge clk or negedge resetn)
	if (~resetn)
		bufferFlag <= 1'b0;
	else if (currentState == S_READ0) //Reset automatically at this state
		bufferFlag <= 1'b0; 
	else if (bufferSwap && ~bufferSwapOld) //Sets flag at positive transition
		bufferFlag <= 1'b1;
	
	
	//--- General Purpose Counter
	//Used for delays
	//Also is the write address to the line buffer
	reg counterEn;
	reg counterReset;
	reg [14:0] counter;
	
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
			counter <= 15'b0;
		else if (counterReset)
			counter <= 15'b0;
		else if (counterEn)
			counter <= counter + 1'b1;
	end
	
	
	//--- Refresh Counter and Flag
	reg [9:0] refreshCounter;
	reg refreshFlag;
	
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
		begin
			refreshCounter <= 10'b0;
			refreshFlag <= 1'b0;
		end
		else if (currentState == S_REFRESH0) //Automatically reset at this state
		begin
			refreshCounter <= 10'b0;
			refreshFlag <= 1'b0;
		end
		else
		begin
			refreshCounter <= refreshCounter + 1'b1;
			
			if (refreshCounter == 10'd1000)
				refreshFlag <= 1'b1;
		end
	end
	
	
	//--- For writing to line buffer, hardwired to counter
	assign bufferAddr = counter[9:0];
	// assign bufferData = DRAM_DQ;	


	//--- SDRAM commands
	parameter DESL = 4'bxxx1;
	parameter NOP = 4'b1110;
	parameter MRS = 4'b0000;
	parameter ACT = 4'b1100;
	parameter READ = 4'b1010;
	parameter WRITE = 4'b0010;
	parameter PRE = 4'b0100;
	parameter BST = 4'b0110;
	parameter REF = 4'b1000;

	reg [3:0] sdramCommand;

	assign DRAM_CS_N = sdramCommand[0];
	assign DRAM_RAS_N = sdramCommand[1];
	assign DRAM_CAS_N = sdramCommand[2];
	assign DRAM_WE_N = sdramCommand[3];


	//--- State Transitions
	parameter H = 1'b1, L = 1'b0;
	parameter S_INIT0 = 5'd0, S_INIT1 = 5'd1, S_INIT2 = 5'd2, S_INIT3 = 5'd3, S_INIT4 = 5'd4,
				S_INIT5 = 5'd5, S_INIT6 = 5'd6, S_INIT7 = 5'd7, S_INIT8 = 5'd8, S_INIT9 = 5'd9,
				S_READ0 = 5'd10, S_READ1 = 5'd11, S_READ2 = 5'd12, S_READ3 = 5'd13, S_READ4 = 5'd14,
				S_READ5 = 5'd15, S_READ6 = 5'd16, S_READ7 = 5'd17, S_READ8 = 5'd18,
				S_READ9 = 5'd19, S_READ10 = 5'd20, S_IDLE = 5'd21, S_REFRESH0 = 5'd22, S_REFRESH1 = 5'd23,
				S_WRITE0 = 5'd24, S_WRITE1 = 5'd25, S_WRITE2 = 5'd26, S_WRITE3 = 5'd27,
				S_WRITE4 = 5'd28, S_WRITE5 = 5'd29, S_WRITE6 = 5'd30, S_WRITE7 = 5'd31;
				
	//reg [4:0] currentState;
	reg [4:0] nextState;
	
	
	//State flip-flop
	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			currentState <= S_INIT0;
		else
			currentState <= nextState;
	end
	
	
	//Next State Table and Output Decoder
	always @(currentState or counter or bufferFlag or writeRequest or nextY or x or y or color or refreshFlag or DRAM_DQ)
	begin
		case (currentState)
			//-------------------------------------------------------
			S_INIT0: // powerup: reset counter
			begin
				nextState		<= S_INIT1;
				DRAM_DQ			<= 16'b1111111111111111;
				DRAM_ADDR		<= 12'b0;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= NOP;
				counterReset 	<= H;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT1: // powerup: wait 200us (~20K cycles @ 100MHz)
			begin
				if (counter[14:0] == 15'd21000)	nextState <= S_INIT2; //Next
				else							nextState <= S_INIT1;
				
				DRAM_DQ			<= 16'b1111111111111111;
				DRAM_ADDR		<= 12'b0;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= H;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT2: // precharge: reset counter, issue command
			begin
				nextState		<= S_INIT3;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'b010000000000; //All banks
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= PRE;
				counterReset 	<= H;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT3: // precharge: wait 8 cycles after issuing precharge
			begin
				if (counter[2:0] == 3'd7)	nextState <= S_INIT4; //Next
				else						nextState <= S_INIT3;
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= H;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT4: // Auto Refresh: Reset counter for following loop
			begin
				nextState		<= S_INIT5;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= H;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT5: // Auto Refresh: issue REF command and reset counter
			begin
				nextState		<= S_INIT6;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= REF;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT6: // Auto Refresh: wait at least 16 cycles and do 16 REF commands
			begin
				if (counter[3:0] == 4'd15)
				begin
					//End of waiting
					if (counter[7:4] == 4'd15)	nextState <= S_INIT7; //next
					else						nextState <= S_INIT5; //another REF
				end 
				else							nextState <= S_INIT6; //wait
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= H;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT7: // Mode Set
			begin
				nextState		<= S_INIT8;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'b001000110111;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= MRS;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT8: // Mode Set: wait cycle 1
			begin
				nextState		<= S_INIT9;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_INIT9: // Mode Set: wait cycle 2
			begin
				nextState		<= S_READ0;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			
			
			//-------------------------------------------------------
			S_READ0: // Read: Reset counter
			begin
				nextState		<= S_READ1;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= H;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ1: // Read: Bank Activate + Row Address
			begin
				nextState		<= S_READ2;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= {1'b0, nextY[8:0], counter[9:8]};
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= ACT;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ2: // Read: wait cycle 1
			begin
				nextState		<= S_READ3;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ3: // Read: wait cycle 2
			begin
				nextState		<= S_READ4;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ4: // Read: Read Command + Col Address (w/o autoprecharge)
			begin
				nextState		<= S_READ5;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'b000000000000;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= READ;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ5: // Read: Wait cycle 1
			begin
				nextState		<= S_READ6;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ6: // Read: Wait cycle 2
			begin
				nextState		<= S_READ7;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ7: // Read: Read the actual data! A page is 256 words!
			begin
				if (counter[7:0] == 8'd255)	nextState <= S_READ8; //Next
				else						nextState <= S_READ7;
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= DRAM_DQ;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= H;
				writeDone		<= H;
				bufferWriteEn 	<= H;
			end
			S_READ8: // Stop Burst: send precharge to stop burst
			begin
				nextState		<= S_READ9;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 1'b0;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= PRE;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ9: // Stop Burst: wait cycle 1
			begin
				nextState		<= S_READ10;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_READ10: // Stop Burst: wait cycle 2
			begin
				if (counter[9:8] == 2'd3)	nextState <= S_IDLE; //Next 
				else						nextState <= S_READ1; //New read command
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			
			
			//-------------------------------------------------------
			S_IDLE: // idle
			begin
				if (bufferFlag)
					nextState <= S_READ0; //Read new line
				else if (writeRequest)
					nextState <= S_WRITE0; //Write
				else if (refreshFlag)
					nextState <= S_REFRESH0; //Refresh
				else
					nextState <= S_IDLE; //Wait
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			
			
			//-------------------------------------------------------
			S_REFRESH0: // refresh: reset counter, send command
			begin
				nextState		<= S_REFRESH1;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 1'b0;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= REF;
				counterReset 	<= H;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_REFRESH1: // refresh: wait for 8 cycles
			begin
				if (counter[3:0] == 4'd10)	nextState <= S_IDLE;
				else						nextState <= S_REFRESH1;
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= H;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			
			
			//-------------------------------------------------------
			S_WRITE0: // Write: Bank Activate + Row Address.
			begin
				nextState		<= S_WRITE1;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= {1'b0, y[8:0], x[9:8]};
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= ACT;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_WRITE1: // Write: Wait for Bank Activate
			begin
				nextState		<= S_WRITE2;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_WRITE2: // Write: Wait for Bank Activate
			begin
				nextState		<= S_WRITE3;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx; // {4'b0, x[7:0]} I need address and data here before the write (why???)
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_WRITE3: // Write: Write Command + Col Address + Data
			begin
				nextState		<= S_WRITE4;
				DRAM_DQ			<= color;
				DRAM_ADDR		<= {4'b0, x[7:0]};
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= WRITE;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= H;
				bufferWriteEn 	<= L;
			end
			S_WRITE4: // Write: Precharge Bank A, set writeDone
			begin
				nextState		<= S_WRITE5;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'b0;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= PRE;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= L;
				bufferWriteEn 	<= L;
			end
			S_WRITE5: // Write: Wait cycle 1
			begin
				nextState		<= S_WRITE6;
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= L;
				bufferWriteEn 	<= L;
			end
			S_WRITE6: // Write: Wait cycle 2
			begin
				if (writeRequest)	nextState <= S_WRITE6; //Wait while request is still active
				else				nextState <= S_IDLE;
				
				DRAM_DQ			<= 16'bzzzzzzzzzzzzzzzz;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= DESL;
				counterReset 	<= L;
				counterEn		<= L;
				writeDone		<= L;
				bufferWriteEn 	<= L;
			end
			
			
			//-------------------------------------------------------
			default:
			begin
				nextState		<= 5'bxxxxx;
				DRAM_DQ			<= 16'bxxxxxxxxxxxxxxxx;
				DRAM_ADDR		<= 12'bxxxxxxxxxxxx;
				bufferData		<= 16'bxxxxxxxxxxxxxxxx;
				sdramCommand 	<= 4'bxxxx;
				counterReset 	<= 1'bx;
				counterEn		<= 1'bx;
				writeDone		<= 1'bx;
				bufferWriteEn 	<= 1'bx;
			end
		endcase
	end
	
	
	//--- Permenant Connections
	
	// We are always reading (assuming active low)
	assign DRAM_LDQM = 1'b0, DRAM_UDQM = 1'b0;
	
	// We will only use Bank 0
	assign DRAM_BA_0 = 1'b0, DRAM_BA_1 = 1'b0;
	
	// 100MHz Clock
	assign DRAM_CLK = clk;
	assign DRAM_CKE = 1'b1;
	
	
endmodule