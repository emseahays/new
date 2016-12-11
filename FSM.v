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
input clk,
input rst,          
input continue_btn,   //btnU or spacebar 
input start_btn,            //btnD or Ctrl
input player_dead,    //input comes from PlayerObject Module
input level_complete, //input comes from Scrolls Module
output  [2:0] level,       //goes to Scrolls Modules
output  [2:0] world,       //goes to Obstacles module
output reg [2:0]screen, //1=Play, 2=Lose, 3=Win, 4=L+, 5=W+
output [2:0] lives,   //[2:0]LED
output reg playerDisable, //disable player movement to prevent disrupting game state by
output reg resetSelect
);


//states
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

//state registers            
reg [4:0] currentState;
reg [4:0] nextState;

//registers needed for incrementing and decrementing 
reg [2:0] lives_count; 
reg [2:0] world_count;
reg [2:0] level_count;  

//parameters for state logic
parameter levelMax=3;   //max number of levels per world
parameter worldMax=6;   //max number of worlds per game
parameter startLives=7; //number of lives a player starts with

//parameters for screen display
parameter blankScreen=0;
parameter playScreen=1;
parameter loseScreen=2;
parameter winScreen=3;
parameter levelUpScreen=4;
parameter worldUpScreen=5;

 
//registers for counters 
reg levelEnable; 
reg levelReset; 
reg worldEnable; 
reg worldReset;
reg livesEnable;
reg livesReset;

//DATAPATH   
//counters
counter_2bit levelIncrement(clk,levelReset,levelEnable,level);  
counter_2bit worldIncrement(clk,worldReset,worldEnable,world); 
decrement_2bit livesDecrement(clk,livesReset,livesEnable,lives); 
  
  
  
  
//State Register
always @(posedge clk, negedge rst)
begin
    if (rst == 1) begin
        currentState <= init;
    end
    else begin
        currentState <= nextState;
    end
end

//Next State Logic
always @(*)
begin
// Define the assumed value for all outputs
screen<=blankScreen;   //most of the time the display screen will have no messages to display
playerDisable<=1;       //most of the states should disable player movements to prevent unwanted state transitions
levelEnable<=0; 
levelReset<=0; 
worldEnable<=0; 
worldReset<=0; 
livesEnable<=0; 
livesReset<=0; 
resetSelect=0;

nextState <= currentState; //set to initial state defined in state register

case(currentState)
    init: begin
        //outputs
        livesReset<=1;
        worldReset<=1;
        levelReset<=1;
        screen<=playScreen;
        //transitions
        if(start_btn==1)         nextState<=play;
        else                        nextState<=init;
    end
    play: begin
        //outputs
        playerDisable<=0; //enable player movements
        //transitions
        if(player_dead==1)nextState<=lifeDecr;
        else if(level_complete==1&&level<=levelMax)nextState<=levelInc;
        else if((level>levelMax)&&(world<=worldMax))nextState<=worldInc;
        else if((world>worldMax)&&(level>levelMax))nextState<=win_display;
        else if(lives<=0)nextState<=lose_display;
        else nextState<=play;

    end
    levelInc: begin
        //outputs
//        level<=level_count+1;
            levelEnable<=1;
        //transitions
        if(level<levelMax)nextState<=levelInc_display;
        else nextState<=play;
    end
    levelInc_display: begin
        //outputs
        screen<=levelUpScreen;
        //transitions
        if(continue_btn==1)nextState<=play;
        else nextState<=levelInc_display;
    end
    worldInc: begin
        //outputs
        worldEnable<=1;
        //transitions
        if(world<worldMax)nextState<=worldInc_display;
        else nextState<=play;
    end
    worldInc_display: begin
        //outputs
        screen<=worldUpScreen;
        levelReset<=1;
        //transitions
        if(continue_btn==1)nextState<=play;
        else nextState<=worldInc_display;
    end  
    lifeDecr: begin
        //outputs
        livesEnable<=1;
        playerDisable<=0; //enable player to move out of scroll while decrementing
        //transitions
        nextState<=lifeDecr_wait;
    end
    lifeDecr_wait: begin
        //outputs
        playerDisable<=0; //enable player to move out of scroll while decrementing
        //transitions
        if(player_dead==0) nextState<=play;
        else nextState<=lifeDecr_wait;
    end
    win_display: begin
        //outputs
        screen<=winScreen;
        //transitions
        if(continue_btn==1)nextState<=reset;
        else nextState<=win_display;
    end
    lose_display: begin
        //outputs
        screen<=loseScreen;
        //transitions
        if(continue_btn==1)nextState<=reset;
        else nextState<=lose_display;
    end  
    reset: begin
    //outputs
    resetSelect<=1;
    //transitions
    nextState<=init;

    end  
     default: begin
        //outputs
        //transitions
        nextState <= reset;
     end
endcase    
end
endmodule
