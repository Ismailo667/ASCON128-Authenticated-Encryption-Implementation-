`timescale 1ns / 1ps

module diffusion_layer_tb import ascon_pack::*;

(
        //rien
);

        type_state diffusion_layer_i;
        type_state diffusion_layer_o;


        //DUT
        diffusion_layer DUT (
                .diffusion_i(diffusion_layer_i),
                .diffusion_o(diffusion_layer_o)
        );

        initial begin
                diffusion_layer_i[0]=64'h78e2cc41faabaa1a;
                diffusion_layer_i[1]=64'hbc7a2e775aababf7;
                diffusion_layer_i[2]=64'h4b81c0cbbdb5fc1a;
                diffusion_layer_i[3]=64'hb22e133e424f0250;
                diffusion_layer_i[4]=64'h044d33702433805d;
        end

endmodule : diffusion_layer_tb

