
// a 3-bit wide 2-to-1 MUX
module mux_3bit_2to1(X,Y,s,M);
   input [2:0] X,Y;
   input       s;
   
   output [2:0] M;

   assign M = ({3{~s}} & X) | ({3{s}} & Y);

endmodule // mux_3bit_2to1

// a 3-bit wide 7-to-1 MUX
module mux_3bit_7to1(T,U,V,W,X,Y,Z,S,M);
   input [2:0] T,U,V,W,X,Y,Z,S;
   output [2:0]     M;

   wire [2:0] 	    N1,N2,N3,N4,N5;
      
   mux_3bit_2to1 m0(T,U,S[0],N1);
   mux_3bit_2to1 m1(V,W,S[0],N2);
   mux_3bit_2to1 m2(X,Y,S[0],N3);
   mux_3bit_2to1 m3(N1,N2,S[1],N4);
   mux_3bit_2to1 m4(N3,Z,S[1],N5);
   mux_3bit_2to1 m5(N4,N5,S[2],M);

endmodule // mux_3bit_7to1


   