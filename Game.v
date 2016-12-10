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
input clk,
input rst,

//BUTTONS
input btnDim, //CPU Reset
//input startButton,


//SWITCHES
input [1:0] playerStatus,
// input [2:0] In, //REMOVE LATER - for diff crosshair colors

input [2:0] World,
input [2:0] Level,


// AUDIO
input en,     //enable audio

// PS2 (Keyboard)
input PS2_CLK,
input PS2_DATA,


// OUTPUTS =========================================
// VGA
output HS,
output VS,
output [3:0] vgaRed,
output [3:0] vgaGreen,
output [3:0] vgaBlue,

// AUDIO
output  pwmPin,
output  ampPin

// Other
// FSM
//output [2:0] gameStatus,
//output [2:0] level
);

wire [3:0] uBtns_w;
//for scrolls
wire [11:0] vStartPos_w [3:0][5:0];
wire [11:0] hStartPos_w [3:0][5:0];
wire [11:0] objWidth_w [3:0][5:0];
wire [11:0] objHeight_w [3:0][5:0];
wire [31:0] vOffset_w [3:0][5:0];
wire [31:0] hOffset_w [3:0][5:0];
wire [3:0] scroll_color_o_w [3:0][5:0];  
wire scroll_visible_w  [3:0][5:0]; 

//wire for obstacles (walls)
wire [11:0] wall_vStartPos_w [23:0][5:0];
wire [11:0] wall_hStartPos_w [23:0][5:0];
wire [11:0] wall_objWidth_w [23:0][5:0];
wire [11:0] wall_objHeight_w [23:0][5:0];
wire [31:0] wall_vOffset_w [23:0][5:0];
wire [31:0] wall_hOffset_w [23:0][5:0];
wire wall_visible_w  [23:0][5:0]; 
wire [3:0] wall_color_o_w [23:0][5:0];  

//wire for obstacles (screens)
wire [11:0] screen_vStartPos_w [23:0][5:0];
wire [11:0] screen_hStartPos_w [23:0][5:0];
wire [11:0] screen_objWidth_w [23:0][5:0];
wire [11:0] screen_objHeight_w [23:0][5:0];
wire [31:0] screen_vOffset_w [23:0][5:0];
wire [31:0] screen_hOffset_w [23:0][5:0];
wire [3:0] screen_color_o_w [23:0][5:0];  
wire screen_visible_w  [23:0][5:0]; 


//for player obj
wire [11:0] player_vStartPos_w;
wire [11:0] player_hStartPos_w;
wire [11:0] player_objWidth_w;
wire [11:0] player_objHeight_w;
wire [31:0] player_vOffset_w;
wire [31:0] player_hOffset_w;
wire  [3:0] player_color_w;








//WIRES FOR DESTINATION RECTANGLE
wire [3:0] dest_rect_color_w;
wire [11:0] dest_rect_vPos_w;
wire [11:0] dest_rect_hPos_w;
wire dest_rect_visible_w;
wire level_complete_w;


VideoController V1(
screen_vStartPos_w,
screen_hStartPos_w,
screen_objWidth_w,
screen_objHeight_w,
screen_vOffset_w,
screen_hOffset_w,
screen_color_o_w,
screen_visible_w,
dest_rect_color_w,
dest_rect_vPos_w,
dest_rect_hPos_w,
dest_rect_visible_w,
wall_visible_w, 
scroll_visible_w,  
player_color_w, 
wall_color_o_w, 
scroll_color_o_w, 
clk, 
rst, 
In,
btnDim,
uBtns_w,
wall_vStartPos_w , 
wall_hStartPos_w  ,
wall_objWidth_w   ,
wall_objHeight_w  ,
wall_vOffset_w ,   
wall_hOffset_w ,
vStartPos_w,
hStartPos_w,
objWidth_w,
objHeight_w,
vOffset_w,
hOffset_w,
player_vStartPos_w , 
player_hStartPos_w  ,
player_objWidth_w   ,
player_objHeight_w  ,
player_vOffset_w ,   
player_hOffset_w ,   
HS,VS,vgaRed,
vgaGreen,
vgaBlue
);

wire [2:0] sel;

//Wires for Player Object Color Switch Timer
wire color_clk_w;  
wire [3:0] color_w;

Audio A1(clk,rst,sel,en,pwmPin,ampPin);


Decoder_4to3 D1(uBtns_w[3],uBtns_w[2],uBtns_w[1],uBtns_w[0],sel);

color_clock C2 (clk,color_clk_w);
color_counter C3(color_clk_w, rst, color_w);

//GAME CONTROLLER
//======================================== 

//wires from EnableCompare for scroll collision detection
wire up_Enable_w;
wire down_Enable_w;
wire left_Enable_w;
wire right_Enable_w;  

ps2interface G5(clk,PS2_CLK,PS2_DATA,rst,uBtns_w);


wire btnClk_w;

