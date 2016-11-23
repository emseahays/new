`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 12:26:40 AM
// Design Name: 
// Module Name: CompareHSync
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


module CompareHSync(
    input [31:0] hCount,
    output reg HS
    );
    
    always@(hCount)
    begin    
        if(hCount>=0&&hCount<=96) begin
            HS<=1;
        end
        else begin
            HS<=0;
        end
        
    end
endmodule
