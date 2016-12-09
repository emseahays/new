`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2016 08:37:25 PM
// Design Name: 
// Module Name: Screens
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


module Screens(
input [2:0] world,
input [11:0] player_hPos,
input [11:0] player_vPos,
input [3:0] player_color,
input rst,                              
input btnClk,                           //speed of movement - depend on clk speed
input [3:0] btns,                       //direction of movement
output   [11:0] vStartPos[23:0][5:0],
output  [11:0] hStartPos[23:0][5:0],
output  [11:0] objWidth [23:0][5:0],
output  [11:0] objHeight[23:0][5:0],
output  [31:0] vOffset[23:0][5:0],
output  [31:0] hOffset[23:0][5:0],
output [3:0] color_o[23:0][5:0],
output upEnable[23:0][5:0],
output downEnable[23:0][5:0],
output leftEnable[23:0][5:0],
output rightEnable[23:0][5:0],
output reg visible[23:0][5:0]
//output reg [31:0] hPos[3:0][5:0],
//output reg [31:0] vPos[3:0][5:0]
    );
    
    
    
    //COLORS
    parameter red=2;
    parameter cyan=3;
    parameter yellow=4;
    parameter magenta=5;
    parameter white=6;      //for walls
    parameter green=7;      //for destination
    
    
    //PASSABLE - can pass on color match if passable (like a scroll)
    parameter pass=1;
    parameter noPass=0;
    
    
    //SCROLLING DIRECTIONS
    parameter left=   4'b0001;
    parameter right= 4'b0010;
    parameter down= 4'b0100;
    parameter up=4'b1000;
    parameter notMoving=4'd0;
    
    //DEFAULT START POSITION - all should use this, then use excel sheet to set offset position
    parameter vDefault_pos=12;
    parameter hDefault_pos=128;
    
    //DEFAULT SIZE
    parameter wSize=12;     //used to set size but also to find location in recangle argument
    parameter vSize=wSize;  //used to set size but also to find location in recangle argument
    parameter size=vSize;   //used to make slightly more readable
    
    
    


    
    /*input [3:0] color,
    input passable,
    input [31:0] plr_hPos,
    input [31:0] plr_vPos,
    input rst,
    input btnClk,
    input [3:0] btns,
    input  [31:0] vStartPos,
    input  [31:0] hStartPos,
    input  [31:0] objWidth,
    input  [31:0] objHeight,
    output  [31:0] vStartPos_o,
    output  [31:0] hStartPos_o,
    output  [31:0] objWidth_o,
    output  [31:0] objHeight_o,
    output reg [31:0] vOffset,
    output reg [31:0] hOffset,
    output [3:0] color_o*/
    
    reg  screen_0_visible;
    reg  screen_1_visible;
    reg  screen_2_visible;
    reg  screen_3_visible;
    reg  screen_4_visible;
    reg  screen_5_visible;
    
always@(world) begin
    if(world==0)begin
        screen_0_visible<=1;
        screen_1_visible<=0;
        screen_2_visible<=0;
        screen_3_visible<=0;
        screen_4_visible<=0;
        screen_5_visible<=0;  
     end
    else if(world==1)begin 
        screen_0_visible<=0; 
        screen_1_visible<=1; 
        screen_2_visible<=0; 
        screen_3_visible<=0; 
        screen_4_visible<=0; 
        screen_5_visible<=0;     end
    else if(world==2)begin 
        screen_0_visible<=0; 
        screen_1_visible<=0; 
        screen_2_visible<=1; 
        screen_3_visible<=0; 
        screen_4_visible<=0; 
        screen_5_visible<=0;     end
    else if(world==3)begin 
        screen_0_visible<=0; 
        screen_1_visible<=0; 
        screen_2_visible<=0; 
        screen_3_visible<=1; 
        screen_4_visible<=0; 
        screen_5_visible<=0;     end
    else if(world==4)begin 
        screen_0_visible<=0; 
        screen_1_visible<=0; 
        screen_2_visible<=0; 
        screen_3_visible<=0; 
        screen_4_visible<=1; 
        screen_5_visible<=0;     end
    else if(world==5)begin 
        screen_0_visible<=0; 
        screen_1_visible<=0; 
        screen_2_visible<=0; 
        screen_3_visible<=0; 
        screen_4_visible<=0; 
        screen_5_visible<=1;         end
    else 
    begin
        screen_0_visible<=1;  
        screen_1_visible<=0; 
        screen_2_visible<=0; 
        screen_3_visible<=0; 
        screen_4_visible<=0; 
        screen_5_visible<=0; 
   
        end
    
    end
    
//==============================================================================================================================================================================
//WALL 0  
//==============================================================================================================================================================================

                      /*module Rectangle(
        input visible, 
        input [3:0] player_color,
        input [3:0] rect_color,
        input passable,
        input [31:0] player_hPos,
        input [31:0] player_vPos,
        input rst,
        input btnClk,
        input [3:0] btns,
        input  [31:0] vStartPos,
        input  [31:0] hStartPos,
        input  [31:0] objWidth,
        input  [31:0] objHeight,
        output  [31:0] vStartPos_o,
        output  [31:0] hStartPos_o,
        output  [31:0] objWidth_o,
        output  [31:0] objHeight_o,
        output reg [31:0] vOffset,
        output reg [31:0] hOffset,
        output [3:0] rect_color_o,
        output reg upEnable,
        output reg downEnable,
        output  reg leftEnable,
        output  reg rightEnable,
        output visible_o
    );*/
        
            //wall 0 
//    Rectangle screen_0_rect_0 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[0 ][0],hStartPos[0 ][0],objWidth[0 ][0],objHeight[0 ][0],vOffset[0 ][0],hOffset[0 ][0], color_o[0 ][0], upEnable[0 ][0], downEnable[0 ][0], leftEnable[0 ][0], rightEnable[0 ][0],visible [0 ][0]);
//    Rectangle screen_0_rect_1 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[1 ][0],hStartPos[1 ][0],objWidth[1 ][0],objHeight[1 ][0],vOffset[1 ][0],hOffset[1 ][0], color_o[1 ][0], upEnable[1 ][0], downEnable[1 ][0], leftEnable[1 ][0], rightEnable[1 ][0],visible [1 ][0]);
//    Rectangle screen_0_rect_2 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[2 ][0],hStartPos[2 ][0],objWidth[2 ][0],objHeight[2 ][0],vOffset[2 ][0],hOffset[2 ][0], color_o[2 ][0], upEnable[2 ][0], downEnable[2 ][0], leftEnable[2 ][0], rightEnable[2 ][0],visible [2 ][0]);
//    Rectangle screen_0_rect_3 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[3 ][0],hStartPos[3 ][0],objWidth[3 ][0],objHeight[3 ][0],vOffset[3 ][0],hOffset[3 ][0], color_o[3 ][0], upEnable[3 ][0], downEnable[3 ][0], leftEnable[3 ][0], rightEnable[3 ][0],visible [3 ][0]);
//    Rectangle screen_0_rect_4 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[4 ][0],hStartPos[4 ][0],objWidth[4 ][0],objHeight[4 ][0],vOffset[4 ][0],hOffset[4 ][0], color_o[4 ][0], upEnable[4 ][0], downEnable[4 ][0], leftEnable[4 ][0], rightEnable[4 ][0],visible [4 ][0]);
//    Rectangle screen_0_rect_5 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[5 ][0],hStartPos[5 ][0],objWidth[5 ][0],objHeight[5 ][0],vOffset[5 ][0],hOffset[5 ][0], color_o[5 ][0], upEnable[5 ][0], downEnable[5 ][0], leftEnable[5 ][0], rightEnable[5 ][0],visible [5 ][0]);
//    Rectangle screen_0_rect_6 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[6 ][0],hStartPos[6 ][0],objWidth[6 ][0],objHeight[6 ][0],vOffset[6 ][0],hOffset[6 ][0], color_o[6 ][0], upEnable[6 ][0], downEnable[6 ][0], leftEnable[6 ][0], rightEnable[6 ][0],visible [6 ][0]);
//    Rectangle screen_0_rect_7 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[7 ][0],hStartPos[7 ][0],objWidth[7 ][0],objHeight[7 ][0],vOffset[7 ][0],hOffset[7 ][0], color_o[7 ][0], upEnable[7 ][0], downEnable[7 ][0], leftEnable[7 ][0], rightEnable[7 ][0],visible [7 ][0]);  
//    Rectangle screen_0_rect_8 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[8 ][0],hStartPos[8 ][0],objWidth[8 ][0],objHeight[8 ][0],vOffset[8 ][0],hOffset[8 ][0], color_o[8 ][0], upEnable[8 ][0], downEnable[8 ][0], leftEnable[8 ][0], rightEnable[8 ][0],visible [8 ][0]);
//    Rectangle screen_0_rect_9 (screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[9 ][0],hStartPos[9 ][0],objWidth[9 ][0],objHeight[9 ][0],vOffset[9 ][0],hOffset[9 ][0], color_o[9 ][0], upEnable[9 ][0], downEnable[9 ][0], leftEnable[9 ][0], rightEnable[9 ][0],visible [9 ][0]);
//    Rectangle screen_0_rect_10(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[10][0],hStartPos[10][0],objWidth[10][0],objHeight[10][0],vOffset[10][0],hOffset[10][0], color_o[10][0], upEnable[10][0], downEnable[10][0], leftEnable[10][0], rightEnable[10][0],visible [10][0]);
//    Rectangle screen_0_rect_11(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[11][0],hStartPos[11][0],objWidth[11][0],objHeight[11][0],vOffset[11][0],hOffset[11][0], color_o[11][0], upEnable[11][0], downEnable[11][0], leftEnable[11][0], rightEnable[11][0],visible [11][0]);  
//    Rectangle screen_0_rect_12(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[12][0],hStartPos[12][0],objWidth[12][0],objHeight[12][0],vOffset[12][0],hOffset[12][0], color_o[12][0], upEnable[12][0], downEnable[12][0], leftEnable[12][0], rightEnable[12][0],visible [12][0]);
//    Rectangle screen_0_rect_13(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[13][0],hStartPos[13][0],objWidth[13][0],objHeight[13][0],vOffset[13][0],hOffset[13][0], color_o[13][0], upEnable[13][0], downEnable[13][0], leftEnable[13][0], rightEnable[13][0],visible [13][0]);
//    Rectangle screen_0_rect_14(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[14][0],hStartPos[14][0],objWidth[14][0],objHeight[14][0],vOffset[14][0],hOffset[14][0], color_o[14][0], upEnable[14][0], downEnable[14][0], leftEnable[14][0], rightEnable[14][0],visible [14][0]);
//    Rectangle screen_0_rect_15(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[15][0],hStartPos[15][0],objWidth[15][0],objHeight[15][0],vOffset[15][0],hOffset[15][0], color_o[15][0], upEnable[15][0], downEnable[15][0], leftEnable[15][0], rightEnable[15][0],visible [15][0]);  
//    Rectangle screen_0_rect_16(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[16][0],hStartPos[16][0],objWidth[16][0],objHeight[16][0],vOffset[16][0],hOffset[16][0], color_o[16][0], upEnable[16][0], downEnable[16][0], leftEnable[16][0], rightEnable[16][0],visible [16][0]);
//    Rectangle screen_0_rect_17(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[17][0],hStartPos[17][0],objWidth[17][0],objHeight[17][0],vOffset[17][0],hOffset[17][0], color_o[17][0], upEnable[17][0], downEnable[17][0], leftEnable[17][0], rightEnable[17][0],visible [17][0]);
//    Rectangle screen_0_rect_18(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[18][0],hStartPos[18][0],objWidth[18][0],objHeight[18][0],vOffset[18][0],hOffset[18][0], color_o[18][0], upEnable[18][0], downEnable[18][0], leftEnable[18][0], rightEnable[18][0],visible [18][0]);
//    Rectangle screen_0_rect_19(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[19][0],hStartPos[19][0],objWidth[19][0],objHeight[19][0],vOffset[19][0],hOffset[19][0], color_o[19][0], upEnable[19][0], downEnable[19][0], leftEnable[19][0], rightEnable[19][0],visible [19][0]);  
//    Rectangle screen_0_rect_20(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[20][0],hStartPos[20][0],objWidth[20][0],objHeight[20][0],vOffset[20][0],hOffset[20][0], color_o[20][0], upEnable[20][0], downEnable[20][0], leftEnable[20][0], rightEnable[20][0],visible [20][0]);
//    Rectangle screen_0_rect_21(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[21][0],hStartPos[21][0],objWidth[21][0],objHeight[21][0],vOffset[21][0],hOffset[21][0], color_o[21][0], upEnable[21][0], downEnable[21][0], leftEnable[21][0], rightEnable[21][0],visible [21][0]);
//    Rectangle screen_0_rect_22(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[22][0],hStartPos[22][0],objWidth[22][0],objHeight[22][0],vOffset[22][0],hOffset[22][0], color_o[22][0], upEnable[22][0], downEnable[22][0], leftEnable[22][0], rightEnable[22][0],visible [22][0]);
//    Rectangle screen_0_rect_23(screen_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[23][0],hStartPos[23][0],objWidth[23][0],objHeight[23][0],vOffset[23][0],hOffset[23][0], color_o[23][0], upEnable[23][0], downEnable[23][0], leftEnable[23][0], rightEnable[23][0],visible [23][0]);  


//==============================================================================================================================================================================
//WALL 1  PLAY 
//==============================================================================================================================================================================
    Rectangle screen_1_rect_0 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+9*size,wSize,vSize*5,vStartPos[0 ][1],hStartPos[0 ][1],objWidth[0 ][1],objHeight[0 ][1],vOffset[0 ][1],hOffset[0 ][1], color_o[0 ][1], upEnable[0 ][1], downEnable[0 ][1], leftEnable[0 ][1], rightEnable[0 ][1],visible [0 ][1]);
    Rectangle screen_1_rect_1 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+9*size,wSize*3,vSize,vStartPos[1 ][1],hStartPos[1 ][1],objWidth[1 ][1],objHeight[1 ][1],vOffset[1 ][1],hOffset[1 ][1], color_o[1 ][1], upEnable[1 ][1], downEnable[1 ][1], leftEnable[1 ][1], rightEnable[1 ][1],visible [1 ][1]);
    Rectangle screen_1_rect_2 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+11*size,wSize,vSize*3,vStartPos[2 ][1],hStartPos[2 ][1],objWidth[2 ][1],objHeight[2 ][1],vOffset[2 ][1],hOffset[2 ][1], color_o[2 ][1], upEnable[2 ][1], downEnable[2 ][1], leftEnable[2 ][1], rightEnable[2 ][1],visible [2 ][1]);
    Rectangle screen_1_rect_3 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+9*size,wSize*3,vSize,vStartPos[3 ][1],hStartPos[3 ][1],objWidth[3 ][1],objHeight[3 ][1],vOffset[3 ][1],hOffset[3 ][1], color_o[3 ][1], upEnable[3 ][1], downEnable[3 ][1], leftEnable[3 ][1], rightEnable[3 ][1],visible [3 ][1]);
    Rectangle screen_1_rect_4 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+13*size,wSize,vSize*5,vStartPos[4 ][1],hStartPos[4 ][1],objWidth[4 ][1],objHeight[4 ][1],vOffset[4 ][1],hOffset[4 ][1], color_o[4 ][1], upEnable[4 ][1], downEnable[4 ][1], leftEnable[4 ][1], rightEnable[4 ][1],visible [4 ][1]);
    Rectangle screen_1_rect_5 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+13*size,wSize*3,vSize,vStartPos[5 ][1],hStartPos[5 ][1],objWidth[5 ][1],objHeight[5 ][1],vOffset[5 ][1],hOffset[5 ][1], color_o[5 ][1], upEnable[5 ][1], downEnable[5 ][1], leftEnable[5 ][1], rightEnable[5 ][1],visible [5 ][1]);
    Rectangle screen_1_rect_6 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+17*size,wSize,vSize*5,vStartPos[6 ][1],hStartPos[6 ][1],objWidth[6 ][1],objHeight[6 ][1],vOffset[6 ][1],hOffset[6 ][1], color_o[6 ][1], upEnable[6 ][1], downEnable[6 ][1], leftEnable[6 ][1], rightEnable[6 ][1],visible [6 ][1]);
    Rectangle screen_1_rect_7 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+17*size,wSize*3,vSize,vStartPos[7 ][1],hStartPos[7 ][1],objWidth[7 ][1],objHeight[7 ][1],vOffset[7 ][1],hOffset[7 ][1], color_o[7 ][1], upEnable[7 ][1], downEnable[7 ][1], leftEnable[7 ][1], rightEnable[7 ][1],visible [7 ][1]);  
    Rectangle screen_1_rect_8 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+19*size,wSize,vSize*5,vStartPos[8 ][1],hStartPos[8 ][1],objWidth[8 ][1],objHeight[8 ][1],vOffset[8 ][1],hOffset[8 ][1], color_o[8 ][1], upEnable[8 ][1], downEnable[8 ][1], leftEnable[8 ][1], rightEnable[8 ][1],visible [8 ][1]);
    Rectangle screen_1_rect_9 (screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+17*size,wSize*3,vSize,vStartPos[9 ][1],hStartPos[9 ][1],objWidth[9 ][1],objHeight[9 ][1],vOffset[9 ][1],hOffset[9 ][1], color_o[9 ][1], upEnable[9 ][1], downEnable[9 ][1], leftEnable[9 ][1], rightEnable[9 ][1],visible [9 ][1]);
    Rectangle screen_1_rect_10(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+21*size,wSize,vSize*3,vStartPos[10][1],hStartPos[10][1],objWidth[10][1],objHeight[10][1],vOffset[10][1],hOffset[10][1], color_o[10][1], upEnable[10][1], downEnable[10][1], leftEnable[10][1], rightEnable[10][1],visible [10][1]);
    Rectangle screen_1_rect_11(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+21*size,wSize*3,vSize,vStartPos[11][1],hStartPos[11][1],objWidth[11][1],objHeight[11][1],vOffset[11][1],hOffset[11][1], color_o[11][1], upEnable[11][1], downEnable[11][1], leftEnable[11][1], rightEnable[11][1],visible [11][1]);  
    Rectangle screen_1_rect_12(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+23*size,wSize,vSize*5,vStartPos[12][1],hStartPos[12][1],objWidth[12][1],objHeight[12][1],vOffset[12][1],hOffset[12][1], color_o[12][1], upEnable[12][1], downEnable[12][1], leftEnable[12][1], rightEnable[12][1],visible [12][1]);
    Rectangle screen_1_rect_13(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+21*size,wSize*3,vSize,vStartPos[13][1],hStartPos[13][1],objWidth[13][1],objHeight[13][1],vOffset[13][1],hOffset[13][1], color_o[13][1], upEnable[13][1], downEnable[13][1], leftEnable[13][1], rightEnable[13][1],visible [13][1]);
//    Rectangle screen_1_rect_14(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[14][1],hStartPos[14][1],objWidth[14][1],objHeight[14][1],vOffset[14][1],hOffset[14][1], color_o[14][1], upEnable[14][1], downEnable[14][1], leftEnable[14][1], rightEnable[14][1],visible [14][1]);
//    Rectangle screen_1_rect_15(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[15][1],hStartPos[15][1],objWidth[15][1],objHeight[15][1],vOffset[15][1],hOffset[15][1], color_o[15][1], upEnable[15][1], downEnable[15][1], leftEnable[15][1], rightEnable[15][1],visible [15][1]);  
//    Rectangle screen_1_rect_16(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[16][1],hStartPos[16][1],objWidth[16][1],objHeight[16][1],vOffset[16][1],hOffset[16][1], color_o[16][1], upEnable[16][1], downEnable[16][1], leftEnable[16][1], rightEnable[16][1],visible [16][1]);
//    Rectangle screen_1_rect_17(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[17][1],hStartPos[17][1],objWidth[17][1],objHeight[17][1],vOffset[17][1],hOffset[17][1], color_o[17][1], upEnable[17][1], downEnable[17][1], leftEnable[17][1], rightEnable[17][1],visible [17][1]);
//    Rectangle screen_1_rect_18(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[18][1],hStartPos[18][1],objWidth[18][1],objHeight[18][1],vOffset[18][1],hOffset[18][1], color_o[18][1], upEnable[18][1], downEnable[18][1], leftEnable[18][1], rightEnable[18][1],visible [18][1]);
//    Rectangle screen_1_rect_19(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[19][1],hStartPos[19][1],objWidth[19][1],objHeight[19][1],vOffset[19][1],hOffset[19][1], color_o[19][1], upEnable[19][1], downEnable[19][1], leftEnable[19][1], rightEnable[19][1],visible [19][1]);  
//    Rectangle screen_1_rect_20(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[20][1],hStartPos[20][1],objWidth[20][1],objHeight[20][1],vOffset[20][1],hOffset[20][1], color_o[20][1], upEnable[20][1], downEnable[20][1], leftEnable[20][1], rightEnable[20][1],visible [20][1]);
//    Rectangle screen_1_rect_21(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[21][1],hStartPos[21][1],objWidth[21][1],objHeight[21][1],vOffset[21][1],hOffset[21][1], color_o[21][1], upEnable[21][1], downEnable[21][1], leftEnable[21][1], rightEnable[21][1],visible [21][1]);
//    Rectangle screen_1_rect_22(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[22][1],hStartPos[22][1],objWidth[22][1],objHeight[22][1],vOffset[22][1],hOffset[22][1], color_o[22][1], upEnable[22][1], downEnable[22][1], leftEnable[22][1], rightEnable[22][1],visible [22][1]);
//    Rectangle screen_1_rect_23(screen_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[23][1],hStartPos[23][1],objWidth[23][1],objHeight[23][1],vOffset[23][1],hOffset[23][1], color_o[23][1], upEnable[23][1], downEnable[23][1], leftEnable[23][1], rightEnable[23][1],visible [23][1]);  
                   
//==============================================================================================================================================================================
//WALL 2   LOSE
//==============================================================================================================================================================================
    Rectangle screen_2_rect_0 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+ 9*size,wSize,vSize*5,vStartPos[0 ][2],hStartPos[0 ][2],objWidth[0 ][2],objHeight[0 ][2],vOffset[0 ][2],hOffset[0 ][2], color_o[0 ][2], upEnable[0 ][2], downEnable[0 ][2], leftEnable[0 ][2], rightEnable[0 ][2],visible [0 ][2]);
    Rectangle screen_2_rect_1 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+ 9*size,wSize*3,vSize,vStartPos[1 ][2],hStartPos[1 ][2],objWidth[1 ][2],objHeight[1 ][2],vOffset[1 ][2],hOffset[1 ][2], color_o[1 ][2], upEnable[1 ][2], downEnable[1 ][2], leftEnable[1 ][2], rightEnable[1 ][2],visible [1 ][2]);
    Rectangle screen_2_rect_2 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+13*size,wSize,vSize*5,vStartPos[2 ][2],hStartPos[2 ][2],objWidth[2 ][2],objHeight[2 ][2],vOffset[2 ][2],hOffset[2 ][2], color_o[2 ][2], upEnable[2 ][2], downEnable[2 ][2], leftEnable[2 ][2], rightEnable[2 ][2],visible [2 ][2]);
    Rectangle screen_2_rect_3 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+13*size,wSize*3,vSize,vStartPos[3 ][2],hStartPos[3 ][2],objWidth[3 ][2],objHeight[3 ][2],vOffset[3 ][2],hOffset[3 ][2], color_o[3 ][2], upEnable[3 ][2], downEnable[3 ][2], leftEnable[3 ][2], rightEnable[3 ][2],visible [3 ][2]);
    Rectangle screen_2_rect_4 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+13*size,wSize*3,vSize,vStartPos[4 ][2],hStartPos[4 ][2],objWidth[4 ][2],objHeight[4 ][2],vOffset[4 ][2],hOffset[4 ][2], color_o[4 ][2], upEnable[4 ][2], downEnable[4 ][2], leftEnable[4 ][2], rightEnable[4 ][2],visible [4 ][2]);
    Rectangle screen_2_rect_5 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+15*size,wSize,vSize*5,vStartPos[5 ][2],hStartPos[5 ][2],objWidth[5 ][2],objHeight[5 ][2],vOffset[5 ][2],hOffset[5 ][2], color_o[5 ][2], upEnable[5 ][2], downEnable[5 ][2], leftEnable[5 ][2], rightEnable[5 ][2],visible [5 ][2]);
    Rectangle screen_2_rect_6 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+17*size,wSize*3,vSize,vStartPos[6 ][2],hStartPos[6 ][2],objWidth[6 ][2],objHeight[6 ][2],vOffset[6 ][2],hOffset[6 ][2], color_o[6 ][2], upEnable[6 ][2], downEnable[6 ][2], leftEnable[6 ][2], rightEnable[6 ][2],visible [6 ][2]);
    Rectangle screen_2_rect_7 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+17*size,wSize,vSize*3,vStartPos[7 ][2],hStartPos[7 ][2],objWidth[7 ][2],objHeight[7 ][2],vOffset[7 ][2],hOffset[7 ][2], color_o[7 ][2], upEnable[7 ][2], downEnable[7 ][2], leftEnable[7 ][2], rightEnable[7 ][2],visible [7 ][2]);  
    Rectangle screen_2_rect_8 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+17*size,wSize*3,vSize,vStartPos[8 ][2],hStartPos[8 ][2],objWidth[8 ][2],objHeight[8 ][2],vOffset[8 ][2],hOffset[8 ][2], color_o[8 ][2], upEnable[8 ][2], downEnable[8 ][2], leftEnable[8 ][2], rightEnable[8 ][2],visible [8 ][2]);
    Rectangle screen_2_rect_9 (screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+19*size,wSize,vSize*3,vStartPos[9 ][2],hStartPos[9 ][2],objWidth[9 ][2],objHeight[9 ][2],vOffset[9 ][2],hOffset[9 ][2], color_o[9 ][2], upEnable[9 ][2], downEnable[9 ][2], leftEnable[9 ][2], rightEnable[9 ][2],visible [9 ][2]);
    Rectangle screen_2_rect_10(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+17*size,wSize*3,vSize,vStartPos[10][2],hStartPos[10][2],objWidth[10][2],objHeight[10][2],vOffset[10][2],hOffset[10][2], color_o[10][2], upEnable[10][2], downEnable[10][2], leftEnable[10][2], rightEnable[10][2],visible [10][2]);
    Rectangle screen_2_rect_11(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+21*size,wSize*3,vSize,vStartPos[11][2],hStartPos[11][2],objWidth[11][2],objHeight[11][2],vOffset[11][2],hOffset[11][2], color_o[11][2], upEnable[11][2], downEnable[11][2], leftEnable[11][2], rightEnable[11][2],visible [11][2]);  
    Rectangle screen_2_rect_12(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+21*size,wSize,vSize*3,vStartPos[12][2],hStartPos[12][2],objWidth[12][2],objHeight[12][2],vOffset[12][2],hOffset[12][2], color_o[12][2], upEnable[12][2], downEnable[12][2], leftEnable[12][2], rightEnable[12][2],visible [12][2]);
    Rectangle screen_2_rect_13(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+21*size,wSize*3,vSize,vStartPos[13][2],hStartPos[13][2],objWidth[13][2],objHeight[13][2],vOffset[13][2],hOffset[13][2], color_o[13][2], upEnable[13][2], downEnable[13][2], leftEnable[13][2], rightEnable[13][2],visible [13][2]);
    Rectangle screen_2_rect_14(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+21*size,wSize*3,vSize,vStartPos[14][2],hStartPos[14][2],objWidth[14][2],objHeight[14][2],vOffset[14][2],hOffset[14][2], color_o[14][2], upEnable[14][2], downEnable[14][2], leftEnable[14][2], rightEnable[14][2],visible [14][2]);
    Rectangle screen_2_rect_15(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+21*size,wSize,vSize*3,vStartPos[15][2],hStartPos[15][2],objWidth[15][2],objHeight[15][2],vOffset[15][2],hOffset[15][2], color_o[15][2], upEnable[15][2], downEnable[15][2], leftEnable[15][2], rightEnable[15][2],visible [15][2]);  
//    Rectangle screen_2_rect_16(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[16][2],hStartPos[16][2],objWidth[16][2],objHeight[16][2],vOffset[16][2],hOffset[16][2], color_o[16][2], upEnable[16][2], downEnable[16][2], leftEnable[16][2], rightEnable[16][2],visible [16][2]);
//    Rectangle screen_2_rect_17(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[17][2],hStartPos[17][2],objWidth[17][2],objHeight[17][2],vOffset[17][2],hOffset[17][2], color_o[17][2], upEnable[17][2], downEnable[17][2], leftEnable[17][2], rightEnable[17][2],visible [17][2]);
//    Rectangle screen_2_rect_18(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[18][2],hStartPos[18][2],objWidth[18][2],objHeight[18][2],vOffset[18][2],hOffset[18][2], color_o[18][2], upEnable[18][2], downEnable[18][2], leftEnable[18][2], rightEnable[18][2],visible [18][2]);
//    Rectangle screen_2_rect_19(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[19][2],hStartPos[19][2],objWidth[19][2],objHeight[19][2],vOffset[19][2],hOffset[19][2], color_o[19][2], upEnable[19][2], downEnable[19][2], leftEnable[19][2], rightEnable[19][2],visible [19][2]);  
//    Rectangle screen_2_rect_20(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[20][2],hStartPos[20][2],objWidth[20][2],objHeight[20][2],vOffset[20][2],hOffset[20][2], color_o[20][2], upEnable[20][2], downEnable[20][2], leftEnable[20][2], rightEnable[20][2],visible [20][2]);
//    Rectangle screen_2_rect_21(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[21][2],hStartPos[21][2],objWidth[21][2],objHeight[21][2],vOffset[21][2],hOffset[21][2], color_o[21][2], upEnable[21][2], downEnable[21][2], leftEnable[21][2], rightEnable[21][2],visible [21][2]);
//    Rectangle screen_2_rect_22(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[22][2],hStartPos[22][2],objWidth[22][2],objHeight[22][2],vOffset[22][2],hOffset[22][2], color_o[22][2], upEnable[22][2], downEnable[22][2], leftEnable[22][2], rightEnable[22][2],visible [22][2]);
//    Rectangle screen_2_rect_23(screen_2_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[23][2],hStartPos[23][2],objWidth[23][2],objHeight[23][2],vOffset[23][2],hOffset[23][2], color_o[23][2], upEnable[23][2], downEnable[23][2], leftEnable[23][2], rightEnable[23][2],visible [23][2]);  
//==============================================================================================================================================================================
//WALL 3   WIN
//==============================================================================================================================================================================
    Rectangle screen_3_rect_0 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+9*size,wSize,vSize*5,vStartPos[0 ][3],hStartPos[0 ][3],objWidth[0 ][3],objHeight[0 ][3],vOffset[0 ][3],hOffset[0 ][3], color_o[0 ][3], upEnable[0 ][3], downEnable[0 ][3], leftEnable[0 ][3], rightEnable[0 ][3],visible [0 ][3]);
    Rectangle screen_3_rect_1 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+9*size,wSize*5,vSize,vStartPos[1 ][3],hStartPos[1 ][3],objWidth[1 ][3],objHeight[1 ][3],vOffset[1 ][3],hOffset[1 ][3], color_o[1 ][3], upEnable[1 ][3], downEnable[1 ][3], leftEnable[1 ][3], rightEnable[1 ][3],visible [1 ][3]);
    Rectangle screen_3_rect_2 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+11*size,wSize,vSize*5,vStartPos[2 ][3],hStartPos[2 ][3],objWidth[2 ][3],objHeight[2 ][3],vOffset[2 ][3],hOffset[2 ][3], color_o[2 ][3], upEnable[2 ][3], downEnable[2 ][3], leftEnable[2 ][3], rightEnable[2 ][3],visible [2 ][3]);
    Rectangle screen_3_rect_3 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+13*size,wSize,vSize*5,vStartPos[3 ][3],hStartPos[3 ][3],objWidth[3 ][3],objHeight[3 ][3],vOffset[3 ][3],hOffset[3 ][3], color_o[3 ][3], upEnable[3 ][3], downEnable[3 ][3], leftEnable[3 ][3], rightEnable[3 ][3],visible [3 ][3]);
    Rectangle screen_3_rect_4 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+8*size,hDefault_pos+15*size,wSize,vSize,vStartPos[4 ][3],hStartPos[4 ][3],objWidth[4 ][3],objHeight[4 ][3],vOffset[4 ][3],hOffset[4 ][3], color_o[4 ][3], upEnable[4 ][3], downEnable[4 ][3], leftEnable[4 ][3], rightEnable[4 ][3],visible [4 ][3]);
    Rectangle screen_3_rect_5 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+15*size,wSize,vSize*5,vStartPos[5 ][3],hStartPos[5 ][3],objWidth[5 ][3],objHeight[5 ][3],vOffset[5 ][3],hOffset[5 ][3], color_o[5 ][3], upEnable[5 ][3], downEnable[5 ][3], leftEnable[5 ][3], rightEnable[5 ][3],visible [5 ][3]);
    Rectangle screen_3_rect_6 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+17*size,wSize,vSize*5,vStartPos[6 ][3],hStartPos[6 ][3],objWidth[6 ][3],objHeight[6 ][3],vOffset[6 ][3],hOffset[6 ][3], color_o[6 ][3], upEnable[6 ][3], downEnable[6 ][3], leftEnable[6 ][3], rightEnable[6 ][3],visible [6 ][3]);
    Rectangle screen_3_rect_7 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+17*size,wSize*4,vSize,vStartPos[7 ][3],hStartPos[7 ][3],objWidth[7 ][3],objHeight[7 ][3],vOffset[7 ][3],hOffset[7 ][3], color_o[7 ][3], upEnable[7 ][3], downEnable[7 ][3], leftEnable[7 ][3], rightEnable[7 ][3],visible [7 ][3]);  
    Rectangle screen_3_rect_8 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+20*size,wSize,vSize*5,vStartPos[8 ][3],hStartPos[8 ][3],objWidth[8 ][3],objHeight[8 ][3],vOffset[8 ][3],hOffset[8 ][3], color_o[8 ][3], upEnable[8 ][3], downEnable[8 ][3], leftEnable[8 ][3], rightEnable[8 ][3],visible [8 ][3]);
//    Rectangle screen_3_rect_9 (screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[9 ][3],hStartPos[9 ][3],objWidth[9 ][3],objHeight[9 ][3],vOffset[9 ][3],hOffset[9 ][3], color_o[9 ][3], upEnable[9 ][3], downEnable[9 ][3], leftEnable[9 ][3], rightEnable[9 ][3],visible [9 ][3]);
//    Rectangle screen_3_rect_10(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[10][3],hStartPos[10][3],objWidth[10][3],objHeight[10][3],vOffset[10][3],hOffset[10][3], color_o[10][3], upEnable[10][3], downEnable[10][3], leftEnable[10][3], rightEnable[10][3],visible [10][3]);
//    Rectangle screen_3_rect_11(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[11][3],hStartPos[11][3],objWidth[11][3],objHeight[11][3],vOffset[11][3],hOffset[11][3], color_o[11][3], upEnable[11][3], downEnable[11][3], leftEnable[11][3], rightEnable[11][3],visible [11][3]);  
//    Rectangle screen_3_rect_12(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[12][3],hStartPos[12][3],objWidth[12][3],objHeight[12][3],vOffset[12][3],hOffset[12][3], color_o[12][3], upEnable[12][3], downEnable[12][3], leftEnable[12][3], rightEnable[12][3],visible [12][3]);
//    Rectangle screen_3_rect_13(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[13][3],hStartPos[13][3],objWidth[13][3],objHeight[13][3],vOffset[13][3],hOffset[13][3], color_o[13][3], upEnable[13][3], downEnable[13][3], leftEnable[13][3], rightEnable[13][3],visible [13][3]);
//    Rectangle screen_3_rect_14(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[14][3],hStartPos[14][3],objWidth[14][3],objHeight[14][3],vOffset[14][3],hOffset[14][3], color_o[14][3], upEnable[14][3], downEnable[14][3], leftEnable[14][3], rightEnable[14][3],visible [14][3]);
//    Rectangle screen_3_rect_15(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[15][3],hStartPos[15][3],objWidth[15][3],objHeight[15][3],vOffset[15][3],hOffset[15][3], color_o[15][3], upEnable[15][3], downEnable[15][3], leftEnable[15][3], rightEnable[15][3],visible [15][3]);  
//    Rectangle screen_3_rect_16(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[16][3],hStartPos[16][3],objWidth[16][3],objHeight[16][3],vOffset[16][3],hOffset[16][3], color_o[16][3], upEnable[16][3], downEnable[16][3], leftEnable[16][3], rightEnable[16][3],visible [16][3]);
//    Rectangle screen_3_rect_17(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[17][3],hStartPos[17][3],objWidth[17][3],objHeight[17][3],vOffset[17][3],hOffset[17][3], color_o[17][3], upEnable[17][3], downEnable[17][3], leftEnable[17][3], rightEnable[17][3],visible [17][3]);
//    Rectangle screen_3_rect_18(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[18][3],hStartPos[18][3],objWidth[18][3],objHeight[18][3],vOffset[18][3],hOffset[18][3], color_o[18][3], upEnable[18][3], downEnable[18][3], leftEnable[18][3], rightEnable[18][3],visible [18][3]);
//    Rectangle screen_3_rect_19(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[19][3],hStartPos[19][3],objWidth[19][3],objHeight[19][3],vOffset[19][3],hOffset[19][3], color_o[19][3], upEnable[19][3], downEnable[19][3], leftEnable[19][3], rightEnable[19][3],visible [19][3]);  
//    Rectangle screen_3_rect_20(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[20][3],hStartPos[20][3],objWidth[20][3],objHeight[20][3],vOffset[20][3],hOffset[20][3], color_o[20][3], upEnable[20][3], downEnable[20][3], leftEnable[20][3], rightEnable[20][3],visible [20][3]);
//    Rectangle screen_3_rect_21(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[21][3],hStartPos[21][3],objWidth[21][3],objHeight[21][3],vOffset[21][3],hOffset[21][3], color_o[21][3], upEnable[21][3], downEnable[21][3], leftEnable[21][3], rightEnable[21][3],visible [21][3]);
//    Rectangle screen_3_rect_22(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[22][3],hStartPos[22][3],objWidth[22][3],objHeight[22][3],vOffset[22][3],hOffset[22][3], color_o[22][3], upEnable[22][3], downEnable[22][3], leftEnable[22][3], rightEnable[22][3],visible [22][3]);
//    Rectangle screen_3_rect_23(screen_3_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[23][3],hStartPos[23][3],objWidth[23][3],objHeight[23][3],vOffset[23][3],hOffset[23][3], color_o[23][3], upEnable[23][3], downEnable[23][3], leftEnable[23][3], rightEnable[23][3],visible [23][3]);  
//==============================================================================================================================================================================
//WALL 4   L+
//==============================================================================================================================================================================
    Rectangle screen_4_rect_0 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+9*size,wSize,vSize*5,vStartPos[0 ][4],hStartPos[0 ][4],objWidth[0 ][4],objHeight[0 ][4],vOffset[0 ][4],hOffset[0 ][4], color_o[0 ][4], upEnable[0 ][4], downEnable[0 ][4], leftEnable[0 ][4], rightEnable[0 ][4],visible [0 ][4]);
    Rectangle screen_4_rect_1 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+9*size,wSize*3,vSize,vStartPos[1 ][4],hStartPos[1 ][4],objWidth[1 ][4],objHeight[1 ][4],vOffset[1 ][4],hOffset[1 ][4], color_o[1 ][4], upEnable[1 ][4], downEnable[1 ][4], leftEnable[1 ][4], rightEnable[1 ][4],visible [1 ][4]);
    Rectangle screen_4_rect_2 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+13*size,wSize*3,vSize,vStartPos[2 ][4],hStartPos[2 ][4],objWidth[2 ][4],objHeight[2 ][4],vOffset[2 ][4],hOffset[2 ][4], color_o[2 ][4], upEnable[2 ][4], downEnable[2 ][4], leftEnable[2 ][4], rightEnable[2 ][4],visible [2 ][4]);
    Rectangle screen_4_rect_3 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+11*size,hDefault_pos+14*size,wSize,vSize*3,vStartPos[3 ][4],hStartPos[3 ][4],objWidth[3 ][4],objHeight[3 ][4],vOffset[3 ][4],hOffset[3 ][4], color_o[3 ][4], upEnable[3 ][4], downEnable[3 ][4], leftEnable[3 ][4], rightEnable[3 ][4],visible [3 ][4]);
//    Rectangle screen_4_rect_4 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[4 ][4],hStartPos[4 ][4],objWidth[4 ][4],objHeight[4 ][4],vOffset[4 ][4],hOffset[4 ][4], color_o[4 ][4], upEnable[4 ][4], downEnable[4 ][4], leftEnable[4 ][4], rightEnable[4 ][4],visible [4 ][4]);
//    Rectangle screen_4_rect_5 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[5 ][4],hStartPos[5 ][4],objWidth[5 ][4],objHeight[5 ][4],vOffset[5 ][4],hOffset[5 ][4], color_o[5 ][4], upEnable[5 ][4], downEnable[5 ][4], leftEnable[5 ][4], rightEnable[5 ][4],visible [5 ][4]);
//    Rectangle screen_4_rect_6 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[6 ][4],hStartPos[6 ][4],objWidth[6 ][4],objHeight[6 ][4],vOffset[6 ][4],hOffset[6 ][4], color_o[6 ][4], upEnable[6 ][4], downEnable[6 ][4], leftEnable[6 ][4], rightEnable[6 ][4],visible [6 ][4]);
//    Rectangle screen_4_rect_7 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[7 ][4],hStartPos[7 ][4],objWidth[7 ][4],objHeight[7 ][4],vOffset[7 ][4],hOffset[7 ][4], color_o[7 ][4], upEnable[7 ][4], downEnable[7 ][4], leftEnable[7 ][4], rightEnable[7 ][4],visible [7 ][4]);  
//    Rectangle screen_4_rect_8 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[8 ][4],hStartPos[8 ][4],objWidth[8 ][4],objHeight[8 ][4],vOffset[8 ][4],hOffset[8 ][4], color_o[8 ][4], upEnable[8 ][4], downEnable[8 ][4], leftEnable[8 ][4], rightEnable[8 ][4],visible [8 ][4]);
//    Rectangle screen_4_rect_9 (screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[9 ][4],hStartPos[9 ][4],objWidth[9 ][4],objHeight[9 ][4],vOffset[9 ][4],hOffset[9 ][4], color_o[9 ][4], upEnable[9 ][4], downEnable[9 ][4], leftEnable[9 ][4], rightEnable[9 ][4],visible [9 ][4]);
//    Rectangle screen_4_rect_10(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[10][4],hStartPos[10][4],objWidth[10][4],objHeight[10][4],vOffset[10][4],hOffset[10][4], color_o[10][4], upEnable[10][4], downEnable[10][4], leftEnable[10][4], rightEnable[10][4],visible [10][4]);
//    Rectangle screen_4_rect_11(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[11][4],hStartPos[11][4],objWidth[11][4],objHeight[11][4],vOffset[11][4],hOffset[11][4], color_o[11][4], upEnable[11][4], downEnable[11][4], leftEnable[11][4], rightEnable[11][4],visible [11][4]);  
//    Rectangle screen_4_rect_12(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[12][4],hStartPos[12][4],objWidth[12][4],objHeight[12][4],vOffset[12][4],hOffset[12][4], color_o[12][4], upEnable[12][4], downEnable[12][4], leftEnable[12][4], rightEnable[12][4],visible [12][4]);
//    Rectangle screen_4_rect_13(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[13][4],hStartPos[13][4],objWidth[13][4],objHeight[13][4],vOffset[13][4],hOffset[13][4], color_o[13][4], upEnable[13][4], downEnable[13][4], leftEnable[13][4], rightEnable[13][4],visible [13][4]);
//    Rectangle screen_4_rect_14(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[14][4],hStartPos[14][4],objWidth[14][4],objHeight[14][4],vOffset[14][4],hOffset[14][4], color_o[14][4], upEnable[14][4], downEnable[14][4], leftEnable[14][4], rightEnable[14][4],visible [14][4]);
//    Rectangle screen_4_rect_15(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[15][4],hStartPos[15][4],objWidth[15][4],objHeight[15][4],vOffset[15][4],hOffset[15][4], color_o[15][4], upEnable[15][4], downEnable[15][4], leftEnable[15][4], rightEnable[15][4],visible [15][4]);  
//    Rectangle screen_4_rect_16(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[16][4],hStartPos[16][4],objWidth[16][4],objHeight[16][4],vOffset[16][4],hOffset[16][4], color_o[16][4], upEnable[16][4], downEnable[16][4], leftEnable[16][4], rightEnable[16][4],visible [16][4]);
//    Rectangle screen_4_rect_17(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[17][4],hStartPos[17][4],objWidth[17][4],objHeight[17][4],vOffset[17][4],hOffset[17][4], color_o[17][4], upEnable[17][4], downEnable[17][4], leftEnable[17][4], rightEnable[17][4],visible [17][4]);
//    Rectangle screen_4_rect_18(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[18][4],hStartPos[18][4],objWidth[18][4],objHeight[18][4],vOffset[18][4],hOffset[18][4], color_o[18][4], upEnable[18][4], downEnable[18][4], leftEnable[18][4], rightEnable[18][4],visible [18][4]);
//    Rectangle screen_4_rect_19(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[19][4],hStartPos[19][4],objWidth[19][4],objHeight[19][4],vOffset[19][4],hOffset[19][4], color_o[19][4], upEnable[19][4], downEnable[19][4], leftEnable[19][4], rightEnable[19][4],visible [19][4]);  
//    Rectangle screen_4_rect_20(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[20][4],hStartPos[20][4],objWidth[20][4],objHeight[20][4],vOffset[20][4],hOffset[20][4], color_o[20][4], upEnable[20][4], downEnable[20][4], leftEnable[20][4], rightEnable[20][4],visible [20][4]);
//    Rectangle screen_4_rect_21(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[21][4],hStartPos[21][4],objWidth[21][4],objHeight[21][4],vOffset[21][4],hOffset[21][4], color_o[21][4], upEnable[21][4], downEnable[21][4], leftEnable[21][4], rightEnable[21][4],visible [21][4]);
//    Rectangle screen_4_rect_22(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[22][4],hStartPos[22][4],objWidth[22][4],objHeight[22][4],vOffset[22][4],hOffset[22][4], color_o[22][4], upEnable[22][4], downEnable[22][4], leftEnable[22][4], rightEnable[22][4],visible [22][4]);
//    Rectangle screen_4_rect_23(screen_4_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[23][4],hStartPos[23][4],objWidth[23][4],objHeight[23][4],vOffset[23][4],hOffset[23][4], color_o[23][4], upEnable[23][4], downEnable[23][4], leftEnable[23][4], rightEnable[23][4],visible [23][4]);  
//==============================================================================================================================================================================
//WALL 5    W+
//==============================================================================================================================================================================
    Rectangle screen_5_rect_0 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+9*size,wSize,vSize*5,vStartPos[0 ][5],hStartPos[0 ][5],objWidth[0 ][5],objHeight[0 ][5],vOffset[0 ][5],hOffset[0 ][5], color_o[0 ][5], upEnable[0 ][5], downEnable[0 ][5], leftEnable[0 ][5], rightEnable[0 ][5],visible [0 ][5]);
    Rectangle screen_5_rect_1 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+9*size,wSize*5,vSize,vStartPos[1 ][5],hStartPos[1 ][5],objWidth[1 ][5],objHeight[1 ][5],vOffset[1 ][5],hOffset[1 ][5], color_o[1 ][5], upEnable[1 ][5], downEnable[1 ][5], leftEnable[1 ][5], rightEnable[1 ][5],visible [1 ][5]);
    Rectangle screen_5_rect_2 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+11*size,wSize,vSize*5,vStartPos[2 ][5],hStartPos[2 ][5],objWidth[2 ][5],objHeight[2 ][5],vOffset[2 ][5],hOffset[2 ][5], color_o[2 ][5], upEnable[2 ][5], downEnable[2 ][5], leftEnable[2 ][5], rightEnable[2 ][5],visible [2 ][5]);
    Rectangle screen_5_rect_3 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+13*size,wSize,vSize*5,vStartPos[3 ][5],hStartPos[3 ][5],objWidth[3 ][5],objHeight[3 ][5],vOffset[3 ][5],hOffset[3 ][5], color_o[3 ][5], upEnable[3 ][5], downEnable[3 ][5], leftEnable[3 ][5], rightEnable[3 ][5],visible [3 ][5]);
    Rectangle screen_5_rect_4 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+15*size,wSize*3,vSize,vStartPos[4 ][5],hStartPos[4 ][5],objWidth[4 ][5],objHeight[4 ][5],vOffset[4 ][5],hOffset[4 ][5], color_o[4 ][5], upEnable[4 ][5], downEnable[4 ][5], leftEnable[4 ][5], rightEnable[4 ][5],visible [4 ][5]);
    Rectangle screen_5_rect_5 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+11*size,hDefault_pos+16*size,wSize,vSize*3,vStartPos[5 ][5],hStartPos[5 ][5],objWidth[5 ][5],objHeight[5 ][5],vOffset[5 ][5],hOffset[5 ][5], color_o[5 ][5], upEnable[5 ][5], downEnable[5 ][5], leftEnable[5 ][5], rightEnable[5 ][5],visible [5 ][5]);
//    Rectangle screen_5_rect_6 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[6 ][5],hStartPos[6 ][5],objWidth[6 ][5],objHeight[6 ][5],vOffset[6 ][5],hOffset[6 ][5], color_o[6 ][5], upEnable[6 ][5], downEnable[6 ][5], leftEnable[6 ][5], rightEnable[6 ][5],visible [6 ][5]);
//    Rectangle screen_5_rect_7 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[7 ][5],hStartPos[7 ][5],objWidth[7 ][5],objHeight[7 ][5],vOffset[7 ][5],hOffset[7 ][5], color_o[7 ][5], upEnable[7 ][5], downEnable[7 ][5], leftEnable[7 ][5], rightEnable[7 ][5],visible [7 ][5]);  
//    Rectangle screen_5_rect_8 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[8 ][5],hStartPos[8 ][5],objWidth[8 ][5],objHeight[8 ][5],vOffset[8 ][5],hOffset[8 ][5], color_o[8 ][5], upEnable[8 ][5], downEnable[8 ][5], leftEnable[8 ][5], rightEnable[8 ][5],visible [8 ][5]);
//    Rectangle screen_5_rect_9 (screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[9 ][5],hStartPos[9 ][5],objWidth[9 ][5],objHeight[9 ][5],vOffset[9 ][5],hOffset[9 ][5], color_o[9 ][5], upEnable[9 ][5], downEnable[9 ][5], leftEnable[9 ][5], rightEnable[9 ][5],visible [9 ][5]);
//    Rectangle screen_5_rect_10(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[10][5],hStartPos[10][5],objWidth[10][5],objHeight[10][5],vOffset[10][5],hOffset[10][5], color_o[10][5], upEnable[10][5], downEnable[10][5], leftEnable[10][5], rightEnable[10][5],visible [10][5]);
//    Rectangle screen_5_rect_11(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[11][5],hStartPos[11][5],objWidth[11][5],objHeight[11][5],vOffset[11][5],hOffset[11][5], color_o[11][5], upEnable[11][5], downEnable[11][5], leftEnable[11][5], rightEnable[11][5],visible [11][5]);  
//    Rectangle screen_5_rect_12(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[12][5],hStartPos[12][5],objWidth[12][5],objHeight[12][5],vOffset[12][5],hOffset[12][5], color_o[12][5], upEnable[12][5], downEnable[12][5], leftEnable[12][5], rightEnable[12][5],visible [12][5]);
//    Rectangle screen_5_rect_13(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[13][5],hStartPos[13][5],objWidth[13][5],objHeight[13][5],vOffset[13][5],hOffset[13][5], color_o[13][5], upEnable[13][5], downEnable[13][5], leftEnable[13][5], rightEnable[13][5],visible [13][5]);
//    Rectangle screen_5_rect_14(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[14][5],hStartPos[14][5],objWidth[14][5],objHeight[14][5],vOffset[14][5],hOffset[14][5], color_o[14][5], upEnable[14][5], downEnable[14][5], leftEnable[14][5], rightEnable[14][5],visible [14][5]);
//    Rectangle screen_5_rect_15(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[15][5],hStartPos[15][5],objWidth[15][5],objHeight[15][5],vOffset[15][5],hOffset[15][5], color_o[15][5], upEnable[15][5], downEnable[15][5], leftEnable[15][5], rightEnable[15][5],visible [15][5]);  
//    Rectangle screen_5_rect_16(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[16][5],hStartPos[16][5],objWidth[16][5],objHeight[16][5],vOffset[16][5],hOffset[16][5], color_o[16][5], upEnable[16][5], downEnable[16][5], leftEnable[16][5], rightEnable[16][5],visible [16][5]);
//    Rectangle screen_5_rect_17(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[17][5],hStartPos[17][5],objWidth[17][5],objHeight[17][5],vOffset[17][5],hOffset[17][5], color_o[17][5], upEnable[17][5], downEnable[17][5], leftEnable[17][5], rightEnable[17][5],visible [17][5]);
//    Rectangle screen_5_rect_18(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[18][5],hStartPos[18][5],objWidth[18][5],objHeight[18][5],vOffset[18][5],hOffset[18][5], color_o[18][5], upEnable[18][5], downEnable[18][5], leftEnable[18][5], rightEnable[18][5],visible [18][5]);
//    Rectangle screen_5_rect_19(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[19][5],hStartPos[19][5],objWidth[19][5],objHeight[19][5],vOffset[19][5],hOffset[19][5], color_o[19][5], upEnable[19][5], downEnable[19][5], leftEnable[19][5], rightEnable[19][5],visible [19][5]);  
//    Rectangle screen_5_rect_20(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[20][5],hStartPos[20][5],objWidth[20][5],objHeight[20][5],vOffset[20][5],hOffset[20][5], color_o[20][5], upEnable[20][5], downEnable[20][5], leftEnable[20][5], rightEnable[20][5],visible [20][5]);
//    Rectangle screen_5_rect_21(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[21][5],hStartPos[21][5],objWidth[21][5],objHeight[21][5],vOffset[21][5],hOffset[21][5], color_o[21][5], upEnable[21][5], downEnable[21][5], leftEnable[21][5], rightEnable[21][5],visible [21][5]);
//    Rectangle screen_5_rect_22(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[22][5],hStartPos[22][5],objWidth[22][5],objHeight[22][5],vOffset[22][5],hOffset[22][5], color_o[22][5], upEnable[22][5], downEnable[22][5], leftEnable[22][5], rightEnable[22][5],visible [22][5]);
//    Rectangle screen_5_rect_23(screen_5_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos,hDefault_pos,wSize,vSize,vStartPos[23][5],hStartPos[23][5],objWidth[23][5],objHeight[23][5],vOffset[23][5],hOffset[23][5], color_o[23][5], upEnable[23][5], downEnable[23][5], leftEnable[23][5], rightEnable[23][5],visible [23][5]);  
        
endmodule
