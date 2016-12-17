`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2016 08:22:11 PM
// Design Name: 
// Module Name: sequenceEndMux
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


module sequenceEndMux(
    input audioSelect,
    input seqEnd2,
    input seqEnd3,
    input seqEnd4,
    input seqEnd5,
    input seqEnd6,
    output reg seqEnd
    );
    
    
    always @ (*) begin
        case(audioSelect)
            0: begin
                seqEnd <= 0;
            end
            1: begin
                seqEnd <= 0;
            end
            2: begin
                seqEnd <= seqEnd2;
            end
            3: begin
                seqEnd <= seqEnd3;
            end
            4: begin
                seqEnd <= seqEnd4;
            end
            5: begin
                seqEnd <= seqEnd5;
            end
            6: begin
                seqEnd <= seqEnd6;
            end
        endcase
    end
endmodule
