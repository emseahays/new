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


module ClkDiv_100MHz_to_4000Hz(
    input Clk_In,
input RST,
output reg Clk_Out
);

integer count;
parameter freq=4000; // set this val to desired frequency
parameter max=100000000/freq; //calulates value to count to before reset
always @(posedge Clk_In)
begin

    //Initialize count Or Increment Count
     if (count>=0)
      count <=count +1; 
    else
    count<=0;
    
    //Output Clks accoring to count
    if(count<=max/2) begin 
        Clk_Out<=1'b1; 

    end
    else begin        
        Clk_Out<=1'b0;         
    end
    
    //reset count
    if(count>=max) begin 
        count<=0; 
    end   
    

end
endmodule
