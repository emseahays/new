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

input [31:0] player_hPos,
input [31:0] player_vPos,
input [3:0] player_color,
input rst,
input btnClk,
input [3:0] btns,
output   [31:0] vStartPos[3:0][5:0],
output  [31:0] hStartPos[3:0][5:0],
output  [31:0] objWidth [3:0][5:0],
output  [31:0] objHeight[3:0][5:0],
output  [31:0] vOffset[3:0][5:0],
output  [31:0] hOffset[3:0][5:0],
output [3:0] color_o[3:0][5:0],
output upEnable[3:0][5:0],
output downEnable[3:0][5:0],
output leftEnable[3:0][5:0],
output rightEnable[3:0][5:0]
//output reg [31:0] hPos[3:0][5:0],
//output reg [31:0] vPos[3:0][5:0]
    );
    
    
    //for each
    parameter rectWidth=128; //a width allowing 3 bars to show while hiding one behind one edge border of equal width
    parameter rectHeight=12;
    
    parameter red=2;
    parameter cyan=3;
    parameter yellow=4;
    parameter magenta=5;

 //SCROLL 0
 
    parameter row_num=5;
    parameter col_num=1;
       
    parameter wall_vOffset=12*row_num; 
    parameter wall_hOffset=128*col_num;
    
    //rect 1 
    parameter rect1_vStartPos =wall_vOffset;
    parameter rect1_hStartPos=wall_hOffset;
    
    //rect2 
    parameter rect2_vStartPos=wall_vOffset;
    parameter rect2_hStartPos=2*wall_hOffset;
       
    //rect3
    parameter rect3_vStartPos=wall_vOffset;
    parameter rect3_hStartPos=3*wall_hOffset;     
    
    //rect4 
    parameter rect4_vStartPos=wall_vOffset;
    parameter rect4_hStartPos=4*wall_hOffset;
    
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
    
    
    
    //scroll 0
    Rectangle wall_0_rect_1(player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect1_vStartPos,rect1_hStartPos,rectWidth,rectHeight,vStartPos[0][0],hStartPos[0][0],objWidth[0][0],objHeight[0][0],vOffset[0][0],hOffset[0][0], color_o[0][0], upEnable[0][0], downEnable[0][0], leftEnable[0][0], rightEnable[0][0]);
    Rectangle wall_0_rect_2(player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect2_vStartPos,rect2_hStartPos,rectWidth,rectHeight,vStartPos[1][0],hStartPos[1][0],objWidth[1][0],objHeight[1][0],vOffset[1][0],hOffset[1][0], color_o[1][0], upEnable[1][0], downEnable[1][0], leftEnable[1][0], rightEnable[1][0]);
    Rectangle wall_0_rect_3(player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect3_vStartPos,rect3_hStartPos,rectWidth,rectHeight,vStartPos[2][0],hStartPos[2][0],objWidth[2][0],objHeight[2][0],vOffset[2][0],hOffset[2][0], color_o[2][0], upEnable[2][0], downEnable[2][0], leftEnable[2][0], rightEnable[2][0]);
    Rectangle wall_0_rect_4(player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect4_vStartPos,rect4_hStartPos,rectWidth,rectHeight,vStartPos[3][0],hStartPos[3][0],objWidth[3][0],objHeight[3][0],vOffset[3][0],hOffset[3][0], color_o[3][0], upEnable[3][0], downEnable[3][0], leftEnable[3][0], rightEnable[3][0]);    

 
 //=======================================================================================
 //SCROLL 1   
 //=======================================================================================
         parameter row_num1=10;
         parameter col_num1=1;
            
         parameter wall_vOffset1=12*row_num1; 
         parameter wall_hOffset1=128*col_num1;
       
       //rect 1 
       parameter rect1_vStartPos1 =wall_vOffset1;
       parameter rect1_hStartPos1=wall_hOffset1;
       
       //rect2 
       parameter rect2_vStartPos1=wall_vOffset1;
       parameter rect2_hStartPos1=2*wall_hOffset1;
          
       //rect3
       parameter rect3_vStartPos1=wall_vOffset1;
       parameter rect3_hStartPos1=3*wall_hOffset1;     
       
       //rect4 
       parameter rect4_vStartPos1=wall_vOffset1;
       parameter rect4_hStartPos1=4*wall_hOffset1;    
       
       Rectangle wall_1_rect_1(player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect1_vStartPos1,rect1_hStartPos1,rectWidth,rectHeight,vStartPos[0][1],hStartPos[0][1],objWidth[0][1],objHeight[0][1],vOffset[0][1],hOffset[0][1], color_o[0][1], upEnable[0][1], downEnable[0][1], leftEnable[0][1], rightEnable[0][1]);
       Rectangle wall_1_rect_2(player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect2_vStartPos1,rect2_hStartPos1,rectWidth,rectHeight,vStartPos[1][1],hStartPos[1][1],objWidth[1][1],objHeight[1][1],vOffset[1][1],hOffset[1][1], color_o[1][1], upEnable[1][1], downEnable[1][1], leftEnable[1][1], rightEnable[1][1]);
       Rectangle wall_1_rect_3(player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect3_vStartPos1,rect3_hStartPos1,rectWidth,rectHeight,vStartPos[2][1],hStartPos[2][1],objWidth[2][1],objHeight[2][1],vOffset[2][1],hOffset[2][1], color_o[2][1], upEnable[2][1], downEnable[2][1], leftEnable[2][1], rightEnable[2][1]);
       Rectangle wall_1_rect_4(player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect4_vStartPos1,rect4_hStartPos1,rectWidth,rectHeight,vStartPos[3][1],hStartPos[3][1],objWidth[3][1],objHeight[3][1],vOffset[3][1],hOffset[3][1], color_o[3][1], upEnable[3][1], downEnable[3][1], leftEnable[3][1], rightEnable[3][1]);  
    

     //=======================================================================================
     //SCROLL 2   
     //=======================================================================================
           parameter row_num2=17;
           parameter col_num2=1;
        
           parameter wall_vOffset2=12*row_num2; 
           parameter wall_hOffset2=128*col_num2;
           
           //rect 1 
           parameter rect1_vStartPos2 =wall_vOffset2;
           parameter rect1_hStartPos2=wall_hOffset2;
           
           //rect2 
           parameter rect2_vStartPos2=wall_vOffset2;
           parameter rect2_hStartPos2=2*wall_hOffset2;
              
           //rect3
           parameter rect3_vStartPos2=wall_vOffset2;
           parameter rect3_hStartPos2=3*wall_hOffset2;     
           
           //rect4 
           parameter rect4_vStartPos2=wall_vOffset2;
           parameter rect4_hStartPos2=4*wall_hOffset2;    
           
           Rectangle wall_2_rect_1(player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect1_vStartPos2,rect1_hStartPos2,rectWidth,rectHeight,vStartPos[0][2],hStartPos[0][2],objWidth[0][2],objHeight[0][2],vOffset[0][2],hOffset[0][2], color_o[0][2], upEnable[0][2], downEnable[0][2], leftEnable[0][2], rightEnable[0][2]);
           Rectangle wall_2_rect_2(player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect2_vStartPos2,rect2_hStartPos2,rectWidth,rectHeight,vStartPos[1][2],hStartPos[1][2],objWidth[1][2],objHeight[1][2],vOffset[1][2],hOffset[1][2], color_o[1][2], upEnable[1][2], downEnable[1][2], leftEnable[1][2], rightEnable[1][2]);
           Rectangle wall_2_rect_3(player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect3_vStartPos2,rect3_hStartPos2,rectWidth,rectHeight,vStartPos[2][2],hStartPos[2][2],objWidth[2][2],objHeight[2][2],vOffset[2][2],hOffset[2][2], color_o[2][2], upEnable[2][2], downEnable[2][2], leftEnable[2][2], rightEnable[2][2]);
           Rectangle wall_2_rect_4(player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect4_vStartPos2,rect4_hStartPos2,rectWidth,rectHeight,vStartPos[3][2],hStartPos[3][2],objWidth[3][2],objHeight[3][2],vOffset[3][2],hOffset[3][2], color_o[3][2], upEnable[3][2], downEnable[3][2], leftEnable[3][2], rightEnable[3][2]);  
     //=======================================================================================
     //SCROLL 3   
     //=======================================================================================
           parameter row_num3=22;
           parameter col_num3=1;
        
           parameter wall_vOffset3=12*row_num3; 
           parameter wall_hOffset3=128*col_num3;
           
           //rect 1 
           parameter rect1_vStartPos3 =wall_vOffset3;
           parameter rect1_hStartPos3=wall_hOffset3;
           
           //rect2 
           parameter rect2_vStartPos3=wall_vOffset3;
           parameter rect2_hStartPos3=2*wall_hOffset3;
              
           //rect3
           parameter rect3_vStartPos3=wall_vOffset3;
           parameter rect3_hStartPos3=3*wall_hOffset3;     
           
           //rect4 
           parameter rect4_vStartPos3=wall_vOffset3;
           parameter rect4_hStartPos3=4*wall_hOffset3;    
           
           Rectangle wall_3_rect_1(player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect1_vStartPos3,rect1_hStartPos3,rectWidth,rectHeight,vStartPos[0][3],hStartPos[0][3],objWidth[0][3],objHeight[0][3],vOffset[0][3],hOffset[0][3], color_o[0][3], upEnable[0][3], downEnable[0][3], leftEnable[0][3], rightEnable[0][3]);
           Rectangle wall_3_rect_2(player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect2_vStartPos3,rect2_hStartPos3,rectWidth,rectHeight,vStartPos[1][3],hStartPos[1][3],objWidth[1][3],objHeight[1][3],vOffset[1][3],hOffset[1][3], color_o[1][3], upEnable[1][3], downEnable[1][3], leftEnable[1][3], rightEnable[1][3]);
           Rectangle wall_3_rect_3(player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect3_vStartPos3,rect3_hStartPos3,rectWidth,rectHeight,vStartPos[2][3],hStartPos[2][3],objWidth[2][3],objHeight[2][3],vOffset[2][3],hOffset[2][3], color_o[2][3], upEnable[2][3], downEnable[2][3], leftEnable[2][3], rightEnable[2][3]);
           Rectangle wall_3_rect_4(player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd1,rect4_vStartPos3,rect4_hStartPos3,rectWidth,rectHeight,vStartPos[3][3],hStartPos[3][3],objWidth[3][3],objHeight[3][3],vOffset[3][3],hOffset[3][3], color_o[3][3], upEnable[3][3], downEnable[3][3], leftEnable[3][3], rightEnable[3][3]);  
        
        //=======================================================================================
        //SCROLL 4   
        //=======================================================================================
              parameter row_num4=29;
              parameter col_num4=1;
           
              parameter wall_vOffset4=12*row_num4; 
              parameter wall_hOffset4=128*col_num4;
              
              //rect 1 
              parameter rect1_vStartPos4 =wall_vOffset4;
              parameter rect1_hStartPos4=wall_hOffset4;
              
              //rect2 
              parameter rect2_vStartPos4=wall_vOffset4;
              parameter rect2_hStartPos4=2*wall_hOffset4;
                 
              //rect3
              parameter rect3_vStartPos4=wall_vOffset4;
              parameter rect3_hStartPos4=3*wall_hOffset4;     
              
              //rect4 
              parameter rect4_vStartPos4=wall_vOffset4;
              parameter rect4_hStartPos4=4*wall_hOffset4;    
              
              Rectangle wall_4_rect_1(player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect1_vStartPos4,rect1_hStartPos4,rectWidth,rectHeight,vStartPos[0][4],hStartPos[0][4],objWidth[0][4],objHeight[0][4],vOffset[0][4],hOffset[0][4], color_o[0][4], upEnable[0][4], downEnable[0][4], leftEnable[0][4], rightEnable[0][4]);
              Rectangle wall_4_rect_2(player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect2_vStartPos4,rect2_hStartPos4,rectWidth,rectHeight,vStartPos[1][4],hStartPos[1][4],objWidth[1][4],objHeight[1][4],vOffset[1][4],hOffset[1][4], color_o[1][4], upEnable[1][4], downEnable[1][4], leftEnable[1][4], rightEnable[1][4]);
              Rectangle wall_4_rect_3(player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect3_vStartPos4,rect3_hStartPos4,rectWidth,rectHeight,vStartPos[2][4],hStartPos[2][4],objWidth[2][4],objHeight[2][4],vOffset[2][4],hOffset[2][4], color_o[2][4], upEnable[2][4], downEnable[2][4], leftEnable[2][4], rightEnable[2][4]);
              Rectangle wall_4_rect_4(player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd2,rect4_vStartPos4,rect4_hStartPos4,rectWidth,rectHeight,vStartPos[3][4],hStartPos[3][4],objWidth[3][4],objHeight[3][4],vOffset[3][4],hOffset[3][4], color_o[3][4], upEnable[3][4], downEnable[3][4], leftEnable[3][4], rightEnable[3][4]);  

        //=======================================================================================
        //SCROLL 5   
        //=======================================================================================
              parameter row_num5=34;
              parameter col_num5=1;
           
              parameter wall_vOffset5=12*row_num5; 
              parameter wall_hOffset5=128*col_num5;
              
              //rect 1 
              parameter rect1_vStartPos5 =wall_vOffset5;
              parameter rect1_hStartPos5=wall_hOffset5;
              
              //rect2 
              parameter rect2_vStartPos5=wall_vOffset5;
              parameter rect2_hStartPos5=2*wall_hOffset5;
                 
              //rect3
              parameter rect3_vStartPos5=wall_vOffset5;
              parameter rect3_hStartPos5=3*wall_hOffset5;     
              
              //rect4 
              parameter rect4_vStartPos5=wall_vOffset5;
              parameter rect4_hStartPos5=4*wall_hOffset5;    
              
              Rectangle wall_5_rect_1(player_color, 4'd2,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect1_vStartPos5,rect1_hStartPos5,rectWidth,rectHeight,vStartPos[0][5],hStartPos[0][5],objWidth[0][5],objHeight[0][5],vOffset[0][5],hOffset[0][5], color_o[0][5], upEnable[0][5], downEnable[0][5], leftEnable[0][5], rightEnable[0][5]);
              Rectangle wall_5_rect_2(player_color, 4'd3,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect2_vStartPos5,rect2_hStartPos5,rectWidth,rectHeight,vStartPos[1][5],hStartPos[1][5],objWidth[1][5],objHeight[1][5],vOffset[1][5],hOffset[1][5], color_o[1][5], upEnable[1][5], downEnable[1][5], leftEnable[1][5], rightEnable[1][5]);
              Rectangle wall_5_rect_3(player_color, 4'd4,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect3_vStartPos5,rect3_hStartPos5,rectWidth,rectHeight,vStartPos[2][5],hStartPos[2][5],objWidth[2][5],objHeight[2][5],vOffset[2][5],hOffset[2][5], color_o[2][5], upEnable[2][5], downEnable[2][5], leftEnable[2][5], rightEnable[2][5]);
              Rectangle wall_5_rect_4(player_color, 4'd5,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect4_vStartPos5,rect4_hStartPos5,rectWidth,rectHeight,vStartPos[3][5],hStartPos[3][5],objWidth[3][5],objHeight[3][5],vOffset[3][5],hOffset[3][5], color_o[3][5], upEnable[3][5], downEnable[3][5], leftEnable[3][5], rightEnable[3][5]);  

//        //=======================================================================================
//        //SCROLL 6  
//        //=======================================================================================
//              parameter row_num6=34;
//              parameter col_num6=1;
           
//              parameter wall_vOffset6=12*row_num6; 
//              parameter wall_hOffset6=128*col_num6;
              
//              //rect 1 
//              parameter rect1_vStartPos6 =wall_vOffset6;
//              parameter rect1_hStartPos6=wall_hOffset6;
              
//              //rect2 
//              parameter rect2_vStartPos6=wall_vOffset6;
//              parameter rect2_hStartPos6=2*wall_hOffset6;
                 
//              //rect3
//              parameter rect3_vStartPos6=wall_vOffset4;
//              parameter rect3_hStartPos6=3*wall_hOffset4;     
              
//              //rect4 
//              parameter rect4_vStartPos6=wall_vOffset6;
//              parameter rect4_hStartPos6=4*wall_hOffset6;    
              
//              Rectangle wall_6_rect_1(4'd2,1'd1,player_hPos4,player_vPos6,rst,btnClk,4'd2,rect1_vStartPos6,rect1_hStartPos6,rectWidth,rectHeight,vStartPos[0][6],hStartPos[0][6],objWidth[0][6],objHeight[0][6],vOffset[0][6],hOffset[0][6], color_o[0][6]);
//              Rectangle wall_6_rect_2(4'd2,1'd1,player_hPos4,player_vPos6,rst,btnClk,4'd2,rect2_vStartPos6,rect2_hStartPos6,rectWidth,rectHeight,vStartPos[1][6],hStartPos[1][6],objWidth[1][6],objHeight[1][6],vOffset[1][6],hOffset[1][6], color_o[1][6]);
//              Rectangle wall_6_rect_3(4'd2,1'd1,player_hPos4,player_vPos6,rst,btnClk,4'd2,rect3_vStartPos6,rect3_hStartPos6,rectWidth,rectHeight,vStartPos[2][6],hStartPos[2][6],objWidth[2][6],objHeight[2][6],vOffset[2][6],hOffset[2][6], color_o[2][6]);
//              Rectangle wall_6_rect_4(4'd2,1'd1,player_hPos4,player_vPos6,rst,btnClk,4'd2,rect4_vStartPos6,rect4_hStartPos6,rectWidth,rectHeight,vStartPos[3][6],hStartPos[3][6],objWidth[3][6],objHeight[3][6],vOffset[3][6],hOffset[3][6], color_o[3][6]);  


endmodule
