`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2016 04:52:40 PM
// Design Name: 
// Module Name: Obstacles
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


module Obstacles(
input [2:0] world,
input [9:0] player_hPos,
input [9:0] player_vPos,
input [3:0] player_color,
input rst,                              
input btnClk,                           //speed of movement - depend on clk speed
input [3:0] btns,                       //direction of movement
output   [9:0] vStartPos[23:0][5:0],
output  [9:0] hStartPos[23:0][5:0],
output  [9:0] objWidth [23:0][5:0],
output  [9:0] objHeight[23:0][5:0],
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
    
    reg  wall_0_visible;
    reg  wall_1_visible;
    reg  wall_2_visible;
    reg  wall_3_visible;
    reg  wall_4_visible;
    reg  wall_5_visible;
    
always@(world, rst) begin
    if(rst==1)begin
        wall_0_visible<=0;
        wall_1_visible<=0;
        wall_2_visible<=0;
        wall_3_visible<=0;
        wall_4_visible<=0;
        wall_5_visible<=0;  
    end
    else if(world==0)begin
        wall_0_visible<=0;
        wall_1_visible<=0;
        wall_2_visible<=0;
        wall_3_visible<=0;
        wall_4_visible<=0;
        wall_5_visible<=0;  
     end
    else if(world==1)begin
        wall_0_visible<=1;
        wall_1_visible<=0;
        wall_2_visible<=0;
        wall_3_visible<=0;
        wall_4_visible<=0;
        wall_5_visible<=0;  
     end
    else if(world==2)begin 
        wall_0_visible<=0; 
        wall_1_visible<=1; 
        wall_2_visible<=0; 
        wall_3_visible<=0; 
        wall_4_visible<=0; 
        wall_5_visible<=0;     end
    else if(world==3)begin 
        wall_0_visible<=0; 
        wall_1_visible<=0; 
        wall_2_visible<=1; 
        wall_3_visible<=0; 
        wall_4_visible<=0; 
        wall_5_visible<=0;     end
    else if(world==4)begin 
        wall_0_visible<=0; 
        wall_1_visible<=0; 
        wall_2_visible<=0; 
        wall_3_visible<=1; 
        wall_4_visible<=0; 
        wall_5_visible<=0;     end
    else if(world==5)begin 
        wall_0_visible<=0; 
        wall_1_visible<=0; 
        wall_2_visible<=0; 
        wall_3_visible<=0; 
        wall_4_visible<=1; 
        wall_5_visible<=0;     end
    else if(world==6)begin 
        wall_0_visible<=0; 
        wall_1_visible<=0; 
        wall_2_visible<=0; 
        wall_3_visible<=0; 
        wall_4_visible<=0; 
        wall_5_visible<=1;         end
    else 
    begin
        wall_0_visible<=1;  
        wall_1_visible<=1; 
        wall_2_visible<=1; 
        wall_3_visible<=1; 
        wall_4_visible<=1; 
        wall_5_visible<=1; 
   
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
          Rectangle wall_0_rect_0 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+2*size,hDefault_pos+11*size,wSize*20,vSize*2,vStartPos[0 ][0],hStartPos[0 ][0],objWidth[0 ][0],objHeight[0 ][0],vOffset[0 ][0],hOffset[0 ][0], color_o[0 ][0], upEnable[0 ][0], downEnable[0 ][0], leftEnable[0 ][0], rightEnable[0 ][0],visible [0 ][0]);
          Rectangle wall_0_rect_1 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+7*size,hDefault_pos+0*size,wSize*20,vSize*2,vStartPos[1 ][0],hStartPos[1 ][0],objWidth[1 ][0],objHeight[1 ][0],vOffset[1 ][0],hOffset[1 ][0], color_o[1 ][0], upEnable[1 ][0], downEnable[1 ][0], leftEnable[1 ][0], rightEnable[1 ][0],visible [1 ][0]);
          Rectangle wall_0_rect_2 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+0*size,wSize*11,vSize*2,vStartPos[2 ][0],hStartPos[2 ][0],objWidth[2 ][0],objHeight[2 ][0],vOffset[2 ][0],hOffset[2 ][0], color_o[2 ][0], upEnable[2 ][0], downEnable[2 ][0], leftEnable[2 ][0], rightEnable[2 ][0],visible [2 ][0]);
          Rectangle wall_0_rect_3 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+22*size,wSize*10,vSize*2,vStartPos[3 ][0],hStartPos[3 ][0],objWidth[3 ][0],objHeight[3 ][0],vOffset[3 ][0],hOffset[3 ][0], color_o[3 ][0], upEnable[3 ][0], downEnable[3 ][0], leftEnable[3 ][0], rightEnable[3 ][0],visible [3 ][0]);
          Rectangle wall_0_rect_4 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+19*size,hDefault_pos+2*size,wSize*22,vSize*2,vStartPos[4 ][0],hStartPos[4 ][0],objWidth[4 ][0],objHeight[4 ][0],vOffset[4 ][0],hOffset[4 ][0], color_o[4 ][0], upEnable[4 ][0], downEnable[4 ][0], leftEnable[4 ][0], rightEnable[4 ][0],visible [4 ][0]);
          Rectangle wall_0_rect_5 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+26*size,hDefault_pos+10*size,wSize*18,vSize*2,vStartPos[5 ][0],hStartPos[5 ][0],objWidth[5 ][0],objHeight[5 ][0],vOffset[5 ][0],hOffset[5 ][0], color_o[5 ][0], upEnable[5 ][0], downEnable[5 ][0], leftEnable[5 ][0], rightEnable[5 ][0],visible [5 ][0]);
          Rectangle wall_0_rect_6 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+31*size,hDefault_pos+0*size,wSize*11,vSize*2,vStartPos[6 ][0],hStartPos[6 ][0],objWidth[6 ][0],objHeight[6 ][0],vOffset[6 ][0],hOffset[6 ][0], color_o[6 ][0], upEnable[6 ][0], downEnable[6 ][0], leftEnable[6 ][0], rightEnable[6 ][0],visible [6 ][0]);
          Rectangle wall_0_rect_7 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+31*size,hDefault_pos+22*size,wSize*10,vSize*2,vStartPos[7 ][0],hStartPos[7 ][0],objWidth[7 ][0],objHeight[7 ][0],vOffset[7 ][0],hOffset[7 ][0], color_o[7 ][0], upEnable[7 ][0], downEnable[7 ][0], leftEnable[7 ][0], rightEnable[7 ][0],visible [7 ][0]);  
          Rectangle wall_0_rect_8 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+35*size,hDefault_pos+1*size,wSize*30,vSize*2,vStartPos[8 ][0],hStartPos[8 ][0],objWidth[8 ][0],objHeight[8 ][0],vOffset[8 ][0],hOffset[8 ][0], color_o[8 ][0], upEnable[8 ][0], downEnable[8 ][0], leftEnable[8 ][0], rightEnable[8 ][0],visible [8 ][0]);
          Rectangle wall_0_rect_9 (wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+13*size,wSize*7,vSize*2,vStartPos[9 ][0],hStartPos[9 ][0],objWidth[9 ][0],objHeight[9 ][0],vOffset[9 ][0],hOffset[9 ][0], color_o[9 ][0], upEnable[9 ][0], downEnable[9 ][0], leftEnable[9 ][0], rightEnable[9 ][0],visible [9 ][0]);
          Rectangle wall_0_rect_10(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+7*size,hDefault_pos+24*size,wSize*8,vSize*2,vStartPos[10][0],hStartPos[10][0],objWidth[10][0],objHeight[10][0],vOffset[10][0],hOffset[10][0], color_o[10][0], upEnable[10][0], downEnable[10][0], leftEnable[10][0], rightEnable[10][0],visible [10][0]);
          Rectangle wall_0_rect_11(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+13*size,wSize*2,vSize*2,vStartPos[11][0],hStartPos[11][0],objWidth[11][0],objHeight[11][0],vOffset[11][0],hOffset[11][0], color_o[11][0], upEnable[11][0], downEnable[11][0], leftEnable[11][0], rightEnable[11][0],visible [11][0]);  
          Rectangle wall_0_rect_12(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+31*size,hDefault_pos+13*size,wSize*7,vSize*2,vStartPos[12][0],hStartPos[12][0],objWidth[12][0],objHeight[12][0],vOffset[12][0],hOffset[12][0], color_o[12][0], upEnable[12][0], downEnable[12][0], leftEnable[12][0], rightEnable[12][0],visible [12][0]);
          Rectangle wall_0_rect_13(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+29*size,hDefault_pos+22*size,wSize*2,vSize*2,vStartPos[13][0],hStartPos[13][0],objWidth[13][0],objHeight[13][0],vOffset[13][0],hOffset[13][0], color_o[13][0], upEnable[13][0], downEnable[13][0], leftEnable[13][0], rightEnable[13][0],visible [13][0]);
          Rectangle wall_0_rect_14(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+21*size,hDefault_pos+6*size,wSize*2,vSize*8,vStartPos[14][0],hStartPos[14][0],objWidth[14][0],objHeight[14][0],vOffset[14][0],hOffset[14][0], color_o[14][0], upEnable[14][0], downEnable[14][0], leftEnable[14][0], rightEnable[14][0],visible [14][0]);
          Rectangle wall_0_rect_15(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+24*size,hDefault_pos+0*size,wSize*4,vSize*2,vStartPos[15][0],hStartPos[15][0],objWidth[15][0],objHeight[15][0],vOffset[15][0],hOffset[15][0], color_o[15][0], upEnable[15][0], downEnable[15][0], leftEnable[15][0], rightEnable[15][0],visible [15][0]);  
          Rectangle wall_0_rect_16(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+17*size,hDefault_pos+9*size,wSize*2,vSize*2,vStartPos[16][0],hStartPos[16][0],objWidth[16][0],objHeight[16][0],vOffset[16][0],hOffset[16][0], color_o[16][0], upEnable[16][0], downEnable[16][0], leftEnable[16][0], rightEnable[16][0],visible [16][0]);
          Rectangle wall_0_rect_17(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+24*size,hDefault_pos+15*size,wSize*2,vSize*2,vStartPos[17][0],hStartPos[17][0],objWidth[17][0],objHeight[17][0],vOffset[17][0],hOffset[17][0], color_o[17][0], upEnable[17][0], downEnable[17][0], leftEnable[17][0], rightEnable[17][0],visible [17][0]);
          Rectangle wall_0_rect_18(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+21*size,hDefault_pos+19*size,wSize*2,vSize*3,vStartPos[18][0],hStartPos[18][0],objWidth[18][0],objHeight[18][0],vOffset[18][0],hOffset[18][0], color_o[18][0], upEnable[18][0], downEnable[18][0], leftEnable[18][0], rightEnable[18][0],visible [18][0]);
          Rectangle wall_0_rect_19(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+16*size,hDefault_pos+26*size,wSize*2,vSize*8,vStartPos[19][0],hStartPos[19][0],objWidth[19][0],objHeight[19][0],vOffset[19][0],hOffset[19][0], color_o[19][0], upEnable[19][0], downEnable[19][0], leftEnable[19][0], rightEnable[19][0],visible [19][0]);  
          Rectangle wall_0_rect_20(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+9*size,hDefault_pos+17*size,wSize*2,vSize*3,vStartPos[20][0],hStartPos[20][0],objWidth[20][0],objHeight[20][0],vOffset[20][0],hOffset[20][0], color_o[20][0], upEnable[20][0], downEnable[20][0], leftEnable[20][0], rightEnable[20][0],visible [20][0]);
          Rectangle wall_0_rect_21(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+24*size,hDefault_pos+23*size,wSize*2,vSize*2,vStartPos[21][0],hStartPos[21][0],objWidth[21][0],objHeight[21][0],vOffset[21][0],hOffset[21][0], color_o[21][0], upEnable[21][0], downEnable[21][0], leftEnable[21][0], rightEnable[21][0],visible [21][0]);
          Rectangle wall_0_rect_22(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+1*size,hDefault_pos+7*size,wSize*2,vSize*4,vStartPos[22][0],hStartPos[22][0],objWidth[22][0],objHeight[22][0],vOffset[22][0],hOffset[22][0], color_o[22][0], upEnable[22][0], downEnable[22][0], leftEnable[22][0], rightEnable[22][0],visible [22][0]);
          Rectangle wall_0_rect_23(wall_0_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+9*size,hDefault_pos+9*size,wSize*2,vSize*3,vStartPos[23][0],hStartPos[23][0],objWidth[23][0],objHeight[23][0],vOffset[23][0],hOffset[23][0], color_o[23][0], upEnable[23][0], downEnable[23][0], leftEnable[23][0], rightEnable[23][0],visible [23][0]);  
      
          
          //==============================================================================================================================================================================
          //WALL 1  PLAY 
          //==============================================================================================================================================================================
          //PLAY - 14 rectangles
          Rectangle wall_1_rect_0 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+2*size,hDefault_pos+0*size,wSize*15,vSize*2,vStartPos[0 ][1],hStartPos[0 ][1],objWidth[0 ][1],objHeight[0 ][1],vOffset[0 ][1],hOffset[0 ][1], color_o[0 ][1], upEnable[0 ][1], downEnable[0 ][1], leftEnable[0 ][1], rightEnable[0 ][1],visible [0 ][1]);
          Rectangle wall_1_rect_1 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+7*size,hDefault_pos+7*size,wSize*11,vSize*2,vStartPos[1 ][1],hStartPos[1 ][1],objWidth[1 ][1],objHeight[1 ][1],vOffset[1 ][1],hOffset[1 ][1], color_o[1 ][1], upEnable[1 ][1], downEnable[1 ][1], leftEnable[1 ][1], rightEnable[1 ][1],visible [1 ][1]);
          Rectangle wall_1_rect_2 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+4*size,hDefault_pos+13*size,wSize*2,vSize*5,vStartPos[2 ][1],hStartPos[2 ][1],objWidth[2 ][1],objHeight[2 ][1],vOffset[2 ][1],hOffset[2 ][1], color_o[2 ][1], upEnable[2 ][1], downEnable[2 ][1], leftEnable[2 ][1], rightEnable[2 ][1],visible [2 ][1]);
          Rectangle wall_1_rect_3 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+7*size,hDefault_pos+15*size,wSize*9,vSize*2,vStartPos[3 ][1],hStartPos[3 ][1],objWidth[3 ][1],objHeight[3 ][1],vOffset[3 ][1],hOffset[3 ][1], color_o[3 ][1], upEnable[3 ][1], downEnable[3 ][1], leftEnable[3 ][1], rightEnable[3 ][1],visible [3 ][1]);
          Rectangle wall_1_rect_4 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+7*size,hDefault_pos+26*size,wSize*6,vSize*2,vStartPos[4 ][1],hStartPos[4 ][1],objWidth[4 ][1],objHeight[4 ][1],vOffset[4 ][1],hOffset[4 ][1], color_o[4 ][1], upEnable[4 ][1], downEnable[4 ][1], leftEnable[4 ][1], rightEnable[4 ][1],visible [4 ][1]);
          Rectangle wall_1_rect_5 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+11*size,hDefault_pos+2*size,wSize*2,vSize*3,vStartPos[5 ][1],hStartPos[5 ][1],objWidth[5 ][1],objHeight[5 ][1],vOffset[5 ][1],hOffset[5 ][1], color_o[5 ][1], upEnable[5 ][1], downEnable[5 ][1], leftEnable[5 ][1], rightEnable[5 ][1],visible [5 ][1]);
          Rectangle wall_1_rect_6 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+2*size,wSize*12,vSize*2,vStartPos[6 ][1],hStartPos[6 ][1],objWidth[6 ][1],objHeight[6 ][1],vOffset[6 ][1],hOffset[6 ][1], color_o[6 ][1], upEnable[6 ][1], downEnable[6 ][1], leftEnable[6 ][1], rightEnable[6 ][1],visible [6 ][1]);
          Rectangle wall_1_rect_7 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+14*size,wSize*2,vSize*14,vStartPos[7 ][1],hStartPos[7 ][1],objWidth[7 ][1],objHeight[7 ][1],vOffset[7 ][1],hOffset[7 ][1], color_o[7 ][1], upEnable[7 ][1], downEnable[7 ][1], leftEnable[7 ][1], rightEnable[7 ][1],visible [7 ][1]);  
          Rectangle wall_1_rect_8 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+16*size,wSize*6,vSize*2,vStartPos[8 ][1],hStartPos[8 ][1],objWidth[8 ][1],objHeight[8 ][1],vOffset[8 ][1],hOffset[8 ][1], color_o[8 ][1], upEnable[8 ][1], downEnable[8 ][1], leftEnable[8 ][1], rightEnable[8 ][1],visible [8 ][1]);
          Rectangle wall_1_rect_9 (wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+10*size,hDefault_pos+22*size,wSize*2,vSize*19,vStartPos[9 ][1],hStartPos[9 ][1],objWidth[9 ][1],objHeight[9 ][1],vOffset[9 ][1],hOffset[9 ][1], color_o[9 ][1], upEnable[9 ][1], downEnable[9 ][1], leftEnable[9 ][1], rightEnable[9 ][1],visible [9 ][1]);
          Rectangle wall_1_rect_10(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+12*size,hDefault_pos+24*size,wSize*6,vSize*2,vStartPos[10][1],hStartPos[10][1],objWidth[10][1],objHeight[10][1],vOffset[10][1],hOffset[10][1], color_o[10][1], upEnable[10][1], downEnable[10][1], leftEnable[10][1], rightEnable[10][1],visible [10][1]);
          Rectangle wall_1_rect_11(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+14*size,hDefault_pos+18*size,wSize*2,vSize*17,vStartPos[11][1],hStartPos[11][1],objWidth[11][1],objHeight[11][1],vOffset[11][1],hOffset[11][1], color_o[11][1], upEnable[11][1], downEnable[11][1], leftEnable[11][1], rightEnable[11][1],visible [11][1]);  
          Rectangle wall_1_rect_12(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+19*size,hDefault_pos+2*size,wSize*10,vSize*2,vStartPos[12][1],hStartPos[12][1],objWidth[12][1],objHeight[12][1],vOffset[12][1],hOffset[12][1], color_o[12][1], upEnable[12][1], downEnable[12][1], leftEnable[12][1], rightEnable[12][1],visible [12][1]);
          Rectangle wall_1_rect_13(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+24*size,hDefault_pos+0*size,wSize*4,vSize*2,vStartPos[13][1],hStartPos[13][1],objWidth[13][1],objHeight[13][1],vOffset[13][1],hOffset[13][1], color_o[13][1], upEnable[13][1], downEnable[13][1], leftEnable[13][1], rightEnable[13][1],visible [13][1]);
          Rectangle wall_1_rect_14(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+21*size,hDefault_pos+6*size,wSize*2,vSize*15,vStartPos[14][1],hStartPos[14][1],objWidth[14][1],objHeight[14][1],vOffset[14][1],hOffset[14][1], color_o[14][1], upEnable[14][1], downEnable[14][1], leftEnable[14][1], rightEnable[14][1],visible [14][1]);
          Rectangle wall_1_rect_15(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+21*size,hDefault_pos+10*size,wSize*2,vSize*3,vStartPos[15][1],hStartPos[15][1],objWidth[15][1],objHeight[15][1],vOffset[15][1],hOffset[15][1], color_o[15][1], upEnable[15][1], downEnable[15][1], leftEnable[15][1], rightEnable[15][1],visible [15][1]);  
          Rectangle wall_1_rect_16(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+26*size,hDefault_pos+10*size,wSize*8,vSize*2,vStartPos[16][1],hStartPos[16][1],objWidth[16][1],objHeight[16][1],vOffset[16][1],hOffset[16][1], color_o[16][1], upEnable[16][1], downEnable[16][1], leftEnable[16][1], rightEnable[16][1],visible [16][1]);
          Rectangle wall_1_rect_17(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+31*size,hDefault_pos+10*size,wSize*22,vSize*2,vStartPos[17][1],hStartPos[17][1],objWidth[17][1],objHeight[17][1],vOffset[17][1],hOffset[17][1], color_o[17][1], upEnable[17][1], downEnable[17][1], leftEnable[17][1], rightEnable[17][1],visible [17][1]);
          Rectangle wall_1_rect_18(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+17*size,hDefault_pos+26*size,wSize*6,vSize*2,vStartPos[18][1],hStartPos[18][1],objWidth[18][1],objHeight[18][1],vOffset[18][1],hOffset[18][1], color_o[18][1], upEnable[18][1], downEnable[18][1], leftEnable[18][1], rightEnable[18][1],visible [18][1]);
          Rectangle wall_1_rect_19(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+22*size,hDefault_pos+24*size,wSize*6,vSize*2,vStartPos[19][1],hStartPos[19][1],objWidth[19][1],objHeight[19][1],vOffset[19][1],hOffset[19][1], color_o[19][1], upEnable[19][1], downEnable[19][1], leftEnable[19][1], rightEnable[19][1],visible [19][1]);  
          Rectangle wall_1_rect_20(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+26*size,hDefault_pos+26*size,wSize*2,vSize*5,vStartPos[20][1],hStartPos[20][1],objWidth[20][1],objHeight[20][1],vOffset[20][1],hOffset[20][1], color_o[20][1], upEnable[20][1], downEnable[20][1], leftEnable[20][1], rightEnable[20][1],visible [20][1]);
          Rectangle wall_1_rect_21(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+30*size,hDefault_pos+2*size,wSize*4,vSize*2,vStartPos[21][1],hStartPos[21][1],objWidth[21][1],objHeight[21][1],vOffset[21][1],hOffset[21][1], color_o[21][1], upEnable[21][1], downEnable[21][1], leftEnable[21][1], rightEnable[21][1],visible [21][1]);
          Rectangle wall_1_rect_22(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+2*size,hDefault_pos+17*size,wSize*15,vSize*2,vStartPos[22][1],hStartPos[22][1],objWidth[22][1],objHeight[22][1],vOffset[22][1],hOffset[22][1], color_o[22][1], upEnable[22][1], downEnable[22][1], leftEnable[22][1], rightEnable[22][1],visible [22][1]);
          Rectangle wall_1_rect_23(wall_1_visible,player_color, white,noPass,player_hPos,player_vPos,rst,btnClk,notMoving,vDefault_pos+9*size,hDefault_pos+6*size,wSize*2,vSize*3,vStartPos[23][1],hStartPos[23][1],objWidth[23][1],objHeight[23][1],vOffset[23][1],hOffset[23][1], color_o[23][1], upEnable[23][1], downEnable[23][1], leftEnable[23][1], rightEnable[23][1],visible [23][1]);  
                                 
endmodule
