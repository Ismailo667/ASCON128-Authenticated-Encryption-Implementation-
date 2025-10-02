`timescale 1ns / 1ps

module sbox_layer_tb import ascon_pack::*;(
        //rien
);

        type_state state_i;
        type_state state_o;


        //DUT
        sbox_layer DUT (
                .state_i(state_i),
                .state_o(state_o)
        );

        initial begin
                state_i = 320'h80400c0600000000_8a55114d1cb6a9a2_be263d4d7aecaa0f_4ed0ec0b98c529b7_c8cddf37bcd0284a;
        end

endmodule : sbox_layer_tb

