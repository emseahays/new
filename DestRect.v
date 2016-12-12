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
input clk,
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

    reg level_complete_tmp;
        // State Variables
       reg [1:0] currentState;
       reg [1:0] nextState;
       
       parameter   waitState   = 0;
       parameter   buttonPress = 1;
       parameter   buttonHold  = 2;
                   

    
//=============================================================
//FINITE STATE MACHINE
//=============================================================
         //State Register
         always @(posedge clk, posedge rst) begin
             if(rst) currentState <= waitState;
             else currentState <=  nextState;
         end
        //State Logic
         always @ (*) begin
               level_complete<=0;         //default to level_complete=0 if not otherwise specified
               nextState <=  currentState;
               case(currentState) 
                   waitState: begin
                       if(level_complete_tmp != 1'd0) begin             // If button is pressed go to next state
                           nextState <= buttonPress;
                       end
                   end
                   buttonPress: begin
                       level_complete <= level_complete_tmp;             // Output last saved button input until time is up.
                       nextState <=  buttonHold;
                   end
                   buttonHold: begin
                       level_complete <= 1'd0;               // Return output to 0 after 1 clk cycle 
                       if(level_complete_tmp==1'd0) begin                 // When there are no button presses, return to wait state
                           nextState <= waitState;
                       end
                       else nextState<=buttonHold;
                       end
                   default: begin
                   nextState<=waitState;   
                   level_complete <= 1'd0;                                 
                   end            
               endcase
           end    





    
always@( *) begin
    
        if(rst==1)
        begin
        level_complete_tmp<=0;
        end
        else begin
       if((player_vPos == vStartPos ) // inside rectangle
       && (player_hPos == hStartPos))
       begin
           level_complete_tmp<=1;
       end
       else
       begin
            level_complete_tmp<=0;
        end
   end
    end
endmodule
