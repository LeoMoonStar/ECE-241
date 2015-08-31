// Accumulate some numbers magically stored in a memory already.
// Output the sum serially
//
// Warning: This code passes a syntax check.  It has not been simulated!!
//
// Version 1.1   November 2, 2013
//
// Paul Chow
//

module top (iClk, iResetn, iStartAddress, iNumVal, iStart, oSO);
   input iClk, iResetn, iStart;
   input [15:0] iStartAddress, iNumVal;
   output 	oSO;


   wire [7:0] 	AdderSum;
   wire 	DoneShift, DoneAdd;
   

   Adder ADD(iStartAddress, iStart, iNumVal, iClk, iResetn, AdderSum, DoneShift, DoneAdd);
   ShiftOut SHIFT(AdderSum, DoneAdd, iClk, iResetn, DoneShift, oSO);

endmodule // top




module Adder (iStartAddr, iStart, iNVal, iClk, iResetn, oSum, iDoneShift, oDoneAdd);

   input [15:0] iStartAddr, iNVal;
   input 	iClk, iResetn, iDoneShift, iStart;
   output [7:0] oSum;
   output 	oDoneAdd;

   reg [2:0] 	NState, CState;  // State values
   reg [15:0] 	MAR, NumVal;     // Memory address register and counter of number of values to add
   reg [7:0] 	R, S;            // R and S registers
   reg 		DoneAdd;
   
   wire [15:0] 	MemOut;
   
   parameter [2:0] ST_Idle = 0, ST_LoadMAR = 1, ST_LoadR = 2, ST_IncMAR = 3, ST_Done = 4;

   // Controller


   always @(*) // Next State and control combinational logic
     begin 
	case (CState)
	  ST_Idle:
	    begin
	       if(iStart)
		 begin
		    NState = ST_LoadMAR;
		 end
	       else
		 begin
		    NState = ST_Idle;
		    DoneAdd = 0;
		 end
	    end
	  ST_LoadMAR:  // After coding it turns out that this state is not needed - could remove it
	    begin
	       NState = ST_LoadR;
	    end
	  ST_LoadR:
	    begin
	       if(NumVal == 0)   // Why do this versus checking if NumVal > 0?  There's a big hardware difference.
		 NState = ST_Done;
	       else
		 NState = ST_IncMAR;
	    end // case: ST_LoadR
	  ST_IncMAR:  // Have this one state to do the increment, could actually remove this if you think about it
	    begin
	       NState = ST_LoadR;
	    end
	  ST_Done:
	    begin
	       DoneAdd = 1;  // Trigger the shifter FSM to start
	       if(!iDoneShift)
		 NState = ST_Done;  // Wait for handshake from Output FSM
	       else
		 begin
		    NState = ST_Idle;  // Can now move to idle
		    DoneAdd = 0;  // Complete the handshake.
		    // The output FSM should look for DoneAdd to go low before waiting for next output.
		 end
	    end // case: ST_Done
	  default:  // avoid latching - give default values to all regs being assigned in the case
	    begin
	       NState = ST_Idle;
	       DoneAdd = 0;
	    end

	endcase // case (CState)
     end // always @ begin
   

   
   // State registers

   always @(posedge iClk)
     begin
	if(!iResetn)
	  CState <= ST_Idle;
	else
	  CState <= NState;
     end


   // MAR and NumVal Registers

   always @(posedge iClk)
     begin
	if(iStart)
	  begin
	     MAR <= iStartAddr;
	     NumVal <= iNVal;
	  end
	else
	  begin
	     if(CState == ST_IncMAR)
	       begin
		  MAR <= MAR + 1;	  // Go to next address
		  NumVal <= NumVal - 1;   // Decrement number of values to do
	       end
	  end // else: !if(iStart)
     end // always @ (posedge iClk)
   

   // R Register

   always @(posedge iClk)
     begin
	if(!iResetn)
	  R <= 0;
	else
	  if(CState == ST_LoadR)
	    R <= R + MemOut;
     end
   
   

   // Memory block
   // Typically a vendor-supplied IP core that you get from a vendor library and instantiate
   // The module here is a placeholder module.

   Memory M1 (MAR, MAR, 1, MemOut);

   // Various connections

   assign oDoneAdd = DoneAdd;
   assign oSum = R;
   
endmodule // Adder



	  
// Dummy memory module

