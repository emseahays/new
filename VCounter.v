`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 10:26:40 AM
// Design Name: 
// Module Name: VCounter
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


module VCounter(
    input En,
    input clk,
    input rst,
    output reg [31:0] vCount
    );
    
    always@(posedge clk, posedge rst)
    begin
        if(rst==1||vCount>=524) begin
            vCount<=0;
        end
        else if(En==1)
        begin
            vCount<=vCount+1;                
        end
    end    
    
endmodule
