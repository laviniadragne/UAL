`include "defines.vh"
module adder(
        output  [7: 0]  S,
        input   [3: 0]  A,
        input   [3: 0]  B
    );
	
	// TODO: Implement a carry look-ahead adder
	wire [3:0] #4 carry_la;
	wire [3:0] #4 P, G;
	wire c_out;
	
	assign G[0] = A[0] & B[0];
	assign G[1] = A[1] & B[1];
	assign G[2] = A[2] & B[2];
	assign G[3] = A[3] & B[3];
	
	assign P[0] = A[0] | B[0];
	assign P[1] = A[1] | B[1];
	assign P[2] = A[2] | B[2];
	assign P[3] = A[3] | B[3];
	
	assign carry_la[0] = 0;
	assign carry_la[1] = G[0] | P[0] & 0;
	assign carry_la[2] = G[1] | P[1] & G[0] | P[1] & P[0] & 0;
	assign carry_la[3] = G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2] & P[1] & P[0] & 0;
	assign c_out = G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3] & P[2] & P[1] & G[0] | P[3] & P[2] & P[1] & P[0] & 0;
	
	full_adder FA0(S[0], , A[0], B[0], carry_la[0]);
	full_adder FA1(S[1], , A[1], B[1], carry_la[1]);
	full_adder FA2(S[2], , A[2], B[2], carry_la[2]);
	full_adder FA3(S[3], S[4], A[3], B[3], carry_la[3]);
	assign S[7:5] = 0;

//1011
//1100
//10111

endmodule