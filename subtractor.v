`include "defines.vh"
module subtractor(
        output  [7: 0]  D,
        input   [3: 0]  A,
        input   [3: 0]  B
    );
	
    wire [7:0] tmp;
	 wire [3:0] aux;

	// TODO: implement a subtractor
	adder adder1(tmp, A, (~B + 1));
	assign D[3:0] = tmp [3:0];
	assign D[7:4] = 0;

endmodule
