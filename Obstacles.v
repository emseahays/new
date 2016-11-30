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
output rightEnable[3:0][5:0],
output reg visible[3:0][5:0]
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
    parameter white=6;

 //WALL 0
 
    parameter row_num=5+3;
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
    
    reg  wall_0_visible;
    reg  wall_1_visible;
    reg  wall_2_visible;
    reg  wall_3_visible;
    reg  wall_4_visible;
    reg  wall_5_visible;
always@(*) begin
    if(world==0)begin
        wall_0_visible<=1;
        wall_1_visible<=0;
        wall_2_visible<=0;
        wall_3_visible<=0;
        wall_4_visible<=0;
        wall_5_visible<=0;  
     end
    else if(world==1)begin 
        wall_0_visible<=1; 
        wall_1_visible<=1; 
        wall_2_visible<=0; 
        wall_3_visible<=0; 
        wall_4_visible<=0; 
        wall_5_visible<=0;     end
    else if(world==2)begin 
        wall_0_visible<=1; 
        wall_1_visible<=1; 
        wall_2_visible<=1; 
        wall_3_visible<=0; 
        wall_4_visible<=0; 
        wall_5_visible<=0;     end
    else if(world==3)begin 
        wall_0_visible<=1; 
        wall_1_visible<=1; 
        wall_2_visible<=1; 
        wall_3_visible<=1; 
        wall_4_visible<=0; 
        wall_5_visible<=0;     end
    else if(world==4)begin 
        wall_0_visible<=1; 
        wall_1_visible<=1; 
        wall_2_visible<=1; 
        wall_3_visible<=1; 
        wall_4_visible<=1; 
        wall_5_visible<=0;     end
    else if(world==5)begin 
        wall_0_visible<=1; 
        wall_1_visible<=1; 
        wall_2_visible<=1; 
        wall_3_visible<=1; 
        wall_4_visible<=1; 
        wall_5_visible<=1;         end
    else 
    begin
        wall_0_visible<=0;  
        wall_1_visible<=1; 
        wall_2_visible<=0; 
        wall_3_visible<=0; 
        wall_4_visible<=0; 
        wall_5_visible<=0; 
   
        end
    
    end
        //wall 0 visible

 
 //=======================================================================================
 //WALL 1   
 //=======================================================================================
         parameter row_num1=10+3;
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
       
       //wall 1 
    

     //=======================================================================================
     //WALL 2   
     //=======================================================================================
           parameter row_num2=17+3;
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
           
     //=======================================================================================
     //WALL 3   
     //=======================================================================================
           parameter row_num3=22+3;
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
           
        
        //=======================================================================================
        //WALL 4   
        //=======================================================================================
              parameter row_num4=29+3;
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
              

        //=======================================================================================
        //WALL 5   
        //=======================================================================================
              parameter row_num5=34+3;
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
              

//        //=======================================================================================
//        //wall 6  
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
              

//              Rectangle wall_6_rect_1(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect1_vStartPos6,rect1_hStartPos6,rectWidth,rectHeight,vStartPos[0][6],hStartPos[0][6],objWidth[0][6],objHeight[0][6],vOffset[0][6],hOffset[0][6], color_o[0][6]);
//             Rectangle wall_6_rect_2(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect2_vStartPos6,rect2_hStartPos6,rectWidth,rectHeight,vStartPos[1][6],hStartPos[1][6],objWidth[1][6],objHeight[1][6],vOffset[1][6],hOffset[1][6], color_o[1][6]);
//              Rectangle wall_6_rect_3(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect3_vStartPos6,rect3_hStartPos6,rectWidth,rectHeight,vStartPos[2][6],hStartPos[2][6],objWidth[2][6],objHeight[2][6],vOffset[2][6],hOffset[2][6], color_o[2][6]);
//              Rectangle wall_6_rect_4(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect4_vStartPos6,rect4_hStartPos6,rectWidth,rectHeight,vStartPos[3][6],hStartPos[3][6],objWidth[3][6],objHeight[3][6],vOffset[3][6],hOffset[3][6], color_o[3][6]);  

//              Rectangle wall_6_rect_1(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect1_vStartPos6,rect1_hStartPos6,rectWidth,rectHeight,vStartPos[0][6],hStartPos[0][6],objWidth[0][6],objHeight[0][6],vOffset[0][6],hOffset[0][6], color_o[0][6]);
//              Rectangle wall_6_rect_2(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect2_vStartPos6,rect2_hStartPos6,rectWidth,rectHeight,vStartPos[1][6],hStartPos[1][6],objWidth[1][6],objHeight[1][6],vOffset[1][6],hOffset[1][6], color_o[1][6]);
//              Rectangle wall_6_rect_3(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect3_vStartPos6,rect3_hStartPos6,rectWidth,rectHeight,vStartPos[2][6],hStartPos[2][6],objWidth[2][6],objHeight[2][6],vOffset[2][6],hOffset[2][6], color_o[2][6]);
//              Rectangle wall_6_rect_4(4'd6,1'd1,player_hPos,player_vPos,rst,btnClk,4'd0,rect4_vStartPos6,rect4_hStartPos6,rectWidth,rectHeight,vStartPos[3][6],hStartPos[3][6],objWidth[3][6],objHeight[3][6],vOffset[3][6],hOffset[3][6], color_o[3][6]);  



endmodule
