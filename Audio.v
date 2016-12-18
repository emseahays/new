`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2016 02:48:10 PM
// Design Name: 
// Module Name: Audio
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


module Audio(
    input clk,
    input rst,
    input enable,
    input [2:0] audioSelect,      // from FSM
    output reg audioEnd,          // to FSM   
    output pwmPin,                // to GAME 
    output ampPin                 // to GAME  
    );
    
    // Take in a enable signal from FSM for 1 clk cycle
    
    always @(posedge enable, posedge seqEnd)begin
        if(enable) audioEnd <= 0;                   // Turns off seqEnd when FSM enables a sequence 
        else if(seqEnd) audioEnd <= 1;              // Turns on seqEnd when sequnce is finished
    end
    
    wire [3:0] noteSelect;    // from audioSequence to FreqsMux
    
 
    // Frequency Select (stores all used frequencies)
//    input clk,
//    input rst,
//    input [3:0] noteSelect,
//    output pwmPin,
//    output ampPin
    FreqsMux FM1 (clk, rst, noteSelect, pwmPin, ampPin);
    
//    input clk,
//    input reset,
//    input enable,         
//    input [2:0] audioSelect,
//    output reg [3:0] noteSelect,
//    output reg seqEnd

    // imbedded sequences for all screen
    audioSequence AS1 (clk, rst, enable, audioSelect, noteSelect, seqEnd);
        


endmodule
