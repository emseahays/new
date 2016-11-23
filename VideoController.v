`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 12:26:40 AM
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
input [3:0] player_color,
    input clk,
    input rst,
    input [2:0] In, //REMOVE LATER
    input btnDim, //CPU Reset
    input [3:0] btns,
    
    //stuff for scroll to display
    input  [31:0] vStartPos [3:0][5:0],
    input  [31:0] hStartPos [3:0][5:0],
    input  [31:0] objWidth [3:0][5:0],
    input  [31:0] objHeight [3:0][5:0],
    input  [31:0] vOffset [3:0][5:0],
    input  [31:0] hOffset [3:0][5:0],
    //stuff for player obj
    input  [31:0] player_vStartPos ,
    input  [31:0] player_hStartPos ,
    input  [31:0] player_objWidth ,
    input  [31:0] player_objHeight ,
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

/*    input [31:0] hCount,
input [31:0] vCount,
input [3:0] btns,
input rst,    
input clk,
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

output reg [2:0] Sel*/
    CompareDisp M6(


    
    hCount_w,
    vCount_w,
    btns,
    rst,
    clk,
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
