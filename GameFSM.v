`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2016 07:58:51 PM
// Design Name: 
// Module Name: GameFSM
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


module GameFSM(
    input clk,
    input reset,
    input levelPassed,            // If player passes level
    output reg [2:0] level,
    output reg world
    );
    
    reg [2:0] currentState;
    reg [2:0] nextState;
    
    reg levelPassedToggle;  //  ensures levelPassed resets to zero. 
    reg levelTemp;       // Temporary level reg for incrementation.
    
    parameter initialState = 0;
    parameter World1 = 1;
    parameter World2 = 2;
    parameter winLevel = 3;
    parameter winWorld = 4;
    parameter winGame = 5;
    parameter Lose = 6;
    
    parameter maxLevel = 5;
    
    
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            currentState <= initialState;
        end
        else begin
            currentState <= nextState;
        end
    end
    
    always @ (*) begin
        nextState  <= currentState;
        world <= 0;
        levelTemp <= level;
        case(currentState)
            initialState: begin
                // Set any Initial values here
                level <= 0;
                levelTemp <= 0;
                nextState <= World1;
            end
            World1: begin
                world <= 0;
                if(levelPassed) begin
                    level <= levelTemp + 1; // increment level
                    if (level == maxLevel) begin
                        level <= 0;
                        nextState <= World2;
                    end
                    else nextState <= winLevel;
                end
                else if() begin
                
                end
                
                
            end
            
        endcase
    end
    
    
endmodule
