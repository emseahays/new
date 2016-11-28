`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2016 05:36:10 PM
// Design Name: 
// Module Name: color_clock
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
// Create Date: 10/13/2016 03:04:41 PM
// Design Name: 
// Module Name: ClkDiv_100MHz_to_5000Hz
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


module color_clock( 
    input clk,
    output reg clk_out
);

integer count;
parameter freq=1; // 1Hert
parameter max=100000000/freq; 
    always @(posedge clk)
    begin

    //Initialize count Or Increment Count
        if (count>=0)
            count <=count +1; 
        else
        count<=0;
    
    //Output Clks accoring to count
        if(count<=max/2) begin 
            clk_out<=1'b1; 

        end
        else begin        
            clk_out<=1'b0;         
        end
    
    //reset 
    if(count>=max) begin 
        count<=0; 
    end   
    

end
endmodule
