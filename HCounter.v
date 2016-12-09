`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 10:26:40 AM
// Design Name: 
// Module Name: HCounter
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


module HCounter(
    input clk,
    input rst,
    output reg [31:0] hCount,
    output reg TC
    );
    
    
    always@(posedge clk, posedge rst)
    begin
        if(rst==1) begin
            hCount<=0;
        end
        else if(hCount>=799)begin
            hCount<=0;
            TC<=1;
        end
        else
        begin
            hCount<=hCount+1;  
            TC<=0;              
        end
    end
    
endmodule
