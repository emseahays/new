`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2016 04:11:10 PM
// Design Name: 
// Module Name: clock_divider
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2016 02:07:05 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input clk,
    input reset,
    input [9:0] noteFrequency,
    output reg clk_div
    );
   
    
    reg [26:0] count;
    // parameter   freq = 1;    // Desired frequency (assign here or override in top level)
    parameter   maxFreq = 100000000;        // 100MHz 
    parameter   halfFreq = 50000000;        //  50MHz
    
    always @ (posedge clk, posedge reset) begin
        if(reset) begin 
            count <=  0;
        end
        else begin
            count <= count + 1;
            if(count < halfFreq/noteFrequency) begin
                clk_div <= 0;
            end
            else if( count >= maxFreq/noteFrequency - 1) begin
                count <= 0;
            end
            else clk_div <= 1;
        end
    end

endmodule