//wires from Scroll Rectangles for scroll collision detection
wire enableUp_w     [3:0][5:0];
wire enableDown_w   [3:0][5:0];
wire enableLeft_w   [3:0][5:0];
wire enableRight_w  [3:0][5:0];   

//wires from Obstacle Rectangles for scroll collision detection
wire wall_enableUp_w     [23:0][5:0];
wire wall_enableDown_w   [23:0][5:0];
wire wall_enableLeft_w   [23:0][5:0];
wire wall_enableRight_w  [23:0][5:0];          

//wires from Obstacle Rectangles for scroll collision detection (Not Connected to Anything -- Just pleases the compiler)
wire screen_enableUp_w     [23:0][5:0];
wire screen_enableDown_w   [23:0][5:0];
wire screen_enableLeft_w   [23:0][5:0];
wire screen_enableRight_w  [23:0][5:0];     
 

       
enableCompare G10 (
    enableUp_w,
    enableDown_w,
    enableLeft_w,
    enableRight_w,
    
    wall_enableUp_w,
    wall_enableDown_w,
    wall_enableLeft_w,
    wall_enableRight_w,
    
    up_Enable_w,
    down_Enable_w,
    left_Enable_w,
    right_Enable_w);
   
   
wire btnClk2_w;
// CLOCK DIVIDER (PLAYER OBJECT)
BtnClk2 G11(clk,rst,btnClk2_w);
// CLOCK DIVIDER (RECTANGLE)
BtnClk G6(clk,rst,btnClk_w);

//Wires to Rectangles & DestRect, to know player location
wire [11:0] player_hPos_w; 
wire [11:0] player_vPos_w;

// PLAYER OBJECT
PlayerObject playerObj(
    up_Enable_w,
    down_Enable_w,
    left_Enable_w,
    right_Enable_w,  
    rst,
    clk,
    uBtns_w,
    color_w,
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
          
/*module Scrolls(
module Scrolls(
input [2:0] level,
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
//output [31:0] player_vStartPos,
//output [31:0] player_hStartPos,
output reg visible[3:0][5:0],
//output reg [31:0] hPos[3:0][5:0],
//output reg [31:0] vPos[3:0][5:0]
output [3:0] dest_rect_color,
output [31:0] dest_rect_vPos,
output [31:0] dest_rect_hPos,
output dest_rect_visible,
output level_complete
    );*/

 


Scrolls Levels(
Level,
player_hPos_w, 
player_vPos_w,
player_color_w, 
rst, 
btnClk_w, 
uBtns_w, 
vStartPos_w, 
hStartPos_w, 
objWidth_w, 
objHeight_w, 
vOffset_w, 
hOffset_w, 
scroll_color_o_w, 
enableUp_w, 
enableDown_w, 
enableLeft_w, 
enableRight_w,
scroll_visible_w,
dest_rect_color_w,
dest_rect_vPos_w,
dest_rect_hPos_w,
dest_rect_visible_w,
level_complete_w
); 


// module Obstacles -----------------------------------           
/*                            
input [1:0] world,
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
output reg visible[3:0][5:0];
*/

//wire from FSM to Obstacles
wire [2:0] world;
//wire from FSM to Scrolls
wire [2:0] level;
//wire from FSM to Screens
wire [2:0] gameStatus;

Obstacles Worlds(
World,
player_hPos_w, 
player_vPos_w, 
player_color_w, 
rst, 
btnClk_w,
uBtns_w,

wall_vStartPos_w, 
wall_hStartPos_w, 
wall_objWidth_w, 
wall_objHeight_w, 
wall_vOffset_w,  
wall_hOffset_w, 

wall_color_o_w, 

wall_enableUp_w, 
wall_enableDown_w, 
wall_enableLeft_w, 
wall_enableRight_w,
wall_visible_w
); 

Screens Display_Screens(
World,
player_hPos_w, 
player_vPos_w, 
player_color_w, 
rst, 
btnClk_w,
uBtns_w,

screen_vStartPos_w, 
screen_hStartPos_w, 
screen_objWidth_w, 
screen_objHeight_w, 
screen_vOffset_w,  
screen_hOffset_w, 

screen_color_o_w, 

screen_enableUp_w, 
screen_enableDown_w, 
screen_enableLeft_w, 
screen_enableRight_w,
screen_visible_w
); 

// wire [2:0] level;
// wire [2:0] gameStatus;
// wire [1:0] playerStatus;

//    input startButton,
//    input [1:0] playerStatus, // 0 = playing 1 = levelpass 2 = died
//    input clk,
//    input reset,
//    output reg [2:0] gameStatus,  //0 = start, 1 = playing, 2 = levelInc, 3 = worldInc, 4 = livesInc, 5= loseGame, 6 = winGame
//    output reg [1:0] world,
//    output reg [2:0] level,
//    output reg [3:0] lives
    
//FSM FSM1 (startButton, playerStatus, clk, rst, gameStatus, world, level, lives);

endmodule