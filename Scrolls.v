`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 10:37:41 PM
// Design Name: 
// Module Name: Scrolls
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


module Scrolls(
input clk,
input [2:0] level,
input [11:0] player_hPos,
input [11:0] player_vPos,
input [3:0] player_color,
input rst,
input btnClk,
input [3:0] btns,
output   [11:0] vStartPos[3:0][5:0],
output  [11:0] hStartPos[3:0][5:0],
output  [11:0] objWidth [3:0][5:0],
output  [11:0] objHeight[3:0][5:0],
output  [31:0] vOffset[3:0][5:0],
output  [31:0] hOffset[3:0][5:0],
output [3:0] color_o[3:0][5:0],
output upEnable[3:0][5:0],
output downEnable[3:0][5:0],
output leftEnable[3:0][5:0],
output rightEnable[3:0][5:0],
//output [31:0] player_vStartPos,
//output [31:0] player_hStartPos,
output reg visible[3:0][5:0],
//output reg [31:0] hPos[3:0][5:0],
//output reg [31:0] vPos[3:0][5:0]
output [3:0] dest_rect_color,
output [11:0] dest_rect_vPos,
output [11:0] dest_rect_hPos,
output dest_rect_visible,
output level_complete
    );
    
    
    //for each
    parameter rectWidth=128; //a width allowing 3 bars to show while hiding one behind one edge border of equal width
    parameter rectHeight=12;
    
    
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
    //VISIBLE 
    parameter rectVisible=1;
    parameter rectNotVisible=0;
    
    
    
    //SCROLLING DIRECTIONS
    parameter left=     4'b0001;
    parameter right=    4'b0010;
    parameter down=     4'b0100;
    parameter up=       4'b1000;
    parameter notMoving=4'd0;
 //SCROLL 0
 
    parameter row_num=5;
    parameter col_num=1;
       
    parameter scroll_vOffset=12*row_num; 
    parameter scroll_hOffset=128*col_num;
    
    //rect 1 
    parameter rect1_vStartPos =scroll_vOffset;
    parameter rect1_hStartPos=scroll_hOffset;
    
    //rect2 
    parameter rect2_vStartPos=scroll_vOffset;
    parameter rect2_hStartPos=2*scroll_hOffset;
       
    //rect3
    parameter rect3_vStartPos=scroll_vOffset;
    parameter rect3_hStartPos=3*scroll_hOffset;     
    
    //rect4 
    parameter rect4_vStartPos=scroll_vOffset;
    parameter rect4_hStartPos=4*scroll_hOffset;
    
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
    
    reg  scroll_0_visible;
    reg  scroll_1_visible;
    reg  scroll_2_visible;
    reg  scroll_3_visible;
    reg  scroll_4_visible;
    reg  scroll_5_visible;
    //Destination rectangle postion
    reg [31:0] rect_vStart;
    reg [31:0] rect_hStart;
    
/*This always block enables and disables rectangles by setting 
 the visible property on and off based on level input */  
always@(level,rst,btnClk) begin
    if(rst==1)
    begin
    scroll_0_visible<=0;
    scroll_1_visible<=0;
    scroll_2_visible<=0;
    scroll_3_visible<=0;
    scroll_4_visible<=0;
    scroll_5_visible<=0;
    //place destination rectangle at top middle
    rect_vStart<=12;
    rect_hStart<=128+12*16;  

    end  
     if(level==0)begin
        //dont show any scrolls
        scroll_0_visible<=0;
        scroll_1_visible<=0;
        scroll_2_visible<=0;
        scroll_3_visible<=0;
        scroll_4_visible<=0;
        scroll_5_visible<=0;
        //place destination rectangle at top middle
        rect_vStart<=12;
        rect_hStart<=128+12*16;  
     end   
    else if(level==1)begin

        scroll_0_visible<=1;
        scroll_1_visible<=0;
        scroll_2_visible<=0;
        scroll_3_visible<=0;
        scroll_4_visible<=0;
        scroll_5_visible<=1;
        //place destination rectangle at bottom middle
        rect_vStart<=12+12*37;
        rect_hStart<=128+12*16;  
     end   
    else if(level==2)begin

        scroll_0_visible<=1;
        scroll_1_visible<=1;
        scroll_2_visible<=0;
        scroll_3_visible<=0;
        scroll_4_visible<=1;
        scroll_5_visible<=1;
        //place destination rectangle at top middle
        rect_vStart<=12;
        rect_hStart<=128+12*16;  
     end
   else if(level==3) begin
        scroll_0_visible<=1; 
        scroll_1_visible<=1; 
        scroll_2_visible<=1; 
        scroll_3_visible<=1; 
        scroll_4_visible<=1; 
        scroll_5_visible<=1; 
        //place destination rectangle at bottom middle
        rect_vStart<=12+12*37;
        rect_hStart<=128+12*16;  
            end

    else 
    begin
        scroll_0_visible<=0;  
        scroll_1_visible<=0; 
        scroll_2_visible<=0; 
        scroll_3_visible<=0; 
        scroll_4_visible<=0; 
        scroll_5_visible<=0;
        //place destination rectangle at top middle 
        rect_vStart<=12;
        rect_hStart<=128+12*16;  
        end
end

 //=======================================================================================
 //DESTINGATION RECTANGLE  
 //=======================================================================================
/*module DestRect(
input rst,
input visible,
input [3:0] rect_color,
input [31:0] player_hPos,
input [31:0] player_vPos,
input  [31:0] vStartPos,
input  [31:0] hStartPos,
output  [31:0] vStartPos_o,
output  [31:0] hStartPos_o,
output [3:0] rect_color_o,
output visible_o,
output reg level_complete
     );*/
     
       
        DestRect destination_Rectangle(
        clk,
        rst,
        rectVisible, 
        green,
        player_hPos,
        player_vPos,
        rect_vStart,
        rect_hStart,
        dest_rect_vPos,
        dest_rect_hPos, 
        dest_rect_color, 
        dest_rect_visible, 
        level_complete
        );



 //=======================================================================================
 //SCROLL 0   
 //=======================================================================================
/*module Rectangle(
     input  visible, 
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

        //scroll 0 
        Rectangle scroll_0_rect_1(scroll_0_visible,player_color, red    ,passable,player_hPos,player_vPos,rst,btnClk,right,rect1_vStartPos,rect1_hStartPos,rectWidth,rectHeight,vStartPos[0][0],hStartPos[0][0],objWidth[0][0],objHeight[0][0],vOffset[0][0],hOffset[0][0], color_o[0][0], upEnable[0][0], downEnable[0][0], leftEnable[0][0], rightEnable[0][0],visible [0][0]);
        Rectangle scroll_0_rect_2(scroll_0_visible,player_color, cyan   ,passable,player_hPos,player_vPos,rst,btnClk,right,rect2_vStartPos,rect2_hStartPos,rectWidth,rectHeight,vStartPos[1][0],hStartPos[1][0],objWidth[1][0],objHeight[1][0],vOffset[1][0],hOffset[1][0], color_o[1][0], upEnable[1][0], downEnable[1][0], leftEnable[1][0], rightEnable[1][0],visible [1][0]);
        Rectangle scroll_0_rect_3(scroll_0_visible,player_color, yellow ,passable,player_hPos,player_vPos,rst,btnClk,right,rect3_vStartPos,rect3_hStartPos,rectWidth,rectHeight,vStartPos[2][0],hStartPos[2][0],objWidth[2][0],objHeight[2][0],vOffset[2][0],hOffset[2][0], color_o[2][0], upEnable[2][0], downEnable[2][0], leftEnable[2][0], rightEnable[2][0],visible [2][0]);
        Rectangle scroll_0_rect_4(scroll_0_visible,player_color, magenta,passable,player_hPos,player_vPos,rst,btnClk,right,rect4_vStartPos,rect4_hStartPos,rectWidth,rectHeight,vStartPos[3][0],hStartPos[3][0],objWidth[3][0],objHeight[3][0],vOffset[3][0],hOffset[3][0], color_o[3][0], upEnable[3][0], downEnable[3][0], leftEnable[3][0], rightEnable[3][0],visible [3][0]);    

 
 //=======================================================================================
 //SCROLL 1   
 //=======================================================================================
         parameter row_num1=10;
         parameter col_num1=1;
            
         parameter scroll_vOffset1=12*row_num1; 
         parameter scroll_hOffset1=128*col_num1;
       
       //rect 1 
       parameter rect1_vStartPos1 =scroll_vOffset1;
       parameter rect1_hStartPos1=scroll_hOffset1;
       
       //rect2 
       parameter rect2_vStartPos1=scroll_vOffset1;
       parameter rect2_hStartPos1=2*scroll_hOffset1;
          
       //rect3
       parameter rect3_vStartPos1=scroll_vOffset1;
       parameter rect3_hStartPos1=3*scroll_hOffset1;     
       
       //rect4 
       parameter rect4_vStartPos1=scroll_vOffset1;
       parameter rect4_hStartPos1=4*scroll_hOffset1;    
       
       Rectangle scroll_1_rect_1(scroll_1_visible,player_color, red,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect1_vStartPos1,rect1_hStartPos1,rectWidth,rectHeight,vStartPos[0][1],hStartPos[0][1],objWidth[0][1],objHeight[0][1],vOffset[0][1],hOffset[0][1], color_o[0][1], upEnable[0][1], downEnable[0][1], leftEnable[0][1], rightEnable[0][1],visible [0][1]);
       Rectangle scroll_1_rect_2(scroll_1_visible,player_color, cyan,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect2_vStartPos1,rect2_hStartPos1,rectWidth,rectHeight,vStartPos[1][1],hStartPos[1][1],objWidth[1][1],objHeight[1][1],vOffset[1][1],hOffset[1][1], color_o[1][1], upEnable[1][1], downEnable[1][1], leftEnable[1][1], rightEnable[1][1],visible [1][1]);
       Rectangle scroll_1_rect_3(scroll_1_visible,player_color, yellow,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect3_vStartPos1,rect3_hStartPos1,rectWidth,rectHeight,vStartPos[2][1],hStartPos[2][1],objWidth[2][1],objHeight[2][1],vOffset[2][1],hOffset[2][1], color_o[2][1], upEnable[2][1], downEnable[2][1], leftEnable[2][1], rightEnable[2][1],visible [2][1]);
       Rectangle scroll_1_rect_4(scroll_1_visible,player_color, magenta,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect4_vStartPos1,rect4_hStartPos1,rectWidth,rectHeight,vStartPos[3][1],hStartPos[3][1],objWidth[3][1],objHeight[3][1],vOffset[3][1],hOffset[3][1], color_o[3][1], upEnable[3][1], downEnable[3][1], leftEnable[3][1], rightEnable[3][1],visible [3][1]);  
    

     //=======================================================================================
     //SCROLL 2   
     //=======================================================================================
           parameter row_num2=17;
           parameter col_num2=1;
        
           parameter scroll_vOffset2=12*row_num2; 
           parameter scroll_hOffset2=128*col_num2;
           
           //rect 1 
           parameter rect1_vStartPos2 =scroll_vOffset2;
           parameter rect1_hStartPos2=scroll_hOffset2;
           
           //rect2 
           parameter rect2_vStartPos2=scroll_vOffset2;
           parameter rect2_hStartPos2=2*scroll_hOffset2;
              
           //rect3
           parameter rect3_vStartPos2=scroll_vOffset2;
           parameter rect3_hStartPos2=3*scroll_hOffset2;     
           
           //rect4 
           parameter rect4_vStartPos2=scroll_vOffset2;
           parameter rect4_hStartPos2=4*scroll_hOffset2;    
           
           Rectangle scroll_2_rect_1(scroll_2_visible,player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect1_vStartPos2,rect1_hStartPos2,rectWidth,rectHeight,vStartPos[0][2],hStartPos[0][2],objWidth[0][2],objHeight[0][2],vOffset[0][2],hOffset[0][2], color_o[0][2], upEnable[0][2], downEnable[0][2], leftEnable[0][2], rightEnable[0][2],visible [0][2]);
           Rectangle scroll_2_rect_2(scroll_2_visible,player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect2_vStartPos2,rect2_hStartPos2,rectWidth,rectHeight,vStartPos[1][2],hStartPos[1][2],objWidth[1][2],objHeight[1][2],vOffset[1][2],hOffset[1][2], color_o[1][2], upEnable[1][2], downEnable[1][2], leftEnable[1][2], rightEnable[1][2],visible [1][2]);
           Rectangle scroll_2_rect_3(scroll_2_visible,player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect3_vStartPos2,rect3_hStartPos2,rectWidth,rectHeight,vStartPos[2][2],hStartPos[2][2],objWidth[2][2],objHeight[2][2],vOffset[2][2],hOffset[2][2], color_o[2][2], upEnable[2][2], downEnable[2][2], leftEnable[2][2], rightEnable[2][2],visible [2][2]);
           Rectangle scroll_2_rect_4(scroll_2_visible,player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect4_vStartPos2,rect4_hStartPos2,rectWidth,rectHeight,vStartPos[3][2],hStartPos[3][2],objWidth[3][2],objHeight[3][2],vOffset[3][2],hOffset[3][2], color_o[3][2], upEnable[3][2], downEnable[3][2], leftEnable[3][2], rightEnable[3][2],visible [3][2]);  
     //=======================================================================================
     //SCROLL 3   
     //=======================================================================================
           parameter row_num3=22;
           parameter col_num3=1;
        
           parameter scroll_vOffset3=12*row_num3; 
           parameter scroll_hOffset3=128*col_num3;
           
           //rect 1 
           parameter rect1_vStartPos3 =scroll_vOffset3;
           parameter rect1_hStartPos3=scroll_hOffset3;
           
           //rect2 
           parameter rect2_vStartPos3=scroll_vOffset3;
           parameter rect2_hStartPos3=2*scroll_hOffset3;
              
           //rect3
           parameter rect3_vStartPos3=scroll_vOffset3;
           parameter rect3_hStartPos3=3*scroll_hOffset3;     
           
           //rect4 
           parameter rect4_vStartPos3=scroll_vOffset3;
           parameter rect4_hStartPos3=4*scroll_hOffset3;    
           
           Rectangle scroll_3_rect_1(scroll_3_visible,player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect1_vStartPos3,rect1_hStartPos3,rectWidth,rectHeight,vStartPos[0][3],hStartPos[0][3],objWidth[0][3],objHeight[0][3],vOffset[0][3],hOffset[0][3], color_o[0][3], upEnable[0][3], downEnable[0][3], leftEnable[0][3], rightEnable[0][3],visible [0][3]);
           Rectangle scroll_3_rect_2(scroll_3_visible,player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect2_vStartPos3,rect2_hStartPos3,rectWidth,rectHeight,vStartPos[1][3],hStartPos[1][3],objWidth[1][3],objHeight[1][3],vOffset[1][3],hOffset[1][3], color_o[1][3], upEnable[1][3], downEnable[1][3], leftEnable[1][3], rightEnable[1][3],visible [1][3]);
           Rectangle scroll_3_rect_3(scroll_3_visible,player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect3_vStartPos3,rect3_hStartPos3,rectWidth,rectHeight,vStartPos[2][3],hStartPos[2][3],objWidth[2][3],objHeight[2][3],vOffset[2][3],hOffset[2][3], color_o[2][3], upEnable[2][3], downEnable[2][3], leftEnable[2][3], rightEnable[2][3],visible [2][3]);
           Rectangle scroll_3_rect_4(scroll_3_visible,player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect4_vStartPos3,rect4_hStartPos3,rectWidth,rectHeight,vStartPos[3][3],hStartPos[3][3],objWidth[3][3],objHeight[3][3],vOffset[3][3],hOffset[3][3], color_o[3][3], upEnable[3][3], downEnable[3][3], leftEnable[3][3], rightEnable[3][3],visible [3][3]);  
        
        //=======================================================================================
        //SCROLL 4   
        //=======================================================================================
              parameter row_num4=29;
              parameter col_num4=1;
           
              parameter scroll_vOffset4=12*row_num4; 
              parameter scroll_hOffset4=128*col_num4;
              
              //rect 1 
              parameter rect1_vStartPos4 =scroll_vOffset4;
              parameter rect1_hStartPos4=scroll_hOffset4;
              
              //rect2 
              parameter rect2_vStartPos4=scroll_vOffset4;
              parameter rect2_hStartPos4=2*scroll_hOffset4;
                 
              //rect3
              parameter rect3_vStartPos4=scroll_vOffset4;
              parameter rect3_hStartPos4=3*scroll_hOffset4;     
              
              //rect4 
              parameter rect4_vStartPos4=scroll_vOffset4;
              parameter rect4_hStartPos4=4*scroll_hOffset4;    
              
              Rectangle scroll_4_rect_1(scroll_4_visible,player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect1_vStartPos4,rect1_hStartPos4,rectWidth,rectHeight,vStartPos[0][4],hStartPos[0][4],objWidth[0][4],objHeight[0][4],vOffset[0][4],hOffset[0][4], color_o[0][4], upEnable[0][4], downEnable[0][4], leftEnable[0][4], rightEnable[0][4],visible [0][4]);
              Rectangle scroll_4_rect_2(scroll_4_visible,player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect2_vStartPos4,rect2_hStartPos4,rectWidth,rectHeight,vStartPos[1][4],hStartPos[1][4],objWidth[1][4],objHeight[1][4],vOffset[1][4],hOffset[1][4], color_o[1][4], upEnable[1][4], downEnable[1][4], leftEnable[1][4], rightEnable[1][4],visible [1][4]);
              Rectangle scroll_4_rect_3(scroll_4_visible,player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect3_vStartPos4,rect3_hStartPos4,rectWidth,rectHeight,vStartPos[2][4],hStartPos[2][4],objWidth[2][4],objHeight[2][4],vOffset[2][4],hOffset[2][4], color_o[2][4], upEnable[2][4], downEnable[2][4], leftEnable[2][4], rightEnable[2][4],visible [2][4]);
              Rectangle scroll_4_rect_4(scroll_4_visible,player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect4_vStartPos4,rect4_hStartPos4,rectWidth,rectHeight,vStartPos[3][4],hStartPos[3][4],objWidth[3][4],objHeight[3][4],vOffset[3][4],hOffset[3][4], color_o[3][4], upEnable[3][4], downEnable[3][4], leftEnable[3][4], rightEnable[3][4],visible [3][4]);  

        //=======================================================================================
        //SCROLL 5   
        //=======================================================================================
              parameter row_num5=34;
              parameter col_num5=1;
           
              parameter scroll_vOffset5=12*row_num5; 
              parameter scroll_hOffset5=128*col_num4;
              //rect 1 
              parameter rect1_vStartPos5 =scroll_vOffset5;
              parameter rect1_hStartPos5=scroll_hOffset5;
              
              //rect2 
              parameter rect2_vStartPos5=scroll_vOffset5;
              parameter rect2_hStartPos5=2*scroll_hOffset5;
                 
              //rect3
              parameter rect3_vStartPos5=scroll_vOffset5;
              parameter rect3_hStartPos5=3*scroll_hOffset5;     
              
              //rect4 
              parameter rect4_vStartPos5=scroll_vOffset5;
              parameter rect4_hStartPos5=4*scroll_hOffset5;    
              
//              Rectangle scroll_5_rect_1(scroll_5_visible,player_color, red      ,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect1_vStartPos5,rect1_hStartPos5,rectWidth,rectHeight,vStartPos[0][5],hStartPos[0][5],objWidth[0][5],objHeight[0][5],vOffset[0][5],hOffset[0][5], color_o[0][5], upEnable[0][5], downEnable[0][5], leftEnable[0][5], rightEnable[0][5],visible [0][5]);
//              Rectangle scroll_5_rect_2(scroll_5_visible,player_color, cyan     ,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect2_vStartPos5,rect2_hStartPos5,rectWidth,rectHeight,vStartPos[1][5],hStartPos[1][5],objWidth[1][5],objHeight[1][5],vOffset[1][5],hOffset[1][5], color_o[1][5], upEnable[1][5], downEnable[1][5], leftEnable[1][5], rightEnable[1][5],visible [1][5]);
//              Rectangle scroll_5_rect_3(scroll_5_visible,player_color, yellow   ,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect3_vStartPos5,rect3_hStartPos5,rectWidth,rectHeight,vStartPos[2][5],hStartPos[2][5],objWidth[2][5],objHeight[2][5],vOffset[2][5],hOffset[2][5], color_o[2][5], upEnable[2][5], downEnable[2][5], leftEnable[2][5], rightEnable[2][5],visible [2][5]);
//              Rectangle scroll_5_rect_4(scroll_5_visible,player_color, magenta  ,passable,player_hPos,player_vPos,rst,btnClk,4'd1,rect4_vStartPos5,rect4_hStartPos5,rectWidth,rectHeight,vStartPos[3][5],hStartPos[3][5],objWidth[3][5],objHeight[3][5],vOffset[3][5],hOffset[3][5], color_o[3][5], upEnable[3][5], downEnable[3][5], leftEnable[3][5], rightEnable[3][5],visible [3][5]);  

                        //for test
                      Rectangle scroll_5_rect_1(scroll_5_visible,player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect1_vStartPos5,128,12,12,vStartPos[0][5],hStartPos[0][5],objWidth[0][5],objHeight[0][5],vOffset[0][5],hOffset[0][5], color_o[0][5], upEnable[0][5], downEnable[0][5], leftEnable[0][5], rightEnable[0][5],visible [0][5]);
                      Rectangle scroll_5_rect_2(scroll_5_visible,player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect2_vStartPos5,128+12,12,12,vStartPos[1][5],hStartPos[1][5],objWidth[1][5],objHeight[1][5],vOffset[1][5],hOffset[1][5], color_o[1][5], upEnable[1][5], downEnable[1][5], leftEnable[1][5], rightEnable[1][5],visible [1][5]);
                      Rectangle scroll_5_rect_3(scroll_5_visible,player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect3_vStartPos5,128+2*12,12,12,vStartPos[2][5],hStartPos[2][5],objWidth[2][5],objHeight[2][5],vOffset[2][5],hOffset[2][5], color_o[2][5], upEnable[2][5], downEnable[2][5], leftEnable[2][5], rightEnable[2][5],visible [2][5]);
                      Rectangle scroll_5_rect_4(scroll_5_visible,player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect4_vStartPos5,128+3*12,128,12,vStartPos[3][5],hStartPos[3][5],objWidth[3][5],objHeight[3][5],vOffset[3][5],hOffset[3][5], color_o[3][5], upEnable[3][5], downEnable[3][5], leftEnable[3][5], rightEnable[3][5],visible [3][5]);  


endmodule
