module hex_decoder(input [0:3]D, output [6:0]display);
 
	assign display[0] = (~D[0] & ~D[2] & (D[1]^D[3])) | (D[0] & D[3] & (D[1]^D[2])) ;
	assign display[1] = (D[1] & ~D[3] & (D[0] | D[2])) | (D[0] & D[2] & D[3]) | (~D[0] & D[1] & ~D[2] & D[3]);
	assign display[2] = (~D[0] & ~D[1] & D[2] & ~D[3]) | (D[0] & D[1] & (D[2] | ~D[3]));
	assign display[3] = (~D[0] & ~D[2] & (D[1]^D[3])) | (D[1] & D[2] & D[3]) | (D[0] & ~D[1] & D[2] & ~D[3]);
	assign display[4] = (~D[0] & D[3]) | (~D[1] & ~D[2] & D[3]) | (~D[0] & D[1] & ~D[2]);
	assign display[5] = (~D[0] & ~D[1] & (D[2] | D[3])) | (~D[0] & D[2] & D[3]) | (D[0] & D[1] & ~D[2] & D[3]);
	assign display[6] = (~D[0] & ~D[1] & ~ D[2]) | (D[0] & D[1] & ~D[2] & ~D[3]) | (~D[0] & D[1] & D[2] & D[3]);

endmodule 