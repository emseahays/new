`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2016 07:08:16 PM
// Design Name: 
// Module Name: AudioTestFSM
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


module AudioTestFSM(
    input clk,
    input rst,
    input switch,
    output reg [4:0] currentState,
    output pwmPin,
    output ampPin
    );
    
    reg [2:0] audioSelect;  // 0 = nothing, 1 = playing, 2 = levelInc, 3 = worldInc
                            // 4 = lifeDecr 5 = Win 6 = lose
    reg audioEnable;
                            
    reg seqEndSwitch;
    
    parameter   init = 0; 
    parameter   play =1 ;
    parameter   levelInc = 2;
    parameter   levelInc_display = 3;
    parameter   worldInc = 4;
    parameter   worldInc_display = 5;
    parameter   lifeDecr =6;
    parameter   lifeDecr_wait=7;
    parameter   win_display=8;
    parameter   lose_display=9;
    parameter   reset=10;
                    
                    
    reg [3:0]nextState;
    
    always @ (posedge clk, posedge rst) begin
        if(rst) begin
            currentState <= init;
        end 
        else begin
            currentState <= nextState;
        end
    end
    
    always @ (*) begin
        nextState <= currentState;
        audioEnable <= 0;
        case(currentState) 
            init: begin
                audioSelect <= 0;
                if(switch == 1) nextState <= play;
            end            
            play: begin
                audioSelect <= 0;
                if(switch == 0) nextState <= levelInc;
            end
            levelInc: begin
                audioSelect <= 2;
                audioEnable <= 1;
                nextState <= levelInc_display;
            end
            levelInc_display: begin
                if(seqEnd == 1 && switch == 1) nextState <= worldInc;
            end
            worldInc:  begin
                audioSelect <= 2;
                audioEnable <= 1;
                nextState<=worldInc_display;
            end
            worldInc_display:  begin
                if(switch == 0 && seqEnd == 1)nextState <= lifeDecr;
            end
            lifeDecr: begin
                audioSelect <= 4;
                audioEnable <= 1;
                nextState <= lifeDecr_wait;
            end
            lifeDecr_wait: begin
                if(switch == 1 && seqEnd == 1) nextState <= win_display;
            end
            win_display: begin
                audioSelect <= 5;
                audioEnable <= 1;
            end
            lose_display: begin
//                audioSelect <= 6;
//                if(switch == 1 && seqEnd == 1) nextState <=  init;
            end
            
        endcase
    end
    
//    input clk,
//    input rst,
//    input enable,
//    input [2:0] audioSelect,      // from FSM
//    output seqEnd,          // to FSM   
//    output pwmPin,          // to GAME 
//    output ampPin           // to GAME   
    Audio A1_test(clk, rst, audioEnable, audioSelect, seqEnd, pwmPin, ampPin);
    
endmodule
