/*
-------------------------------------------------------------------------------
-- Title      : testbench du chiffrement en entier
-- Project    : ASCON
-------------------------------------------------------------------------------
-- File	      : ascon_top_tb.sv
-- Author     : Hajar IDJAHA  
-------------------------------------------------------------------------------
*/

`timescale 1ns/1ps
import ascon_pack::*;
module ascon_top_tb();



logic clock_tb_s;
logic resetb_tb_s;
logic start_tb_s; 
logic[63:0] data_tb_s;
logic [127:0] key_tb_s;
logic [127:0] nonce_tb_s;	
logic data_valid_tb_s;
logic cipher_valid_tb_s;
logic[63:0] cipher_tb_s; 
logic [127:0] tag_tb_s;
logic end_tb_s;



ascon_top ascon_top_inst (
	.clock_i(clock_tb_s),
	.resetb_i(resetb_tb_s),
	.start_i(start_tb_s),
	.data_i(data_tb_s),
	.key_i(key_tb_s),
	.nonce_i(nonce_tb_s),	
	.data_valid_i(data_valid_tb_s),
	.cipher_valid_o(cipher_valid_tb_s),
	.cipher_o(cipher_tb_s),
	.tag_o(tag_tb_s),
	.end_o(end_tb_s)
    );

initial
begin

	clock_tb_s = 0;
	forever #50 clock_tb_s = ~clock_tb_s;
end


initial 
begin
		key_tb_s = 128'h8a55114d1cb6a9a2be263d4d7aecaaff;
		nonce_tb_s = 128'h4ed0ec0b98c529b7c8cddf37bcd0284a;
	
        resetb_tb_s = 1'b0;
        data_valid_tb_s = 1'b0;
        start_tb_s = 1'b0;

	#100;
	
end

initial
begin


	resetb_tb_s = 1'b1;
	#20;
	start_tb_s = 1'b1;
 
	data_valid_tb_s = 1'b1;
	data_tb_s = 64'h80400C0600000000;
	#1300; 
	start_tb_s = 1'b0;
	data_valid_tb_s = 1'b1;
	data_tb_s = 64'h4120746f20428000;
        
	#850; 


	data_valid_tb_s = 1'b1;
	data_tb_s = 64'h5244562061752054;
        
	#650; 

	data_valid_tb_s = 1'b1;
	data_tb_s = 64'h6927626172206365;
        
	#650; 
	data_tb_s = 64'h20736f6972203f80;

	data_valid_tb_s = 1'b1;
	#260;
      
end


endmodule : ascon_top_tb



