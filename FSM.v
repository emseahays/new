`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2016 12:25:20 PM
// Design Name: 
// Module Name: FSM
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


module FSM(
    input startButton,
    input [1:0] playerStatus, // 0 = playing 1 = levelpass 2 = died
    input clk,
    input reset,
    output reg [2:0] gameStatus,  //0 = start, 1 = playing, 2 = levelInc, 3 = worldInc, 4 = livesInc, 5= loseGame, 6 = winGame
    output reg [1:0] world,
    output reg [2:0] level,
    output reg [3:0] lives
    );
    
    // States
    reg [2:0] currentState;
    reg [2:0] nextState;
    
    // Temporary Increment/ Decrement 
    reg [2:0] levelTemp;
    reg worldTemp;
    reg [3:0] livesTemp;
    
    parameter initialState = 0;
    parameter playGame = 1;
    parameter levelInc = 2;
    parameter worldInc = 3;
    parameter livesDec = 4;
    parameter loseGame = 5;
    parameter winGame = 6;
    
    //Player Status
    parameter playing = 0;
    parameter levelPass = 1;
    parameter died = 2;
    
    // Max values
    parameter maxLevel = 6;
    parameter maxWorld = 2;
    parameter maxLives = 3;
    
    reg enable;
    
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            currentState <= initialState;
        end
        else begin
            currentState <= nextState;
        end
    end
    
    always@(*) begin
        nextState <= currentState;
        case(currentState)
            initialState: begin
                gameStatus <= 0;
                level <= 0;
                levelTemp = 0;
                world <= 0;
                worldTemp <= 0;
                lives <= maxLives;
                livesTemp <= 0;
                enable <= 0;
                    //if(startButton) nextState <= playGame;
                nextState <= playGame;
            end
            playGame:begin
                gameStatus <= 1;
                if(playerStatus == levelPass)begin
                    levelTemp <= level;
                    worldTemp <=  world;
                    nextState <= levelInc;
                end
                else if (playerStatus == died)begin
                    livesTemp <= lives;
                    nextState <= livesDec;
                end
            end
            levelInc: begin
                gameStatus <= 2;
                level <= levelTemp + 1; // increment Level
                if (playerStatus == 0) enable <= 1;
                if (endTime == 1) begin 
                    enable <= 0;
                    if( level == maxLevel)nextState <=  worldInc;
                    else nextState <=  playGame;
                end
            end
            worldInc: begin
                gameStatus <= 3;
                level <= 0;
                world <= worldTemp + 1;
                enable <= 1;
                if (endTime == 1) begin
                    enable <= 0;
                    if(world == maxWorld) nextState <= winGame;
                    else nextState <= playGame;
                end
            end
            livesDec: begin
                gameStatus <= 4;
                lives <= livesTemp - 1;
                enable <= 1;
                if (endTime == 1) begin
                    enable <= 0;
                    if(lives == 0) nextState <= loseGame;
                    else nextState <= playGame;
                end
            end
            loseGame: begin
                gameStatus <= 5;
                if(startButton) nextState <= initialState;
            end
            winGame: begin
                gameStatus <= 6;
                if(startButton) nextState <= initialState;
            end
        endcase
    end
    
    textDisplayCounter TDC1 (clk, reset, enable, endTime);
        
    
endmodule
