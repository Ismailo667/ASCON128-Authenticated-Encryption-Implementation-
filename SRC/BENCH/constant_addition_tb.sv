`timescale 1ns / 1ps

module constant_addition_tb import ascon_pack::*;

(
        //rien
);

        type_state constant_add_i_s;
        type_state constant_add_o_s;
	logic[3:0] round_s;


        //DUT
        constant_addition DUT (
                .state_i(constant_add_i_s),
                .state_o(constant_add_o_s),
                .round_i(round_s)
        );

        initial begin
                constant_add_i_s[0] = 64'h80400c0600000000;
                constant_add_i_s[1] = 64'h8a55114d1cb6a9a2;
                constant_add_i_s[2] = 64'hbe263d4d7aecaaff;
                constant_add_i_s[3] = 64'h4ed0ec0b98c529b7;
                constant_add_i_s[4] = 64'hc8cddf37bcd0284a;

		round_s = 4'h0;
		#10;
        end

endmodule : constant_addition_tb






