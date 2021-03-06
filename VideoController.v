`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 10:26:40 AM
// Design Name: 
// Module Name: VideoController
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


module VideoController(
input [9:0] screen_vStartPos [23:0][5:0],
input [9:0] screen_hStartPos [23:0][5:0],
input [9:0] screen_objWidth [23:0][5:0],
input [9:0] screen_objHeight [23:0][5:0],
input [31:0] screen_vOffset [23:0][5:0],
input [31:0] screen_hOffset[23:0][5:0],
input [3:0] screen_color [23:0][5:0],  
input screen_visible  [23:0][5:0], 
input [3:0] dest_rect_color,
input [9:0] dest_rect_vPos,
input [9:0] dest_rect_hPos,
input dest_rect_visible,
input wall_visible[23:0][5:0], 
input scroll_visible[3:0][5:0], 	
input [3:0] player_color,
input [3:0] wall_color [23:0][5:0],
input [3:0] scroll_color [3:0][5:0],

    input clk,
    input rst,
    input [2:0] In, //REMOVE LATER
    input btnDim, //CPU Reset
    input [3:0] btns,
        //stuff for wall to display
    input  [9:0] wall_vStartPos [23:0][5:0],
    input  [9:0] wall_hStartPos [23:0][5:0],
    input  [9:0] wall_objWidth  [23:0][5:0],
    input  [9:0] wall_objHeight [23:0][5:0],
    input  [31:0] wall_vOffset   [23:0][5:0],
    input  [31:0] wall_hOffset   [23:0][5:0],
    //stuff for scroll to display
    input  [9:0] vStartPos  [3:0][5:0],
    input  [9:0] hStartPos  [3:0][5:0],
    input  [9:0] objWidth   [3:0][5:0],
    input  [9:0] objHeight  [3:0][5:0],
    input  [31:0] vOffset    [3:0][5:0],
    input  [31:0] hOffset    [3:0][5:0],
    //stuff for player obj
    input  [9:0] player_vStartPos ,
    input  [9:0] player_hStartPos ,
    input  [9:0] player_objWidth ,
    input  [9:0] player_objHeight ,
    input  [31:0] player_vOffset ,
    input  [31:0] player_hOffset ,
   
    
    output HS,
    output VS,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );
    
    
    
    wire TC_w;
    wire [31:0] hCount_w;
    wire [31:0] vCount_w;
    wire [2:0] Sel_w;
    wire clkDiv_w;
    wire btnClk_w;
    wire dimCLK_w;
    wire [3:0] dimCount_w;



//    module ClockDivider(
//        input Clk_In,
//        input RST,
//        output reg Clk_Out,
//        );
    ClockDivider M1(clk,rst,clkDiv_w,btnClk_w);
    

    
//    module HCounter(
//        input clk,
//        input rst,
//        output reg [31:0] hCount,
//        output reg TC
//        );
    HCounter M2(clkDiv_w,rst,hCount_w,TC_w);
    
//    module VCounter(
//        input En,
//        input clk,
//        input rst,
//        output reg [31:0] vCount
//        );
    VCounter M3(TC_w,clkDiv_w,rst,vCount_w);
    
//    module CompareHSync(
//            input [31:0] hCount,
//            output reg HS
//            );
    CompareHSync M4(hCount_w,HS);
    
    
//    module CompareVSync(
//        input [31:0] vCount,
//        output reg VS
//        );
    CompareVSync M5(vCount_w,VS);


/*module CompareDisp(    	
    input [31:0] hCount,
input [31:0] vCount,
input [3:0] btns,
input rst,    
input clk,
//stuff for wall to display
input  [31:0] wall_vStartPos [3:0][5:0],
input  [31:0] wall_hStartPos [3:0][5:0],
input  [31:0] wall_objWidth  [3:0][5:0],
input  [31:0] wall_objHeight [3:0][5:0],
input  [31:0] wall_vOffset   [3:0][5:0],
input  [31:0] wall_hOffset   [3:0][5:0],
//input btnClk,
input  [31:0] vStartPos [3:0][5:0],
input  [31:0] hStartPos [3:0][5:0],
input  [31:0] objWidth [3:0][5:0],
input  [31:0] objHeight [3:0][5:0],
input [31:0] vOffset [3:0][5:0],
input [31:0] hOffset [3:0][5:0],
//stuff for player obj
input  [31:0] player_vStartPos ,
input  [31:0] player_hStartPos ,
input  [31:0] player_objWidth ,
input  [31:0] player_objHeight ,
input  [31:0] player_vOffset ,
input  [31:0] player_hOffset ,


input [3:0] player_color,

output reg [2:0] Sel
);*/
    CompareDisp M6(
screen_vStartPos,
screen_hStartPos ,
screen_objWidth ,
screen_objHeight ,
screen_vOffset ,
screen_hOffset,
screen_color ,  
screen_visible  ,    
    
dest_rect_color,
dest_rect_vPos,
dest_rect_hPos,
dest_rect_visible,    
wall_visible, 
    scroll_visible,    
    hCount_w,
    vCount_w,
    btns,
    rst,
    clk,
     wall_vStartPos ,
     wall_hStartPos ,
     wall_objWidth  ,
     wall_objHeight ,
     wall_vOffset   ,
     wall_hOffset   ,
    vStartPos,
    hStartPos,
    objWidth,
    objHeight,
    vOffset,
    hOffset,
    player_vStartPos ,    
    player_hStartPos  ,   
    player_objWidth   ,   
    player_objHeight  ,   
    player_vOffset ,      
    player_hOffset, 
        player_color,
        wall_color, 
        scroll_color,  
    Sel_w);
    
//    module Mux(
//        input Sel, // on or off
//        input [1:0] In, //reg, blue or green
//        output reg ColorOut
//        );
    Mux M7(Sel_w,In,dimCount_w,vgaRed, vgaGreen,vgaBlue);
     
    DimTimer M8 (clk,rst,dimCLK_w);     
    
    DimCounter M9(dimCLK_w,rst,btnDim,dimCount_w);
endmodule
