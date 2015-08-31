module Project(input [5:0]SW,output reg [5:0]GPIO_0, output reg [5:0]LEDR);
always GPIO_0[0] <= SW[0];
always GPIO_0[2] <= SW[1];
always GPIO_0[4] <= SW[2];
always GPIO_0[1] <= SW[3];
always GPIO_0[3] <= SW[4];
always GPIO_0[5] <= SW[5];
always LEDR <= SW;
endmodule 
