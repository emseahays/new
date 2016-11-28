`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2016 03:45:02 PM
// Design Name: 
// Module Name: PlayerObject
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


module PlayerObject(
    input upEnable,
input downEnable,
input leftEnable,
input rightEnable,
input rst,
input btnClk2,
input [3:0] btns,
input [3:0] color,
output   [31:0] player_vStartPos,
output  [31:0] player_hStartPos,
output  [31:0] player_objWidth, 
output  [31:0] player_objHeight ,
output  [31:0] player_vOffset ,
output  [31:0] player_hOffset,
output  [31:0] hPos,
output  [31:0] vPos,
output [3:0] player_color
//output [2:0] status
);


//Size
parameter rectHeight=12;   
parameter rectWidth=12; //player obj is a square

//position
parameter vStartPos=480-2*rectHeight-6*rectHeight;
parameter hStartPos=320-rectHeight;



/*
input rst,
input btnClk,
input   [3:0] btns,
input   [3:0] color,
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
output reg [31:0] hPos,
output reg [31:0] vPos,
output [3:0] color_o,
output reg [2:0] status       //blocked, alive, dead, moving        */

PlayerRectangle rect_player_(
 upEnable,
downEnable,
leftEnable,
rightEnable,
rst,
btnClk2,
btns,
color, //red
vStartPos,
hStartPos,
rectWidth,
rectHeight,
player_vStartPos,
player_hStartPos,
player_objWidth,
player_objHeight,
player_vOffset,
player_hOffset,
hPos,
vPos,
player_color
//    status
);
endmodule   
