`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 10:37:58 PM
// Design Name: 
// Module Name: PlayerRectangle
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


module PlayerRectangle(

    input upEnable,
    input downEnable,
    input leftEnable,
    input rightEnable,
    
    input rst,
    input btnClk,
    input   [3:0] btns,
    input   [3:0] color,
    input  [11:0] vStartPos,
    input  [11:0] hStartPos,
    input  [11:0] objWidth,
    input  [11:0] objHeight,
    output  [11:0] vStartPos_o,
    output  [11:0] hStartPos_o,
    output  [11:0] objWidth_o,
    output  [11:0] objHeight_o,
    output reg [31:0] vOffset,
    output reg [31:0] hOffset,
    output reg [11:0] hPos,
    output reg [11:0] vPos,
    output [3:0] color_o,
    output reg player_dead
    
    
    //output reg [2:0] status       //blocked, alive, dead, moving

    );
    assign color_o= color;

    assign vStartPos_o=vStartPos;
    assign hStartPos_o=hStartPos;
    assign objWidth_o=objWidth;
    assign objHeight_o=objHeight;
    

    reg player_dead_tmp;
        // State Variables
       reg [1:0] currentState;
       reg [1:0] nextState;
       
       parameter   waitState   = 0;
       parameter   buttonPress = 1;
       parameter   buttonHold  = 2;
                   
       // 
       reg [3:0] buttons_temp;
    
//=============================================================
//FINITE STATE MACHINE
//=============================================================
         //State Register
         always @(posedge btnClk, posedge rst) begin
             if(rst) currentState <= waitState;
             else currentState <=  nextState;
         end
        //State Logic
         always @ (*) begin
               nextState <=  currentState;
               case(currentState) 
                   waitState: begin
                       if(player_dead_tmp != 1'd0) begin             // If button is pressed go to next state
                           nextState <= buttonPress;
                       end
                   end
                   buttonPress: begin
                       player_dead <= player_dead_tmp;             // Output last saved button input until time is up.
                       nextState <=  buttonHold;
                   end
                   buttonHold: begin
                       player_dead <= 1'd0;               // Return output to 0 after 1 clk cycle 
                       if(player_dead_tmp==4'd0) begin                 // When there are no button presses, return to wait state
                           nextState <= waitState;
                       end
                       else nextState<=buttonHold;
                       end
                   default: begin   
                   player_dead <= 1'd0;                                 
                   end            
               endcase
           end    

//update player status
always@(upEnable,downEnable,leftEnable,rightEnable)
begin
    if(upEnable==1&&downEnable==1&&leftEnable==1&&rightEnable==1) player_dead_tmp<=1;
    else player_dead_tmp<=0;

end



    //update objects location

    always@(posedge btnClk, posedge rst) begin
        if(rst==1) begin
            vOffset<=0;
            hOffset<=0;        
        end
        else begin
            case(btns)
                8: begin //btnU 
                    if(upEnable==1) begin
                        if(vOffset+vStartPos>0)begin 
                             vOffset<=vOffset-12;
                        end
                        else begin
                            vOffset<=480-objHeight-vStartPos;
                        end
                    end
                end
                4:begin //btnD
                    if(downEnable==1) begin
                        if(!(upEnable==1&&vOffset+vStartPos>=480)) vOffset<=vOffset+12;
                        else vOffset<=0-vStartPos;
                    end
                end
                2:begin //btnR
                    if(rightEnable==1) begin
                        if(!(hStartPos>=640-objWidth-hOffset)) hOffset<=hOffset+12;
                        else  hOffset<=0-hStartPos;
                    end
                end
                1:begin //btnL
                    if(leftEnable==1) begin
                        if(hStartPos+hOffset>0)  hOffset<=hOffset-12;
                        else hOffset<=640-objWidth-hStartPos;
                    end
                end
                default:begin //else do nothing    
                end
            endcase
        end
        hPos<=hStartPos+hOffset;
        vPos<=vStartPos+vOffset;       
    end
endmodule