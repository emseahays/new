`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2016 07:39:31 PM
// Design Name: 
// Module Name: decrement_2bit
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


module decrement_2bit(
input clk,
input rst,
input en,
output reg [4:0] count
);

    always@(posedge clk, posedge rst) begin
        if(rst==1) count<=5'b11111;
        else if (en==1) count<=count-1;
        else count<=count;
        end
endmodule
