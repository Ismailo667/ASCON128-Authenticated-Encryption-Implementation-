`timescale 1ns / 1ps

module sbox_tb import ascon_pack::*;

(
        //rien
);

        logic[4:0] state_i;
        logic[4:0] state_o;


        //DUT
        sbox DUT (
                .sbox_i(state_i),
                .sbox_o(state_o)
        );

        initial begin
                state_i = 5'h0A;
		#10;
		state_o = 5'h18;
		#10;
        end

endmodule : sbox_tb

