//ISMAIL EL BATTAHI
//13/03/2024

//stimuli de test


import ascon_pack::*;
`timescale 1ns / 1ps

module ascon_sbox_tb(
);

	logic[4:0] sbox_i_s;
	logic[4:0] sbox_o_s;

	ascon_sbox_DUT (
		.sbox_i(sbox_i_s),
		.sbox_o(sbox_o_s)
);

initial begin
	integer i;
	for (i=0;i<32;i++) begin
		sbox_i_s = i;
		#50
	end
end
endmodule : ascon_sbox_tb