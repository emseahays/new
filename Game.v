`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2016 11:28:31 AM
// Design Name: 
// Module Name: Game
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


module Game(
    //video ins/outs
input clk,
input rst,
input [2:0] In, //REMOVE LATER - for diff crosshair colors
input btnDim, //CPU Reset
//input [3:0] uBtns, //btnU, btnD,btnR,btnL
input PS2_CLK,
input PS2_DATA,
output HS,
output VS,
output [3:0] vgaRed,
output [3:0] vgaGreen,
output [3:0] vgaBlue,
//audio ins/outs
input en,
output  pwmPin,
output  ampPin,
//decoder
//input btnU, 
//input btnD, 
//input btnR, 
//input btnL, 
output out2muxSel,

//GAME CONTROLLER
input modeSelect,
input dEnable //display Enable
);

wire [3:0] uBtns_w;
//for scrolls
wire [31:0] vStartPos_w [3:0][5:0];
wire [31:0] hStartPos_w [3:0][5:0];
wire [31:0] objWidth_w [3:0][5:0];
wire [31:0] objHeight_w [3:0][5:0];
wire [31:0] vOffset_w [3:0][5:0];
wire [31:0] hOffset_w [3:0][5:0];

//wire for obstacles
wire [31:0] wall_vStartPos_w [3:0][5:0];
wire [31:0] wall_hStartPos_w [3:0][5:0];
wire [31:0] wall_objWidth_w [3:0][5:0];
wire [31:0] wall_objHeight_w [3:0][5:0];
wire [31:0] wall_vOffset_w [3:0][5:0];
wire [31:0] wall_hOffset_w [3:0][5:0];

//for player obj
wire [31:0] player_vStartPos_w ;
wire [31:0] player_hStartPos_w  ;
wire [31:0] player_objWidth_w   ;
wire [31:0] player_objHeight_w  ;
wire [31:0] player_vOffset_w ;
wire [31:0] player_hOffset_w ;


wire  [3:0] player_color_w;
wire  [3:0] wall_color_w;


VideoController V1( player_color_w, wall_color_w, clk, rst, In,
    btnDim,
    uBtns_w,
    vStartPos_w,
    hStartPos_w,
    objWidth_w,
    objHeight_w,
    vOffset_w,
    hOffset_w,
    wall_vStartPos_w , 
    wall_hStartPos_w  ,
    wall_objWidth_w   ,
    wall_objHeight_w  ,
    wall_vOffset_w ,   
    wall_hOffset_w ,
    player_vStartPos_w , 
    player_hStartPos_w  ,
    player_objWidth_w   ,
    player_objHeight_w  ,
    player_vOffset_w ,   
    player_hOffset_w ,   
    HS,VS,vgaRed,vgaGreen,vgaBlue
    );

wire [2:0] sel;
Audio A1(clk,rst,sel,en,pwmPin,ampPin);


Decoder_4to3 D1(uBtns_w[3],uBtns_w[2],uBtns_w[1],uBtns_w[0],sel);

//GAME CONTROLLER
//======================================== 
wire up_Enable_w;
wire down_Enable_w;
wire left_Enable_w;
wire right_Enable_w;  

ps2interface G5(clk,PS2_CLK,PS2_DATA,rst,uBtns_w);

wire btnClk_w;

wire enableUp_w     [3:0][5:0];
wire enableDown_w  [3:0][5:0];
wire enableLeft_w [3:0][5:0];
wire enableRight_w [3:0][5:0];   

wire wall_enableUp_w     [3:0][5:0];
wire wall_enableDown_w   [3:0][5:0];
wire wall_enableLeft_w   [3:0][5:0];
wire wall_enableRight_w  [3:0][5:0];              
           
       
enableCompare G10 (
    enableUp_w,
    enableDown_w,
    enableLeft_w,
    enableRight_w,
    up_Enable_w,
    down_Enable_w,
    left_Enable_w,
    right_Enable_w);
   
   
wire btnClk2_w;
// CLOCK DIVIDER (PLAYER OBJECT)
BtnClk2 G11(clk,rst,btnClk2_w);
// CLOCK DIVIDER (RECTANGLE)
BtnClk G6(clk,rst,btnClk_w);


wire [31:0] player_hPos_w; 
wire [31:0] player_vPos_w;
// PLAYER OBJECT
PlayerObject playerObj(
    up_Enable_w,
    down_Enable_w,
    left_Enable_w,
    right_Enable_w,  
    rst,
    clk,
    uBtns_w,
    player_vStartPos_w,    
    player_hStartPos_w,   
    player_objWidth_w,   
    player_objHeight_w,   
    player_vOffset_w,      
    player_hOffset_w,
    player_hPos_w,
    player_vPos_w,
    player_color_w    
    );
          
wire [3:0] color_o_w [3:0][5:0];  
wire [3:0] wall_color_o_w [3:0][5:0];  

 
// Scrolling color bars
Scrolls G9(player_hPos_w, player_vPos_w, player_color_w, rst, btnClk_w, uBtns_w, vStartPos_w, hStartPos_w, 
objWidth_w, objHeight_w, vOffset_w, hOffset_w, color_o_w, enableUp_w, enableDown_w, enableLeft_w, enableRight_w); 

Obstacles G12(player_hPos_w, player_vPos_w, player_color_w, rst, btnClk_w, uBtns_w, wall_vStartPos_w,  wall_hStartPos_w, 
 wall_objWidth_w,  wall_objHeight_w,  wall_vOffset_w,  wall_hOffset_w, wall_color_o_w, wall_enableUp_w, wall_enableDown_w, wall_enableLeft_w, wall_enableRight_w); 

endmodule
