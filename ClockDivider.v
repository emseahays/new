`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 10:26:40 AM
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider(
    input Clk_In,
    input RST,
    output reg Clk_Out,
    output reg btnClk
    );
//CLK 1
    integer count1;
    parameter freq1=25175000; // set this val to desired frequency
    parameter max1=100000000/freq1; //calulates value to count to before reset
    always @(posedge Clk_In)
    begin

        //Initialize count Or Increment Count
         if (count1>=0)
          count1 <=count1 +1; 
        else
        count1<=0;
        
        //Output Clks accoring to count
        if(count1<=max1/2) begin 
            Clk_Out<=1'b1; 

        end
        else begin        
            Clk_Out<=1'b0;         
        end
        
        //reset count
        if(count1>=max1) begin 
            count1<=0; 
        end   
        

    end
    
 //CLK 2 - BTNcLK --AFFECTS HOW FAST THE PLAYER OBJECT MOVES
 
 integer count2;
 parameter freq2=320; // set this val to desired frequency
 parameter max2=100000000/freq2; //calulates value to count to before reset
 always @(posedge Clk_In)
 begin

     //Initialize count Or Increment Count
      if (count2>=0)
       count2 <=count2 +1; 
     else
     count2<=0;
     
     //Output Clks accoring to count
     if(count2<=max2/2) begin 
         btnClk<=1'b1; 

     end
     else begin        
         btnClk<=1'b0;         
     end
     
     //reset count
     if(count2>=max2) begin 
         count2<=0; 
     end   
     

 end   

    
endmodule
