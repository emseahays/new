`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 12:26:40 AM
// Design Name: 
// Module Name: CompareVSync
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


module CompareVSync(
    input [31:0] vCount,
    output reg VS
    );
    
        always@(vCount)
    begin    
        if(vCount>=0&&vCount<=2) begin
            VS<=1;
        end
        else begin
            VS<=0;
        end
        
    end
endmodule
