`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2016 01:13:11 PM
// Design Name: 
// Module Name: textDisplayCounter
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


module textDisplayCounter(
    input clk,
    input reset,
    input enable,
    output reg endTime
    );
    
    integer count;
    integer countTemp;
    
    parameter maxCount = 10;
    
    always @ (posedge clk, posedge reset) begin
        if(reset) begin
            endTime <= 0;
            count <= 0;
            countTemp <= 0;
        end
        else begin
            endTime <= 0;
            count <= 0;
            countTemp <=  count;
            if(enable)begin
                count <= countTemp + 1;
                if(count == maxCount) begin
                    endTime <= 1;
                end
            end
            else endTime <= 0;           
        end
    end
endmodule