module Memory(iAddress, iData, iR_Wn, oData);
   input [15:0] iAddress, iData;
   input 	iR_Wn;
   output [15:0] oData;

   assign oData = iData;
   
endmodule // Memory




module ShiftOut(iData, iDoneAdd, iClk, iResetn, oDoneShift, oSO);
   
   input [7:0] iData;
   input       iDoneAdd, iClk, iResetn;
   output      oDoneShift, oSO;

   reg [2:0]   NState, CState;  // State values
   reg [3:0]   NumBits;   // track number of bits to output
   reg [7:0]   S;   // the shift register
   reg [27:0]  DelayCounter;   // Counts a big delay

   // Some flag bits
   // Done1s is set by delay counter when it has counted to 0
   // DoneShift is set when all bits have been output

   wire        Done1s;
   reg	       DoneShift;

   parameter [2:0] ST_Idle = 0, ST_LoadS = 1, ST_LoadSW = 2, ST_ShiftS = 3, ST_ShiftSW = 4,ST_DecNumBits = 5, ST_DoneShift = 6;
   
      
   // Controller
   //
   // Observe that the state diagram only had one state for LoadS and ShiftS that included waiting.
   // It turned out that it was more convenient to separate the waiting into a separate state so
   // that there was one state to do stuff before doing the waiting.

   always @(*)  // input and control combinational logic
     begin
	case (CState)
	  ST_Idle:
	    begin
	       DoneShift = 0;
	       if(iDoneAdd)
		 NState = ST_LoadS;
	       else
		 NState = ST_Idle;
	    end
	  ST_LoadS:  // Split into state to load and wait state
	    NState = ST_LoadSW;
	  ST_LoadSW:  // Wait for the timer
	    begin
	       if(!Done1s)
		 NState = ST_LoadSW;
	       else
		 NState = ST_ShiftS;
	    end
	  ST_ShiftS:  // Split into state to shift and wait state
	    NState = ST_ShiftSW;
	  ST_ShiftSW:
	    begin
	       if(!Done1s)
		 NState = ST_ShiftSW;
	       else
		 NState = ST_DecNumBits;
	    end
	  ST_DecNumBits:
	    begin
	       if(NumBits == 0)
		 NState = ST_DoneShift;
	       else
		 NState = ST_ShiftS;
	    end
	  ST_DoneShift:
	    begin
	       DoneShift = 1;
	       if(iDoneAdd)
		 NState = ST_DoneShift;  // Wait for DoneAdd to go low
	       else
		 begin
		    NState = ST_Idle;
		    DoneShift = 0;
		 end
	    end // case: ST_DoneShift
	  default:
	    begin  // avoid latches
	       NState = ST_Idle;
	       DoneShift = 0;
	    end
	endcase // case (CState)
     end // always @ begin
   
   assign oDoneShift = DoneShift;

   // State registers

   always @(posedge iClk)
     begin
	if(!iResetn)
	  CState <= ST_Idle;
	else
	  CState <= NState;
     end


   // NumBits counter and S Register

   always @(posedge iClk)
     begin
	if(CState == ST_LoadS)   // Only in this state for 1 cycle
	  begin
	     S <= {iData,3'b011};  // Load the shift register with the input data and the control bits
	     NumBits <= 11;
	  end
	else
	  begin
	     if(CState == ST_ShiftS)  // Only in this state for 1 cycle
	       begin
		  NumBits = NumBits - 1;
		  S <= S >> 1;
	       end
	  end
     end // always @ (posedge iClk)

   assign oSO = S[0];  // The output bit
   


   // Wait 1 second counter
   // Done1s signals when counter reaches 0 - generated by looking at DelayCounter output

   always @(posedge iClk)
     begin
	if(!iResetn)
	  DelayCounter <= 50000000;  // Set to a nonzero value so that Done1s is 0 on reset
	else
	  begin
	     if(CState == ST_LoadS || CState == ST_ShiftS)  // Use these states to load counter
	       begin
		  DelayCounter <= 50000000;  // 1 second for 50 MHz clock
		  // This will also clear Done1s
	       end
	     else
	       begin
		  if(CState == ST_LoadSW || CState == ST_ShiftSW)
		    DelayCounter <= DelayCounter - 1;
	       end
	  end // else: !if(!iResetn)
     end // always @ (posedge iClk)
   		   
   assign Done1s = (DelayCounter == 0);


endmodule // ShiftOut

      
      
   

  
      