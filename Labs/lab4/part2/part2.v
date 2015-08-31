module Rotator(input [7:0]data, input Rotate_R, Parallel_L, clock, output [7:0]Q);

	shift_reg_parallel call1(Q[1], Q[7], Rotate_R, DATA_IN[0], Parallel_L, clock, Q[0]);
	shift_reg_parallel call2(Q[2], Q[0], Rotate_R, DATA_IN[1], Parallel_L, clock, Q[1]);
	shift_reg_parallel call3(Q[3], Q[1], Rotate_R, DATA_IN[2], Parallel_L, clock, Q[2]);
	shift_reg_parallel call4(Q[4], Q[2], Rotate_R, DATA_IN[3], Parallel_L, clock, Q[3]);
	shift_reg_parallel call5(Q[5], Q[3], Rotate_R, DATA_IN[4], Parallel_L, clock, Q[4]);
	shift_reg_parallel call6(Q[6], Q[4], Rotate_R, DATA_IN[5], Parallel_L, clock, Q[5]);
	shift_reg_parallel call7(Q[7], Q[5], Rotate_R, DATA_IN[6], Parallel_L, clock, Q[6]);
	shift_reg_parallel call8(Q[0], Q[6], Rotate_R, DATA_IN[7], Parallel_L, clock, Q[7]);
	
endmodule 