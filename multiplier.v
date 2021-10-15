`include "defines.vh"
module multiplier(
        output  [7: 0]  out,
        input   [3: 0]  M,
        input   [3: 0]  R
    );
    //  Implement Booth's algorithm

    wire [3:0] not_M;
    wire [3:0] neg_M;

    assign not_M = ~M;

    // TODO: "neg_M = not_M + 1" using adder
	 assign neg_M = not_M + 1;

    reg [8:0] P;
    reg [8:0] A;
    reg [8:0] S;
	 wire [8:0] sumA;
	 wire [8:0] sumS;
	 
	 adder add1(sumA, P, A);
	 adder add2(sumS, P, S);
	 
	 always @(*) begin
			// Pasul 1 - Formam P
			P[8:0] = 0;
			P[4:1] = R;
	 
			// Pasul 2 - Valori auxiliare A, S
			A[8:0] = 0;
			A[8:5] = M;
	 
			S[8:0] = 0;
			S[8:5] = neg_M;
			
		repeat(4) begin
			case (P[1:0]) 
					2'b01: P = P + A;
					2'b10: P = P + S;
			endcase
			P = ($signed(P) >>> 1);
      end
    end


	assign out = P[8:1];
	
endmodule