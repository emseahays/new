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
input [2:0] sel,
input en,
output  pwmPin,
output  ampPin
    );

 assign ampPin = en;
 //wire clk5000Hz;
 wire [3:0] freqs; //freqs[3] = clk5000Hz
 ClkDiv_100MHz_to_4000Hz M10a (clk, rst, freqs[3]);
 Counter3Bit M10b (freqs[3], rst, en, freqs[2:0]);
 FreqsMux M10c (freqs, sel, pwmPin);
 
 

    
    
    
endmodule
