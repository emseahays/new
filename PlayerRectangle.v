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
input slowClk,
input playerDisable,
    input upEnable,
    input downEnable,
    input leftEnable,
    input rightEnable,
    
    input rst,
    input btnClk,
    input   [3:0] btns,
    input   [3:0] color,
    input  [9:0] vStartPos,
    input  [9:0] hStartPos,
    input  [9:0] objWidth,
    input  [9:0] objHeight,
    output  [9:0] vStartPos_o,
    output  [9:0] hStartPos_o,
    output  [9:0] objWidth_o,
    output  [9:0] objHeight_o,
    output reg [31:0] vOffset,
    output reg [31:0] hOffset,
    output reg [9:0] hPos,
    output reg [9:0] vPos,
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
       reg  currentState;
       reg  nextState;
       
       parameter   btnWait   = 0;
       parameter   getButton = 1;

       reg dead_fsm_tmp;           

    
////=============================================================
////FINITE STATE MACHINE
////=============================================================
//         //State Register
//         always @(posedge btnClk, posedge rst) begin
//             if(rst) currentState <= btnWait;
//             else currentState <=  nextState;
//         end
//        //State Logic
//         always @ (*) begin
//                player_dead <= 0; //default to playerDead signal is 0
//               nextState <=  currentState;
//               case(currentState) 
//                   btnWait: begin
//                       dead_fsm_tmp<=player_dead_tmp; 
//                       if(player_dead_tmp ==1) begin             // If button is pressed go to next state
//                           nextState <= getButton;
//                       end
//                       else nextState<=btnWait;
//                   end
//                   getButton: begin
//                      player_dead<=1;      //output signal for only 1 clk cycle
//                       nextState <=  btnWait;
//                   end     
//                   default: begin
//                   nextState<=btnWait;     
                               
//                   end            
//               endcase
//           end    

//update player status
always@( upEnable, downEnable, leftEnable, rightEnable)
begin
    if(upEnable==0&&downEnable==0&&leftEnable==0&&rightEnable==0) player_dead<=1;
    else player_dead<=0;
end

//always@(posedge slowClk)begin
//if(upEnable==0&&downEnable==0&&leftEnable==0&&rightEnable==0) player_dead<=1;
//else player_dead<=0;
//end


    //update objects location

    always@(posedge btnClk, posedge rst) begin
        if(rst==1) begin
            vOffset<=0;
            hOffset<=0;
            hPos<=0;
            vPos<=0;
            //player_dead<=0;                   
        end
        else if(playerDisable==0) begin 
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
                        if(!(vOffset+vStartPos>=480)) vOffset<=vOffset+12;
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