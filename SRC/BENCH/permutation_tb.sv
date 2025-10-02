`timescale 1ns / 1ps

module permutation_tb import ascon_pack::*;
(
        //rien
);

		logic clk_i_s;

		type_state state_i_s; //mux
		logic select_i_s; //mux
		logic[3:0] round_i_s; //pc

		logic resetb_i_s; //reg_tag, reg_cipher

		logic en_xor_data_i_s; //xorb
		logic en_xor_key_begin_i_s; //xorb
		logic [63:0] data_i_s;

		logic en_i_s; //reg_state
		
		logic en_xor_lsb_i_s; //xore
    	logic en_xor_key_end_i_s; //xore
    	logic [127 : 0] key_i_s; //xorb, xore

		logic en_out_tag_i_s; //reg_tag
		logic [127:0] tag_o_s; //reg_tag

		logic en_out_cipher_i_s; //reg_cipher
		logic [63:0] cipher_o_s; //reg_cipher

        //DUT
	permutation DUT (
	.state_i(state_i_s),
	.select_i(select_i_s),
	.round_i(round_i_s),
	.clk_i(clk_i_s),
	.resetb_i(resetb_i_s),
	.tag_o(tag_o_s),
	.data_i(data_i_s),
	.en_i(en_i_s),
	.en_out_tag_i(en_out_tag_i_s),
	.en_xor_data_i(en_xor_data_i_s),
	.en_xor_begin_key_i(en_xor_begin_key_i_s),
	.en_xor_end_key_i(end_xor_end_key_i_s),
	.en_xor_lsb_i(en_xor_lsb_i_s),
	.key_i(key_i_s),
	.en_out_cipher_i(en_out_cipher_i_s),
	.cipher_o(cipher_o_s)
	);


	//generateur d'horloge
	initial begin
		clk_i_s = 1'b1;
		forever #10 clk_i_s = ~clk_i_s;
	end

	//stimulis
	initial begin
		state_i_s[0]=64'h80400c0600000000;
		state_i_s[1]=64'h8a55114d1cb6a9a2;
		state_i_s[2]=64'hbe263d4d7aecaaff;
		state_i_s[3]=64'h4ed0ec0b98c529b7;
		state_i_s[4]=64'hc8cddf37bcd0284a;
		select_i_s = 1'b0;
		en_xor_data_i_s = 1'b0;
		en_xor_key_begin_i_s = 1'b0;
		data_i_s = 1'b0;
		en_xor_lsb_i_s = 1'b0;
		en_xor_key_end_i_s = 1'b0;
		key_i_s = 1'b0;
		resetb_i_s = 1'b0;
		en_i_s = 1'b1;
		en_out_tag_i_s = 1'b1;
		en_out_cipher_i_s = 1'b1;
		resetb_i_s = 1'b0;
		round_i_s = 4'b0;
		#2;
		resetb_i_s = 1'b1;

		
		#18;
		select_i_s = 1'b1;
		begin 
			integer i;
			for (i = 1; i < 12; i ++)
				begin
					round_i_s = i;
					#20;
				end
		end
	end

endmodule : permutation_tb