`timescale 1ns / 1ps

	module permutation import ascon_pack::*;
	(
		input logic clk_i,

		input type_state state_i, //mux
		input logic select_i, //mux

		input logic[3:0] round_i, //pc

		input logic resetb_i, //reg_tag, reg_cipher

		input logic en_xor_data_i, //xorb
		input logic en_xor_begin_key_i, //xorb
		input logic [63:0] data_i,

		input logic en_i, //reg_state
		
		input logic en_xor_lsb_i, //xore
    	input logic en_xor_end_key_i, //xore
    	input logic [127 : 0] key_i, //xorb, xore

		input logic en_out_tag_i, //reg_tag
		output logic [127:0] tag_o, //reg_tag

		input logic en_out_cipher_i, //reg_cipher
		output logic [63:0]cipher_o //reg_cipher


	);

	//signaux internes
	type_state  pc_to_ps_s/*pc->ps*/, ps_to_pl_s/*ps->pl*/, pl_to_xore_s/*xore->reg*/, reg_to_mux_tag_s/*reg->mux*/, mux_to_xorb_s  /*mux->xorb*/, xorb_to_pc_s /*xorb->pc*/, xore_to_reg_s/*xore->reg*/;

	mux_state mux (
		.sel_i(select_i),
		.data1_i(state_i),
		.data2_i(reg_to_mux_tag_s),
		.data_o(mux_to_xorb_s)
	);

	constant_addition pc (
		.state_i(xorb_to_pc_s),
		.round_i(round_i),
		.state_o(pc_to_ps_s)
	);

	sbox_layer ps (
		.state_i(pc_to_ps_s),
		.state_o(ps_to_pl_s)
	);

	diffusion_layer pl (
		.diffusion_i(ps_to_pl_s),
		.diffusion_o(pl_to_xore_s)
	);

	xor_begin_perm xor_begin (
		.en_xor_data_i(en_xor_data_i),
		.en_xor_begin_key_i(en_xor_begin_key_i),
		.key_i(key_i),
		.data_i(data_i),
		.state_i(mux_to_xorb_s),
		.state_o(xorb_to_pc_s)
	);

	xor_end_perm xor_end (
		.en_xor_lsb_i(en_xor_lsb_i),
		.en_xor_end_key_i(en_xor_end_key_i),
		.key_i(key_i),
		.state_i(pl_to_xore_s),
		.state_o(xore_to_reg_s)
    );

	state_register_w_en register_state (
		.clock_i(clk_i),
		.resetb_i(resetb_i),
		.en_i(en_i),
		.data_i(xore_to_reg_s),
		.data_o(reg_to_mux_tag_s)
	);

	register_w_en #(.nb_bits_g(128)) reg_tag (
		.clock_i(clk_i),
		.resetb_i(resetb_i),
		.en_i(en_out_tag_i),
		.data_i({reg_to_mux_tag_s[3],reg_to_mux_tag_s[4]}),
		.data_o(tag_o)      
    );

	register_w_en #(.nb_bits_g(64)) reg_cipher (
		.clock_i(clk_i),
		.resetb_i(resetb_i),
		.en_i(en_out_cipher_i),
		.data_i({xorb_to_pc_s[0]}),
		.data_o(cipher_o)    
	);


endmodule : permutation