`timescale 1ns/1ps

module sbox_layer import ascon_pack::*;
(
    input type_state state_i,
    output type_state state_o
);

	genvar i;
	generate
		for(i=0;i<64;i++) begin :g_sbox
    			sbox sbox_inst(
        .sbox_i({state_i[0][i], state_i[1][i], state_i[2][i], state_i[3][i], state_i[4][i]}),
        .sbox_o({state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]})
);
    		end :g_sbox
    	endgenerate
endmodule : sbox_layer
