`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2016 04:37:03 PM
// Design Name: 
// Module Name: audioMux
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


module audioMux(
    input rst,
    input audioSelect, 
    input pwmSel1,                                 
    input pwmSel2,
    input pwmSel3,
    input pwmSel4,           
    output reg  pwmSelect
    );
    
    always @(*)begin
        case(audioSelect)
            0: pwmSelect = 0;
            1: pwmSelect = pwmSel1; 
            2: pwmSelect = pwmSel2;
            3: pwmSelect = pwmSel3;
            4: pwmSelect = pwmSel4;           
        endcase
    end
    
    
endmodule
