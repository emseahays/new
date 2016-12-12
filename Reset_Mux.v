`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2016 02:35:12 AM
// Design Name: 
// Module Name: Reset_Mux
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


module Reset_Mux(
    input userReset,   //btnC
    input resetSelect, //select signal
    output reg rst    
    );
    
    always@(*)begin
        case(resetSelect)
        0: begin rst<=userReset; end
        1: begin rst<=1; end
        endcase
    end
endmodule
