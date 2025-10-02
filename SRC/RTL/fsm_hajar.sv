/*
-------------------------------------------------------------------------------
-- Title      : définition de la machine d'états avec les différentes sorties en 
		fonctions des phases de traitement
-- Project    : ASCON
-------------------------------------------------------------------------------
-- File	      : ascon_pack.sv
-- Author     : Hajar IDJAHA  
-------------------------------------------------------------------------------
*/


`timescale 1ns/1ps

module fsm_moore (
	input logic clock_i , 
	input logic resetb_i,
	input logic start_i, 
	input logic data_valid_i,

	input logic[3:0] round_i,
	input logic[3:0] block_i,
	
	output logic data_sel_o,
	output logic en_reg_state_o,
	output logic en_cipher_o,
	output logic en_tag_o,
	output logic cipher_valid_o, 
	output logic end_o,

	output logic en_block_o,
	output logic en_round_o, 
	output logic init_block_o,
	output logic init_a_o,
	output logic init_b_o,

	output logic en_xor_key_o,
	output logic en_xor_lsb_o,
	output logic en_xor_data_o,
	output logic en_xor_key_end_o
	
);




typedef enum {idle, conf_init,end_conf_init, init,end_init, wait_DA,conf_DA,end_conf_DA, DA, end_DA, wait_P,conf_P,end_conf_P, P, end_P, conf_last_P,end_conf_last_P,last_P, end_last_P,idle_ag} state_t ;
// internal variable to model the FSM
state_t current_state , next_state ;


always_ff @( posedge clock_i or negedge resetb_i )
begin : seq_0
	if ( resetb_i == 0)

	current_state <= idle ; //on revient au début pour attendre
	else
	current_state <= next_state ;
end : seq_0

// first combinational process for transitions
always_comb
begin : comb_0
	case ( current_state )
		idle : 
		if (start_i == 0)
			next_state = idle ;
		else
			next_state = conf_init ;
		conf_init : 
			next_state = end_conf_init ;
		end_conf_init: 
			next_state = init;
		init:
		if (round_i == 4'ha)
			next_state = end_init ;
		else
			next_state = init ;
			
		end_init: 
			next_state = wait_DA;
		wait_DA:
		if (data_valid_i == 1)
			next_state = conf_DA;
		else
			next_state = wait_DA ;
		conf_DA:
			next_state = end_conf_DA;
		end_conf_DA:
			next_state = DA;
		DA:
		if (round_i == 4'ha)
			next_state = end_DA;
		else
			next_state = DA;
		end_DA:
			next_state = wait_P;
		wait_P:
		if (data_valid_i ==1)
			if(block_i ==4'h2)
				next_state=conf_last_P;
			else
				next_state = conf_P;
		else
			next_state = wait_P;
		conf_P:
			next_state = end_conf_P;
		end_conf_P:
			next_state = P;
		P:
		if (round_i == 4'ha)
			next_state = end_P;
		else
			next_state = P;
		end_P:
			next_state = wait_P;
		conf_last_P:
			next_state = end_conf_last_P;
		end_conf_last_P:
			next_state = last_P;
		last_P:
		if (round_i == 4'ha)
			next_state = end_last_P;
		else
			next_state = last_P;
		end_last_P:
			next_state = idle_ag;
		idle_ag:
			next_state = idle;
		default : next_state = idle;


endcase ; // case ( current_state )
end : comb_0


// second combinational process for outputs
always_comb
begin : comb_1
data_sel_o = 0;
	en_reg_state_o = 0;
	en_cipher_o = 0;
	en_tag_o = 0;
	cipher_valid_o = 0; 
	end_o = 0;

	en_block_o = 0;
	en_round_o = 0;
	init_block_o = 0;
	init_a_o = 0;
	init_a_o = 0;

	en_xor_key_o = 0;
	en_xor_lsb_o = 0;
	en_xor_data_o = 0;
	en_xor_key_end_o = 0;
	init_b_o = 0;
case ( current_state )
conf_init:
begin 
	en_block_o = 1;
	en_round_o = 1;
	init_block_o = 1;
	init_a_o = 1;
end
end_conf_init:
begin
	data_sel_o = 1;
	en_reg_state_o = 1;
	en_round_o = 1;

end
	
init : 
begin
	en_reg_state_o = 1;
	data_sel_o=1;
	en_round_o = 1;
end

end_init:
begin
	en_reg_state_o = 1;
	en_xor_key_end_o = 1;
	data_sel_o=1;
end
conf_DA:
begin
	en_round_o = 1;
	init_b_o = 1;
	data_sel_o=1;
end
end_conf_DA:
begin
	en_reg_state_o = 1;
	en_round_o = 1;
	en_xor_data_o = 1;
	data_sel_o=1;
end
DA:
begin
	en_reg_state_o = 1;
	en_round_o = 1;

	data_sel_o=1;
end
end_DA: 
begin
	en_reg_state_o = 1;
	cipher_valid_o = 1; 
	data_sel_o=1;
	en_block_o = 1;
	init_block_o = 1;
	en_xor_lsb_o = 1;
end


wait_P:
begin
	data_sel_o=1;
	cipher_valid_o = 1; 
end
conf_P:
begin
	cipher_valid_o = 1; 
	en_round_o = 1;
	init_b_o = 1;
	data_sel_o=1;
end
end_conf_P:
begin
	en_reg_state_o = 1;
	en_cipher_o = 1;
	cipher_valid_o = 1; 
	data_sel_o=1;
	en_block_o = 1;
	en_round_o = 1;
	en_xor_data_o = 1;
end
P:
begin
	en_reg_state_o = 1;
	cipher_valid_o = 1; 
	en_round_o = 1;
	data_sel_o=1;
end
end_P:
begin
	en_reg_state_o = 1;
	cipher_valid_o = 1; 
	data_sel_o=1;
end
conf_last_P:
begin
	en_round_o = 1;
	init_a_o = 1;
	data_sel_o=1;
end
end_conf_last_P:
begin
	en_reg_state_o = 1;
	en_cipher_o = 1;
	cipher_valid_o = 1; 
	data_sel_o=1;
	en_round_o = 1;
	en_xor_key_o = 1;
	en_xor_data_o = 1;
end
last_P:
begin
	en_reg_state_o = 1;
	cipher_valid_o = 1; 
	en_round_o = 1;
	data_sel_o=1;
end

end_last_P:
begin
	en_reg_state_o = 1;
	cipher_valid_o = 1; 
	end_o = 1;
	en_xor_key_end_o = 1;
	data_sel_o=1;
end
idle_ag:
begin
	cipher_valid_o = 1; 
	en_tag_o = 1;
	end_o = 1;
	data_sel_o=1;
end

endcase ; // case ( current_state )
end : comb_1


endmodule : fsm_moore
