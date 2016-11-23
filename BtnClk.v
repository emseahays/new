`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2016 06:48:34 PM
// Design Name: 
// Module Name: BtnClk
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


module BtnClk(
    input Clk_In,
    input rst,
    output reg btnClk
);


//CLK 2 - BTNcLK --AFFECTS HOW FAST THE PLAYER OBJECT MOVES

integer count;
parameter freq=320; // set this val to desired frequency
parameter max=100000000/freq; //calulates value to count to before reset

always @(posedge Clk_In)
begin
if(rst==1)
begin
    count<=0;
end

else
begin
     //Initialize count Or Increment Count
      if (count>=0)
       count <=count +1; 
     else
     count<=0;
     
     //Output Clks accoring to count
     if(count<=max/2) begin 
         btnClk<=1'b1; 
    
     end
     else begin        
         btnClk<=1'b0;         
     end
     
     //reset count
     if(count>=max) begin 
         count<=0; 
     end   
     
    
    end  
end 

endmodule
