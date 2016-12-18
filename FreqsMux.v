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
    input clk,
    input rst,
    input [3:0] noteSelect,
    output pwmPin,
    output reg ampPin
    );
    
    // assign ampPin = 1;
    
    reg [9:0] noteFrequency;
    
    parameter A = 440;     //0
    parameter B = 494;     //1
    parameter C = 524;     //2
    parameter D = 587;     //3
    parameter E = 659;     //4
    parameter F = 698;     //5
    parameter G = 784;     //6
    
  
    always@(noteSelect)begin
        noteFrequency <= A;
        ampPin <= 0;
        case(noteSelect)
            0: begin noteFrequency <= A; ampPin <= 1; end
            1: begin noteFrequency <= B; ampPin <= 1; end
            2: begin noteFrequency <= C; ampPin <= 1; end
            3: begin noteFrequency <= D; ampPin <= 1; end
            4: begin noteFrequency <= E; ampPin <= 1; end
            5: begin noteFrequency <= F; ampPin <= 1; end
            6: begin noteFrequency <= G; ampPin <= 1; end
            7: ampPin = 0;
        endcase
    end
    
    clock_divider FreqClkDiv1 (clk, rst, noteFrequency, pwmPin);
        

endmodule

    

