`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2016 03:09:11 PM
// Design Name: 
// Module Name: FreqsMux
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


module FreqsMux(
input [3:0] freqs, 
input [2:0] sel, 
output reg pwmPin
    );
  
always@(sel) 
    begin
        case(sel)
        3'b100:begin            //up
            pwmPin<=freqs[3]; 
        end
        3'b101:begin            //right
            pwmPin<=freqs[2];
        end
        3'b110:begin            //down
            pwmPin<=freqs[1];
        end
        3'b111:begin            //left
            pwmPin<=freqs[0];
        end
        default: pwmPin<=0;     //off
    
        endcase
    end
    
endmodule
