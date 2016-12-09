`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2016 09:03:19 PM
// Design Name: 
// Module Name: DestRect
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


module DestRect(
input rst,                  //reset
input visible,              //whether or not destination rectangle is visible
input [3:0] rect_color,     //color of Destination Rectangle
input [11:0] player_hPos,   //
input [11:0] player_vPos,
input  [11:0] vStartPos,
input  [11:0] hStartPos,
output  [11:0] vStartPos_o,
output  [11:0] hStartPos_o,
output [3:0] rect_color_o,
output visible_o,
output reg level_complete
    );
    
    
    assign rect_color_o = rect_color;    
    assign vStartPos_o=vStartPos;
    assign hStartPos_o=hStartPos;
    assign visible_o=visible;
    
always@( *) begin
    
        if(rst==1)
        begin
        
        end
        else begin
       if((player_vPos == vStartPos ) // inside rectangle
       && (player_hPos == hStartPos))
       begin
           level_complete<=1;
       end
       else
       begin
            level_complete<=0;
        end
   end
    end
endmodule
