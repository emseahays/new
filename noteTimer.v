`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2016 01:03:41 AM
// Design Name: 
// Module Name: noteTimer
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


module noteTimer(
    input clk,
    input reset,
    input enable,
    output reg timeEnd
    );
    
    integer count;
    integer maxCount = 25000000;
    // integer maxCount = 50;
    
    always @ (posedge clk, posedge reset) begin
        if(reset)begin
            count <= 0;
            timeEnd <= 0;
        end
        else begin
            timeEnd <= 0;
            if(enable) begin
                count <= count + 1;
                if(count == maxCount) begin
                    count <= 0;
                    timeEnd <= 1;
                end
            end
        end
    end
    
    
    
    
endmodule
