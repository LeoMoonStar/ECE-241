module LineBuffer(
	input clk,
	input bufferSwap,
	input [9:0] writeAddr,
	input [15:0] writeData,
	input writeEn,
	input [9:0] readAddr,
	output reg [15:0] readData);
	
	
	//T flipflop
	reg bufferSel;
	reg bufferSwapOld;
	
	always @(posedge clk)
		bufferSwapOld <= bufferSwap;
	
	always @(posedge clk)
		if (bufferSwap && ~bufferSwapOld) //positive transition
			bufferSel <= ~bufferSel;
			
			
	//Multiplexers
	reg [9:0] ramAddr1, ramAddr2;
	reg [15:0] ramData1, ramData2;
	reg writeEn1, writeEn2;
	
	always @(bufferSel or readAddr or writeAddr or writeEn) //Input
	begin
		if (bufferSel == 1'b0)
		begin
			//Read from 1, write to 2
			ramAddr1 <= readAddr;
			ramAddr2 <= writeAddr;
			writeEn1 <= 1'b0;
			writeEn2 <= writeEn;
		end
		else
		begin
			//Read from 2, write to 1
			ramAddr1 <= writeAddr;
			ramAddr2 <= readAddr;
			writeEn1 <= writeEn;
			writeEn2 <= 1'b0;
		end
	end

	always @(bufferSel or ramData1 or ramData2) //Output
		if (bufferSel == 1'b0)
			readData <= ramData1; //Read from 1
		else
			readData <= ramData2; //Read from 2


	//Main memory
	LineBufferRam(ramAddr1, clk, writeData, writeEn1, ramData1);
	LineBufferRam(ramAddr2, clk, writeData, writeEn2, ramData2);
	
	
endmodule