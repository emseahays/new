`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2016 01:26:26 PM
// Design Name: 
// Module Name: DimCounter
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


module DimCounter(
input clk,
input rst,
input En,
output reg [3:0] count
);


always@(posedge clk, posedge rst)
begin
    if(rst==1) begin
        count<=0;
    end
    else if(En==0) count<=count+1;  
    else if(En==1&&count==0)
    count<=4'b1111;
             

end
endmodule
