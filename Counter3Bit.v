`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2016 03:04:56 PM
// Design Name: 
// Module Name: Counter3Bit
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


module Counter3Bit(
input clk,
input rst,
input En,
output reg [2:0] count
);


always@(posedge clk, posedge rst)
begin
    if(rst==1) begin
        count<=0;
    end
    else if(En==1) count<=count+1;  
    else if(En==0&&count==0)
    count<=4'b1111;
             

end
endmodule