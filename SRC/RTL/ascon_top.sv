/*
-------------------------------------------------------------------------------
-- Title      : définition de l'ascon top, qui inclut la permutation entière, les compteurs de blocs 
		et de rondes et la fsm
		
-- Project    : ASCON
-------------------------------------------------------------------------------
-- File	      : ascon_top.sv
-- Author     : Hajar IDJAHA  
-------------------------------------------------------------------------------
*/

`timescale 1ns/1ps

module ascon_top import ascon_pack::*;
(
	input logic clock_i , 
	input logic resetb_i,
	input logic [127:0] nonce_i,
	input logic start_i,
	input logic [127:0] key_i,
	input logic data_valid_i,
	input logic [63:0] data_i,
	output logic [63:0] cipher_o,
	output logic cipher_valid_o,
	output logic [127:0] tag_o,
	output logic end_o 
);



	logic[3:0] round_s;
	logic[3:0] block_s;
	
	logic select_i_s;
	logic en_reg_state_s;
	logic en_cipher_s;
	logic en_tag_s;
	

	logic en_block_s;
	logic en_round_s; 
	logic init_block_s;
	logic init_a_s;
	logic init_b_s;

	logic en_xor_key_s;
	logic en_xor_lsb_s;
	logic en_xor_data_s;
	logic en_xor_end_key_s;

	type_state state_i_s;


assign state_i_s[0] = data_i;
assign state_i_s[1] = key_i[127:64];
assign state_i_s[2] = key_i[63:0] ;
assign state_i_s[3] = nonce_i[127:64];
assign state_i_s[4] = nonce_i[63:0];

	fsm_moore fsm_moore_inst(
		
	.clock_i(clock_i), 
	.resetb_i(resetb_i),
	.start_i(start_i), 
	.data_valid_i(data_valid_i),

	.round_i(round_s),
	.block_i(block_s),
	
	.data_sel_o(select_i_s),
	.en_reg_state_o(en_reg_state_s),
	.en_cipher_o(en_cipher_s),
	.en_tag_o(en_tag_s),
	.cipher_valid_o(cipher_valid_s), 
	.end_o(end_o),

	.en_block_o(en_block_s),
	.en_round_o(en_round_s), 
	.init_block_o(init_block_s),
	.init_a_o(init_a_s),
	.init_b_o(init_b_s),

	.en_xor_key_o(en_xor_key_s),
	.en_xor_lsb_o(en_xor_lsb_s),
	.en_xor_data_o(en_xor_data_s),
	.en_xor_key_end_o(en_xor_end_key_s)

);

compteur_simple_init comp_init_inst
   (
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_block_s),
	.init_a_i(init_block_s),
	.data_o(block_s)      
    );

	compteur_double_init comp_db_inst
   (
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_round_s),
	.init_a_i(init_a_s),
	.init_b_i(init_b_s),
	.data_o(round_s)      
    ); 

	permutation full_per_inst(
	.clk_i(clock_i),
	.state_i({data_i, key_i[127:64],key_i[63:0],nonce_i[127:64],nonce_i[63:0]}), 
	.select_i(select_i_s), 
 	.round_i(round_s), 
	.resetb_i(resetb_i),
	.en_xor_data_i(en_xor_data_s), 
	.en_xor_begin_key_i(en_xor_key_s), 
	.data_i(data_i),
	.en_i(en_reg_state_s),
	.en_xor_lsb_i(en_xor_lsb_s), 
	.en_xor_end_key_i(en_xor_end_key_s), 
	.key_i(key_i),
	.en_out_tag_i(en_tag_s), 
	.tag_o(tag_o),
	.en_out_cipher_i(en_cipher_s),
	.cipher_o(cipher_o)
);

endmodule: ascon_top
