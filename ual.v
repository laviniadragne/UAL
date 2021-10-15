`include "defines.vh"
module ual(
        output  [1: 0] flags,
        output  [7: 0]  out,
        input   [3: 0]  in0,
        input   [3: 0]  in1,
        input   [4: 0]  sel
    );

    wire    [7: 0]  out_nander;
    wire    [7: 0]  out_xorer;
    wire    [7: 0]  out_adder;
    wire    [7: 0]  out_subtractor;
    wire    [7: 0]  out_multiplier;

    assign out_nander[3:0] = ~(in0 & in1);
	 assign out_nander[7:4] = 0;
	 
    assign out_xorer[3:0] = in0 ^ in1;
	 assign out_xorer[7:4] = 0;

    // TODO use adder and put the result in out_adder
	 // TODO use subtractor and put the result in out_subtractor
	 // TODO use multiplier and put the result in out_multiplier
	 adder add(out_adder, in0, in1);
	 subtractor sub(out_subtractor, in0, in1);
	 multiplier mul(out_multiplier, in0, in1);

    // TODO: use "?:"
	 // sel == 1 => NAND
    // sel == 2 => XOR
    // sel == 4 => ADD
    // sel == 8 => SUB
    // sel == 16 => MUL
    assign out = 	sel == 1 ? out_nander :
						sel == 2 ? out_xorer :
						sel == 4 ? out_adder :
						sel == 8 ? out_subtractor :
						sel == 16 ? out_multiplier : 8'bx;
	 

	// TODO BONUS check whether OF is activated; remember which operations can modify it
	// TODO BONUS check whether ZF is activated
	// TODO BONUS use the defines from defines.vh
	assign flags[`ZF] = out == 0 ? 1 : 0;
	assign flags[`OF] = (sel == 4 && in0[3] == 0 && in1[3] == 0 && out[3] == 1) ? 1 :
							 (sel == 4 && in0[3] == 1 && in1[3] == 1 && out[3] == 0) ? 1 :
							 (sel == 8 && in0[3] == 0 && in1[3] == 1 && out[3] == 1) ? 1 :
							 (sel == 8 && in0[3] == 1 && in1[3] == 0 && out[3] == 0) ? 1 : 0;

endmodule