module VgaAdapter(
	input resetn,
	input clk,
	input [15:0] color,
	input [9:0] x,
	input [8:0] y,
	input write,
	output wire done,
	output wire [9:0] r,
	output wire [9:0] g,
	output wire [9:0] b,
	output wire hSync,
	output wire vSync,
	output wire displayEn,
	output wire clk25,
	output wire clk100,
	inout [15:0] DRAM_DQ,
	output [11:0] DRAM_ADDR,
	output DRAM_LDQM,	
	output DRAM_UDQM,
	output DRAM_WE_N,
	output DRAM_CAS_N,
	output DRAM_RAS_N,
	output DRAM_CS_N,
	output DRAM_BA_0,
	output DRAM_BA_1,
	output DRAM_CLK,
	output DRAM_CKE
	);
	
	
	//--- Clock Generator
	// wire clk100;
	
	VgaPll(clk, clk100, clk25);
	
	
	//--- CRT Controller
	wire bufferSwap;
	wire [9:0] xCounter;
	wire [9:0] yCounter; 
	
	Crtc(resetn, clk25, xCounter, yCounter, displayEn, hSync, vSync, bufferSwap);
	
	//Testing
/*	assign r[9:0] = {xCounter[6:0] ^ yCounter[6:0], 3'b0};
	assign g[9:0] = {xCounter[7:1] ^ yCounter[7:1], 3'b0};
	assign b[9:0] = {xCounter[8:2] ^ yCounter[8:2], 3'b0};
*/

	//--- Line buffer
	
	wire [9:0] bufferAddr, readAddr;
	wire [15:0] bufferData, readData;
	wire bufferWriteEn;
	
	assign readAddr = xCounter;
	
	LineBuffer(clk100, bufferSwap, bufferAddr, bufferData, bufferWriteEn, readAddr, readData);

	assign r[9:0] = {readData[14:10], 5'b0};
	assign g[9:0] = {readData[9:5], 5'b0};
	assign b[9:0] = {readData[4:0], 5'b0};


	//--- SDRAM controller
	SdRam(resetn, clk100, color, x, y, write, done,
		bufferAddr, bufferData, bufferWriteEn, bufferSwap,yCounter,
		DRAM_DQ, DRAM_ADDR, DRAM_LDQM,	DRAM_UDQM, DRAM_WE_N, DRAM_CAS_N, 
		DRAM_RAS_N, DRAM_CS_N, DRAM_BA_0, DRAM_BA_1, DRAM_CLK, DRAM_CKE);
	
endmodule
	