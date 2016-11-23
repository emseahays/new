`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2016 11:56:53 AM
// Design Name: 
// Module Name: Decoder_4to3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder_4to3(
input btnU, 
input btnD, 
input btnR, 
input btnL, 
output reg [2:0] out2muxSel
    );
    reg [3:0] btn;
    always@(btnU, btnD, btnR,btnL)
        begin
        btn[3]<=btnU;
        btn[2]<=btnD;
        btn[1]<=btnR;
        btn[0]<=btnL;

        case(btn)
            4'b0001:  out2muxSel<= 3'b100; 
            4'b0010:  out2muxSel<= 3'b101; 
            4'b0100:  out2muxSel<= 3'b110; 
            4'b1000:  out2muxSel<= 3'b111; 
            default: out2muxSel<= 3'b000;
        endcase
    end
endmodule
