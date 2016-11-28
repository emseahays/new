`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2016 02:39:36 PM
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
    input levelPassed,              // If player passes level
    input lose,                      // If player losses
    output reg [2:0] level,         // Current game level
    output reg world,               // Current game world
    output reg [2:0] gameStatus           // 0 = playing, 1 = level win, 2 = world win, 3 = Game win, 4 = gameOver
    );
    
    reg [2:0] currentState;
    reg [2:0] nextState;
    
    reg [2:0] levelTemp;       // Temporary level reg for incrementation.
    
    parameter initialState = 0;
    parameter World0 = 1;
    parameter World1 = 2;
    parameter winLevel = 3;
    parameter winWorld = 4;
    parameter winGame = 5;
    parameter gameOver = 6;
    
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
        case(currentState)
            initialState: begin
                // Set any Initial values here
                world <= 0;
                gameStatus <= 0;
                level <= 0;
                levelTemp <= 0;
                nextState <= World0;
            end
            World0: begin
                world <= 0;
                gameStatus <= 0;
                if(levelPassed == 1) begin
                    level <= levelTemp + 1; // increment level
                    if (level == maxLevel + 1) begin
                        nextState <= winWorld;
                    end
                    else nextState <= winLevel;
                end
                else if (lose == 1) nextState <= gameOver; 
                else levelTemp <= level;
            end
            World1: begin
                world <= 1;
                gameStatus <= 0;
                if(levelPassed) begin
                    level <= levelTemp + 1; // increment level
                    if (level == maxLevel + 1) begin
                        nextState <= winWorld;
                    end
                    else nextState <= winLevel;
                end
                else if(lose) nextState <= gameOver;
                else levelTemp <= level;
            end
            winLevel: begin
                // Win level sequence
                gameStatus <= 1;
                if (!levelPassed && world == 0)nextState <= World0;
                else if (!levelPassed && world == 1)nextState <= World1;

            end
            winWorld: begin
                // Win World Sequence                 
                gameStatus <= 2;  
                level <= 0;
                levelTemp <= 0;              
                if (!levelPassed && world == 0) nextState <=  World1;     // May need altering, depending on number of worlds.
                else if(!levelPassed && world == 1) nextState <= winGame;
            end
            winGame: begin
                // Win Game Sequence
                gameStatus <= 3;
                // nextState?
            end
            gameOver: begin
                // Lose Sequenece
                gameStatus <= 4;
                // nextState?
            end            
        endcase
    end
endmodule
