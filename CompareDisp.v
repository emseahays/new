`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 10:26:40 AM
// Design Name: 
// Module Name: CompareDisp
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


module CompareDisp( 
input [11:0] screen_vStartPos [23:0][5:0],
input [11:0] screen_hStartPos [23:0][5:0],
input [11:0] screen_objWidth [23:0][5:0],
input [11:0] screen_objHeight [23:0][5:0],
input [31:0] screen_vOffset [23:0][5:0],
input [31:0] screen_hOffset [23:0][5:0],
input [3:0] screen_color [23:0][5:0],  
input screen_visible  [23:0][5:0], 

input [3:0] dest_rect_color,
input [11:0] dest_rect_vPos,
input [11:0] dest_rect_hPos,
input dest_rect_visible,
input wall_visible[23:0][5:0], 
input scroll_visible[3:0][5:0],   	
input [31:0] hCount,
input [31:0] vCount,
input [3:0] btns,
input rst,    
input clk,
//stuff for wall to display
input  [11:0] wall_vStartPos [23:0][5:0],
input  [11:0] wall_hStartPos [23:0][5:0],
input  [11:0] wall_objWidth  [23:0][5:0],
input  [11:0] wall_objHeight [23:0][5:0],
input  [31:0] wall_vOffset   [23:0][5:0],
input  [31:0] wall_hOffset   [23:0][5:0],
//input btnClk,
input  [11:0] vStartPos [3:0][5:0],
input  [11:0] hStartPos [3:0][5:0],
input  [11:0] objWidth [3:0][5:0],
input  [11:0] objHeight [3:0][5:0],
input [31:0] vOffset [3:0][5:0],
input [31:0] hOffset [3:0][5:0],
//stuff for player obj
input  [11:0] player_vStartPos ,
input  [11:0] player_hStartPos ,
input  [11:0] player_objWidth ,
input  [11:0] player_objHeight ,
input  [11:0] player_vOffset ,
input  [11:0] player_hOffset ,


input [3:0] player_color,
input [3:0] wall_color [23:0][5:0],
input [3:0] scroll_color [3:0][5:0],

output reg [2:0] Sel
);

//Offsets (from VGA border)
parameter h=144;
parameter v=35;

//Display
always@( hCount, vCount) 
begin
    
    //code to make sure in display range
    if( (hCount<h||hCount>784)  ||  (vCount<v||vCount>515) ) 
    begin
        Sel<=0; //outside of display range, so dont display anything
    end
    //CODE FOR BORDERS
    else if((hCount>=h&&hCount<=h+objWidth[0][0]||hCount<=784&&hCount>=784-objWidth[0][0])||(vCount>=v&&vCount<=v+objHeight[0][0]||vCount<=515&&vCount>=515-objHeight[0][0]))
    begin 
        Sel<=6;
    end
    //CODE FOR WALLS - WORLD 1
    //game display region
    else if((hCount>=h&&hCount<=h+objWidth[0][0]||hCount<=784&&hCount>=784-objWidth[0][0])||(vCount>=v&&vCount<=v+objHeight[0][0]||vCount<=515&&vCount>=515-objHeight[0][0]))
    begin 
        Sel<=6;
    end
    //playerObj player_
    else if(hCount<=player_hStartPos+h+player_hOffset+player_objWidth&&hCount>=player_hStartPos+h+player_hOffset&&vCount<=player_vStartPos+v+player_vOffset+player_objHeight&&vCount>=player_vStartPos+v+player_vOffset)
     begin
        Sel<=player_color; //wild
    end 
    //DESTINATION RECTANGLE
    else if(dest_rect_visible==1&&hCount<=dest_rect_hPos+h+12&&hCount>=dest_rect_hPos+h&&vCount<=dest_rect_vPos+v+12&&vCount>=dest_rect_vPos+v)
     begin
        Sel<=dest_rect_color; //green
    end 
    
    //WALL 0
    else if(wall_visible[0 ][0]==1&&hCount<=wall_hStartPos[0 ][0]+h+wall_hOffset[0 ][0]+wall_objWidth[0 ][0]&&hCount>=wall_hStartPos[0 ][0]+h+wall_hOffset[0 ][0]&&vCount<=wall_vStartPos[0 ][0]+v+wall_vOffset[0 ][0]+wall_objHeight[0 ][0]&&vCount>=wall_vStartPos[0 ][0]+v+wall_vOffset[0 ][0]) Sel<=wall_color[0 ][0]; 
    else if(wall_visible[1 ][0]==1&&hCount<=wall_hStartPos[1 ][0]+h+wall_hOffset[1 ][0]+wall_objWidth[1 ][0]&&hCount>=wall_hStartPos[1 ][0]+h+wall_hOffset[1 ][0]&&vCount<=wall_vStartPos[1 ][0]+v+wall_vOffset[1 ][0]+wall_objHeight[1 ][0]&&vCount>=wall_vStartPos[1 ][0]+v+wall_vOffset[1 ][0]) Sel<=wall_color[1 ][0]; 
    else if(wall_visible[2 ][0]==1&&hCount<=wall_hStartPos[2 ][0]+h+wall_hOffset[2 ][0]+wall_objWidth[2 ][0]&&hCount>=wall_hStartPos[2 ][0]+h+wall_hOffset[2 ][0]&&vCount<=wall_vStartPos[2 ][0]+v+wall_vOffset[2 ][0]+wall_objHeight[2 ][0]&&vCount>=wall_vStartPos[2 ][0]+v+wall_vOffset[2 ][0]) Sel<=wall_color[2 ][0]; 
    else if(wall_visible[3 ][0]==1&&hCount<=wall_hStartPos[3 ][0]+h+wall_hOffset[3 ][0]+wall_objWidth[3 ][0]&&hCount>=wall_hStartPos[3 ][0]+h+wall_hOffset[3 ][0]&&vCount<=wall_vStartPos[3 ][0]+v+wall_vOffset[3 ][0]+wall_objHeight[3 ][0]&&vCount>=wall_vStartPos[3 ][0]+v+wall_vOffset[3 ][0]) Sel<=wall_color[3 ][0]; 
    else if(wall_visible[4 ][0]==1&&hCount<=wall_hStartPos[4 ][0]+h+wall_hOffset[4 ][0]+wall_objWidth[4 ][0]&&hCount>=wall_hStartPos[4 ][0]+h+wall_hOffset[4 ][0]&&vCount<=wall_vStartPos[4 ][0]+v+wall_vOffset[4 ][0]+wall_objHeight[4 ][0]&&vCount>=wall_vStartPos[4 ][0]+v+wall_vOffset[4 ][0]) Sel<=wall_color[4 ][0]; 
    else if(wall_visible[5 ][0]==1&&hCount<=wall_hStartPos[5 ][0]+h+wall_hOffset[5 ][0]+wall_objWidth[5 ][0]&&hCount>=wall_hStartPos[5 ][0]+h+wall_hOffset[5 ][0]&&vCount<=wall_vStartPos[5 ][0]+v+wall_vOffset[5 ][0]+wall_objHeight[5 ][0]&&vCount>=wall_vStartPos[5 ][0]+v+wall_vOffset[5 ][0]) Sel<=wall_color[5 ][0]; 
    else if(wall_visible[6 ][0]==1&&hCount<=wall_hStartPos[6 ][0]+h+wall_hOffset[6 ][0]+wall_objWidth[6 ][0]&&hCount>=wall_hStartPos[6 ][0]+h+wall_hOffset[6 ][0]&&vCount<=wall_vStartPos[6 ][0]+v+wall_vOffset[6 ][0]+wall_objHeight[6 ][0]&&vCount>=wall_vStartPos[6 ][0]+v+wall_vOffset[6 ][0]) Sel<=wall_color[6 ][0]; 
    else if(wall_visible[7 ][0]==1&&hCount<=wall_hStartPos[7 ][0]+h+wall_hOffset[7 ][0]+wall_objWidth[7 ][0]&&hCount>=wall_hStartPos[7 ][0]+h+wall_hOffset[7 ][0]&&vCount<=wall_vStartPos[7 ][0]+v+wall_vOffset[7 ][0]+wall_objHeight[7 ][0]&&vCount>=wall_vStartPos[7 ][0]+v+wall_vOffset[7 ][0]) Sel<=wall_color[7 ][0]; 
    else if(wall_visible[8 ][0]==1&&hCount<=wall_hStartPos[8 ][0]+h+wall_hOffset[8 ][0]+wall_objWidth[8 ][0]&&hCount>=wall_hStartPos[8 ][0]+h+wall_hOffset[8 ][0]&&vCount<=wall_vStartPos[8 ][0]+v+wall_vOffset[8 ][0]+wall_objHeight[8 ][0]&&vCount>=wall_vStartPos[8 ][0]+v+wall_vOffset[8 ][0]) Sel<=wall_color[8 ][0]; 
    else if(wall_visible[9 ][0]==1&&hCount<=wall_hStartPos[9 ][0]+h+wall_hOffset[9 ][0]+wall_objWidth[9 ][0]&&hCount>=wall_hStartPos[9 ][0]+h+wall_hOffset[9 ][0]&&vCount<=wall_vStartPos[9 ][0]+v+wall_vOffset[9 ][0]+wall_objHeight[9 ][0]&&vCount>=wall_vStartPos[9 ][0]+v+wall_vOffset[9 ][0]) Sel<=wall_color[9 ][0]; 
    else if(wall_visible[10][0]==1&&hCount<=wall_hStartPos[10][0]+h+wall_hOffset[10][0]+wall_objWidth[10][0]&&hCount>=wall_hStartPos[10][0]+h+wall_hOffset[10][0]&&vCount<=wall_vStartPos[10][0]+v+wall_vOffset[10][0]+wall_objHeight[10][0]&&vCount>=wall_vStartPos[10][0]+v+wall_vOffset[10][0]) Sel<=wall_color[10][0]; 
    else if(wall_visible[11][0]==1&&hCount<=wall_hStartPos[11][0]+h+wall_hOffset[11][0]+wall_objWidth[11][0]&&hCount>=wall_hStartPos[11][0]+h+wall_hOffset[11][0]&&vCount<=wall_vStartPos[11][0]+v+wall_vOffset[11][0]+wall_objHeight[11][0]&&vCount>=wall_vStartPos[11][0]+v+wall_vOffset[11][0]) Sel<=wall_color[11][0]; 
    else if(wall_visible[12][0]==1&&hCount<=wall_hStartPos[12][0]+h+wall_hOffset[12][0]+wall_objWidth[12][0]&&hCount>=wall_hStartPos[12][0]+h+wall_hOffset[12][0]&&vCount<=wall_vStartPos[12][0]+v+wall_vOffset[12][0]+wall_objHeight[12][0]&&vCount>=wall_vStartPos[12][0]+v+wall_vOffset[12][0]) Sel<=wall_color[12][0]; 
    else if(wall_visible[13][0]==1&&hCount<=wall_hStartPos[13][0]+h+wall_hOffset[13][0]+wall_objWidth[13][0]&&hCount>=wall_hStartPos[13][0]+h+wall_hOffset[13][0]&&vCount<=wall_vStartPos[13][0]+v+wall_vOffset[13][0]+wall_objHeight[13][0]&&vCount>=wall_vStartPos[13][0]+v+wall_vOffset[13][0]) Sel<=wall_color[13][0]; 
    else if(wall_visible[14][0]==1&&hCount<=wall_hStartPos[14][0]+h+wall_hOffset[14][0]+wall_objWidth[14][0]&&hCount>=wall_hStartPos[14][0]+h+wall_hOffset[14][0]&&vCount<=wall_vStartPos[14][0]+v+wall_vOffset[14][0]+wall_objHeight[14][0]&&vCount>=wall_vStartPos[14][0]+v+wall_vOffset[14][0]) Sel<=wall_color[14][0]; 
    else if(wall_visible[15][0]==1&&hCount<=wall_hStartPos[15][0]+h+wall_hOffset[15][0]+wall_objWidth[15][0]&&hCount>=wall_hStartPos[15][0]+h+wall_hOffset[15][0]&&vCount<=wall_vStartPos[15][0]+v+wall_vOffset[15][0]+wall_objHeight[15][0]&&vCount>=wall_vStartPos[15][0]+v+wall_vOffset[15][0]) Sel<=wall_color[15][0]; 
    else if(wall_visible[16][0]==1&&hCount<=wall_hStartPos[16][0]+h+wall_hOffset[16][0]+wall_objWidth[16][0]&&hCount>=wall_hStartPos[16][0]+h+wall_hOffset[16][0]&&vCount<=wall_vStartPos[16][0]+v+wall_vOffset[16][0]+wall_objHeight[16][0]&&vCount>=wall_vStartPos[16][0]+v+wall_vOffset[16][0]) Sel<=wall_color[16][0]; 
    else if(wall_visible[17][0]==1&&hCount<=wall_hStartPos[17][0]+h+wall_hOffset[17][0]+wall_objWidth[17][0]&&hCount>=wall_hStartPos[17][0]+h+wall_hOffset[17][0]&&vCount<=wall_vStartPos[17][0]+v+wall_vOffset[17][0]+wall_objHeight[17][0]&&vCount>=wall_vStartPos[17][0]+v+wall_vOffset[17][0]) Sel<=wall_color[17][0]; 
    else if(wall_visible[18][0]==1&&hCount<=wall_hStartPos[18][0]+h+wall_hOffset[18][0]+wall_objWidth[18][0]&&hCount>=wall_hStartPos[18][0]+h+wall_hOffset[18][0]&&vCount<=wall_vStartPos[18][0]+v+wall_vOffset[18][0]+wall_objHeight[18][0]&&vCount>=wall_vStartPos[18][0]+v+wall_vOffset[18][0]) Sel<=wall_color[18][0]; 
    else if(wall_visible[19][0]==1&&hCount<=wall_hStartPos[19][0]+h+wall_hOffset[19][0]+wall_objWidth[19][0]&&hCount>=wall_hStartPos[19][0]+h+wall_hOffset[19][0]&&vCount<=wall_vStartPos[19][0]+v+wall_vOffset[19][0]+wall_objHeight[19][0]&&vCount>=wall_vStartPos[19][0]+v+wall_vOffset[19][0]) Sel<=wall_color[19][0]; 
    else if(wall_visible[20][0]==1&&hCount<=wall_hStartPos[20][0]+h+wall_hOffset[20][0]+wall_objWidth[20][0]&&hCount>=wall_hStartPos[20][0]+h+wall_hOffset[20][0]&&vCount<=wall_vStartPos[20][0]+v+wall_vOffset[20][0]+wall_objHeight[20][0]&&vCount>=wall_vStartPos[20][0]+v+wall_vOffset[20][0]) Sel<=wall_color[20][0]; 
    else if(wall_visible[21][0]==1&&hCount<=wall_hStartPos[21][0]+h+wall_hOffset[21][0]+wall_objWidth[21][0]&&hCount>=wall_hStartPos[21][0]+h+wall_hOffset[21][0]&&vCount<=wall_vStartPos[21][0]+v+wall_vOffset[21][0]+wall_objHeight[21][0]&&vCount>=wall_vStartPos[21][0]+v+wall_vOffset[21][0]) Sel<=wall_color[21][0]; 
    else if(wall_visible[22][0]==1&&hCount<=wall_hStartPos[22][0]+h+wall_hOffset[22][0]+wall_objWidth[22][0]&&hCount>=wall_hStartPos[22][0]+h+wall_hOffset[22][0]&&vCount<=wall_vStartPos[22][0]+v+wall_vOffset[22][0]+wall_objHeight[22][0]&&vCount>=wall_vStartPos[22][0]+v+wall_vOffset[22][0]) Sel<=wall_color[22][0]; 
    else if(wall_visible[23][0]==1&&hCount<=wall_hStartPos[23][0]+h+wall_hOffset[23][0]+wall_objWidth[23][0]&&hCount>=wall_hStartPos[23][0]+h+wall_hOffset[23][0]&&vCount<=wall_vStartPos[23][0]+v+wall_vOffset[23][0]+wall_objHeight[23][0]&&vCount>=wall_vStartPos[23][0]+v+wall_vOffset[23][0]) Sel<=wall_color[23][0]; 





//WALL1
    else if(wall_visible[0 ][1]==1&&hCount<=wall_hStartPos[0 ][1]+h+wall_hOffset[0 ][1]+wall_objWidth[0 ][1]&&hCount>=wall_hStartPos[0 ][1]+h+wall_hOffset[0 ][1]&&vCount<=wall_vStartPos[0 ][1]+v+wall_vOffset[0 ][1]+wall_objHeight[0 ][1]&&vCount>=wall_vStartPos[0 ][1]+v+wall_vOffset[0 ][1]) Sel<=wall_color[0 ][1]; 
    else if(wall_visible[1 ][1]==1&&hCount<=wall_hStartPos[1 ][1]+h+wall_hOffset[1 ][1]+wall_objWidth[1 ][1]&&hCount>=wall_hStartPos[1 ][1]+h+wall_hOffset[1 ][1]&&vCount<=wall_vStartPos[1 ][1]+v+wall_vOffset[1 ][1]+wall_objHeight[1 ][1]&&vCount>=wall_vStartPos[1 ][1]+v+wall_vOffset[1 ][1]) Sel<=wall_color[1 ][1]; 
    else if(wall_visible[2 ][1]==1&&hCount<=wall_hStartPos[2 ][1]+h+wall_hOffset[2 ][1]+wall_objWidth[2 ][1]&&hCount>=wall_hStartPos[2 ][1]+h+wall_hOffset[2 ][1]&&vCount<=wall_vStartPos[2 ][1]+v+wall_vOffset[2 ][1]+wall_objHeight[2 ][1]&&vCount>=wall_vStartPos[2 ][1]+v+wall_vOffset[2 ][1]) Sel<=wall_color[2 ][1]; 
    else if(wall_visible[3 ][1]==1&&hCount<=wall_hStartPos[3 ][1]+h+wall_hOffset[3 ][1]+wall_objWidth[3 ][1]&&hCount>=wall_hStartPos[3 ][1]+h+wall_hOffset[3 ][1]&&vCount<=wall_vStartPos[3 ][1]+v+wall_vOffset[3 ][1]+wall_objHeight[3 ][1]&&vCount>=wall_vStartPos[3 ][1]+v+wall_vOffset[3 ][1]) Sel<=wall_color[3 ][1]; 
    else if(wall_visible[4 ][1]==1&&hCount<=wall_hStartPos[4 ][1]+h+wall_hOffset[4 ][1]+wall_objWidth[4 ][1]&&hCount>=wall_hStartPos[4 ][1]+h+wall_hOffset[4 ][1]&&vCount<=wall_vStartPos[4 ][1]+v+wall_vOffset[4 ][1]+wall_objHeight[4 ][1]&&vCount>=wall_vStartPos[4 ][1]+v+wall_vOffset[4 ][1]) Sel<=wall_color[4 ][1]; 
    else if(wall_visible[5 ][1]==1&&hCount<=wall_hStartPos[5 ][1]+h+wall_hOffset[5 ][1]+wall_objWidth[5 ][1]&&hCount>=wall_hStartPos[5 ][1]+h+wall_hOffset[5 ][1]&&vCount<=wall_vStartPos[5 ][1]+v+wall_vOffset[5 ][1]+wall_objHeight[5 ][1]&&vCount>=wall_vStartPos[5 ][1]+v+wall_vOffset[5 ][1]) Sel<=wall_color[5 ][1]; 
    else if(wall_visible[6 ][1]==1&&hCount<=wall_hStartPos[6 ][1]+h+wall_hOffset[6 ][1]+wall_objWidth[6 ][1]&&hCount>=wall_hStartPos[6 ][1]+h+wall_hOffset[6 ][1]&&vCount<=wall_vStartPos[6 ][1]+v+wall_vOffset[6 ][1]+wall_objHeight[6 ][1]&&vCount>=wall_vStartPos[6 ][1]+v+wall_vOffset[6 ][1]) Sel<=wall_color[6 ][1]; 
    else if(wall_visible[7 ][1]==1&&hCount<=wall_hStartPos[7 ][1]+h+wall_hOffset[7 ][1]+wall_objWidth[7 ][1]&&hCount>=wall_hStartPos[7 ][1]+h+wall_hOffset[7 ][1]&&vCount<=wall_vStartPos[7 ][1]+v+wall_vOffset[7 ][1]+wall_objHeight[7 ][1]&&vCount>=wall_vStartPos[7 ][1]+v+wall_vOffset[7 ][1]) Sel<=wall_color[7 ][1]; 
    else if(wall_visible[8 ][1]==1&&hCount<=wall_hStartPos[8 ][1]+h+wall_hOffset[8 ][1]+wall_objWidth[8 ][1]&&hCount>=wall_hStartPos[8 ][1]+h+wall_hOffset[8 ][1]&&vCount<=wall_vStartPos[8 ][1]+v+wall_vOffset[8 ][1]+wall_objHeight[8 ][1]&&vCount>=wall_vStartPos[8 ][1]+v+wall_vOffset[8 ][1]) Sel<=wall_color[8 ][1]; 
    else if(wall_visible[9 ][1]==1&&hCount<=wall_hStartPos[9 ][1]+h+wall_hOffset[9 ][1]+wall_objWidth[9 ][1]&&hCount>=wall_hStartPos[9 ][1]+h+wall_hOffset[9 ][1]&&vCount<=wall_vStartPos[9 ][1]+v+wall_vOffset[9 ][1]+wall_objHeight[9 ][1]&&vCount>=wall_vStartPos[9 ][1]+v+wall_vOffset[9 ][1]) Sel<=wall_color[9 ][1]; 
    else if(wall_visible[10][1]==1&&hCount<=wall_hStartPos[10][1]+h+wall_hOffset[10][1]+wall_objWidth[10][1]&&hCount>=wall_hStartPos[10][1]+h+wall_hOffset[10][1]&&vCount<=wall_vStartPos[10][1]+v+wall_vOffset[10][1]+wall_objHeight[10][1]&&vCount>=wall_vStartPos[10][1]+v+wall_vOffset[10][1]) Sel<=wall_color[10][1]; 
    else if(wall_visible[11][1]==1&&hCount<=wall_hStartPos[11][1]+h+wall_hOffset[11][1]+wall_objWidth[11][1]&&hCount>=wall_hStartPos[11][1]+h+wall_hOffset[11][1]&&vCount<=wall_vStartPos[11][1]+v+wall_vOffset[11][1]+wall_objHeight[11][1]&&vCount>=wall_vStartPos[11][1]+v+wall_vOffset[11][1]) Sel<=wall_color[11][1]; 
    else if(wall_visible[12][1]==1&&hCount<=wall_hStartPos[12][1]+h+wall_hOffset[12][1]+wall_objWidth[12][1]&&hCount>=wall_hStartPos[12][1]+h+wall_hOffset[12][1]&&vCount<=wall_vStartPos[12][1]+v+wall_vOffset[12][1]+wall_objHeight[12][1]&&vCount>=wall_vStartPos[12][1]+v+wall_vOffset[12][1]) Sel<=wall_color[12][1]; 
    else if(wall_visible[13][1]==1&&hCount<=wall_hStartPos[13][1]+h+wall_hOffset[13][1]+wall_objWidth[13][1]&&hCount>=wall_hStartPos[13][1]+h+wall_hOffset[13][1]&&vCount<=wall_vStartPos[13][1]+v+wall_vOffset[13][1]+wall_objHeight[13][1]&&vCount>=wall_vStartPos[13][1]+v+wall_vOffset[13][1]) Sel<=wall_color[13][1]; 
    else if(wall_visible[14][1]==1&&hCount<=wall_hStartPos[14][1]+h+wall_hOffset[14][1]+wall_objWidth[14][1]&&hCount>=wall_hStartPos[14][1]+h+wall_hOffset[14][1]&&vCount<=wall_vStartPos[14][1]+v+wall_vOffset[14][1]+wall_objHeight[14][1]&&vCount>=wall_vStartPos[14][1]+v+wall_vOffset[14][1]) Sel<=wall_color[14][1]; 
    else if(wall_visible[15][1]==1&&hCount<=wall_hStartPos[15][1]+h+wall_hOffset[15][1]+wall_objWidth[15][1]&&hCount>=wall_hStartPos[15][1]+h+wall_hOffset[15][1]&&vCount<=wall_vStartPos[15][1]+v+wall_vOffset[15][1]+wall_objHeight[15][1]&&vCount>=wall_vStartPos[15][1]+v+wall_vOffset[15][1]) Sel<=wall_color[15][1]; 
    else if(wall_visible[16][1]==1&&hCount<=wall_hStartPos[16][1]+h+wall_hOffset[16][1]+wall_objWidth[16][1]&&hCount>=wall_hStartPos[16][1]+h+wall_hOffset[16][1]&&vCount<=wall_vStartPos[16][1]+v+wall_vOffset[16][1]+wall_objHeight[16][1]&&vCount>=wall_vStartPos[16][1]+v+wall_vOffset[16][1]) Sel<=wall_color[16][1]; 
    else if(wall_visible[17][1]==1&&hCount<=wall_hStartPos[17][1]+h+wall_hOffset[17][1]+wall_objWidth[17][1]&&hCount>=wall_hStartPos[17][1]+h+wall_hOffset[17][1]&&vCount<=wall_vStartPos[17][1]+v+wall_vOffset[17][1]+wall_objHeight[17][1]&&vCount>=wall_vStartPos[17][1]+v+wall_vOffset[17][1]) Sel<=wall_color[17][1]; 
    else if(wall_visible[18][1]==1&&hCount<=wall_hStartPos[18][1]+h+wall_hOffset[18][1]+wall_objWidth[18][1]&&hCount>=wall_hStartPos[18][1]+h+wall_hOffset[18][1]&&vCount<=wall_vStartPos[18][1]+v+wall_vOffset[18][1]+wall_objHeight[18][1]&&vCount>=wall_vStartPos[18][1]+v+wall_vOffset[18][1]) Sel<=wall_color[18][1]; 
    else if(wall_visible[19][1]==1&&hCount<=wall_hStartPos[19][1]+h+wall_hOffset[19][1]+wall_objWidth[19][1]&&hCount>=wall_hStartPos[19][1]+h+wall_hOffset[19][1]&&vCount<=wall_vStartPos[19][1]+v+wall_vOffset[19][1]+wall_objHeight[19][1]&&vCount>=wall_vStartPos[19][1]+v+wall_vOffset[19][1]) Sel<=wall_color[19][1]; 
    else if(wall_visible[20][1]==1&&hCount<=wall_hStartPos[20][1]+h+wall_hOffset[20][1]+wall_objWidth[20][1]&&hCount>=wall_hStartPos[20][1]+h+wall_hOffset[20][1]&&vCount<=wall_vStartPos[20][1]+v+wall_vOffset[20][1]+wall_objHeight[20][1]&&vCount>=wall_vStartPos[20][1]+v+wall_vOffset[20][1]) Sel<=wall_color[20][1]; 
    else if(wall_visible[21][1]==1&&hCount<=wall_hStartPos[21][1]+h+wall_hOffset[21][1]+wall_objWidth[21][1]&&hCount>=wall_hStartPos[21][1]+h+wall_hOffset[21][1]&&vCount<=wall_vStartPos[21][1]+v+wall_vOffset[21][1]+wall_objHeight[21][1]&&vCount>=wall_vStartPos[21][1]+v+wall_vOffset[21][1]) Sel<=wall_color[21][1]; 
    else if(wall_visible[22][1]==1&&hCount<=wall_hStartPos[22][1]+h+wall_hOffset[22][1]+wall_objWidth[22][1]&&hCount>=wall_hStartPos[22][1]+h+wall_hOffset[22][1]&&vCount<=wall_vStartPos[22][1]+v+wall_vOffset[22][1]+wall_objHeight[22][1]&&vCount>=wall_vStartPos[22][1]+v+wall_vOffset[22][1]) Sel<=wall_color[22][1]; 
    else if(wall_visible[23][1]==1&&hCount<=wall_hStartPos[23][1]+h+wall_hOffset[23][1]+wall_objWidth[23][1]&&hCount>=wall_hStartPos[23][1]+h+wall_hOffset[23][1]&&vCount<=wall_vStartPos[23][1]+v+wall_vOffset[23][1]+wall_objHeight[23][1]&&vCount>=wall_vStartPos[23][1]+v+wall_vOffset[23][1]) Sel<=wall_color[23][1]; 






//WALL 2
    else if(wall_visible[0 ][2]==1&&hCount<=wall_hStartPos[0 ][2]+h+wall_hOffset[0 ][2]+wall_objWidth[0 ][2]&&hCount>=wall_hStartPos[0 ][2]+h+wall_hOffset[0 ][2]&&vCount<=wall_vStartPos[0 ][2]+v+wall_vOffset[0 ][2]+wall_objHeight[0 ][2]&&vCount>=wall_vStartPos[0 ][2]+v+wall_vOffset[0 ][2]) Sel<=wall_color[0 ][2]; 
    else if(wall_visible[1 ][2]==1&&hCount<=wall_hStartPos[1 ][2]+h+wall_hOffset[1 ][2]+wall_objWidth[1 ][2]&&hCount>=wall_hStartPos[1 ][2]+h+wall_hOffset[1 ][2]&&vCount<=wall_vStartPos[1 ][2]+v+wall_vOffset[1 ][2]+wall_objHeight[1 ][2]&&vCount>=wall_vStartPos[1 ][2]+v+wall_vOffset[1 ][2]) Sel<=wall_color[1 ][2]; 
    else if(wall_visible[2 ][2]==1&&hCount<=wall_hStartPos[2 ][2]+h+wall_hOffset[2 ][2]+wall_objWidth[2 ][2]&&hCount>=wall_hStartPos[2 ][2]+h+wall_hOffset[2 ][2]&&vCount<=wall_vStartPos[2 ][2]+v+wall_vOffset[2 ][2]+wall_objHeight[2 ][2]&&vCount>=wall_vStartPos[2 ][2]+v+wall_vOffset[2 ][2]) Sel<=wall_color[2 ][2]; 
    else if(wall_visible[3 ][2]==1&&hCount<=wall_hStartPos[3 ][2]+h+wall_hOffset[3 ][2]+wall_objWidth[3 ][2]&&hCount>=wall_hStartPos[3 ][2]+h+wall_hOffset[3 ][2]&&vCount<=wall_vStartPos[3 ][2]+v+wall_vOffset[3 ][2]+wall_objHeight[3 ][2]&&vCount>=wall_vStartPos[3 ][2]+v+wall_vOffset[3 ][2]) Sel<=wall_color[3 ][2]; 
    else if(wall_visible[4 ][2]==1&&hCount<=wall_hStartPos[4 ][2]+h+wall_hOffset[4 ][2]+wall_objWidth[4 ][2]&&hCount>=wall_hStartPos[4 ][2]+h+wall_hOffset[4 ][2]&&vCount<=wall_vStartPos[4 ][2]+v+wall_vOffset[4 ][2]+wall_objHeight[4 ][2]&&vCount>=wall_vStartPos[4 ][2]+v+wall_vOffset[4 ][2]) Sel<=wall_color[4 ][2]; 
    else if(wall_visible[5 ][2]==1&&hCount<=wall_hStartPos[5 ][2]+h+wall_hOffset[5 ][2]+wall_objWidth[5 ][2]&&hCount>=wall_hStartPos[5 ][2]+h+wall_hOffset[5 ][2]&&vCount<=wall_vStartPos[5 ][2]+v+wall_vOffset[5 ][2]+wall_objHeight[5 ][2]&&vCount>=wall_vStartPos[5 ][2]+v+wall_vOffset[5 ][2]) Sel<=wall_color[5 ][2]; 
    else if(wall_visible[6 ][2]==1&&hCount<=wall_hStartPos[6 ][2]+h+wall_hOffset[6 ][2]+wall_objWidth[6 ][2]&&hCount>=wall_hStartPos[6 ][2]+h+wall_hOffset[6 ][2]&&vCount<=wall_vStartPos[6 ][2]+v+wall_vOffset[6 ][2]+wall_objHeight[6 ][2]&&vCount>=wall_vStartPos[6 ][2]+v+wall_vOffset[6 ][2]) Sel<=wall_color[6 ][2]; 
    else if(wall_visible[7 ][2]==1&&hCount<=wall_hStartPos[7 ][2]+h+wall_hOffset[7 ][2]+wall_objWidth[7 ][2]&&hCount>=wall_hStartPos[7 ][2]+h+wall_hOffset[7 ][2]&&vCount<=wall_vStartPos[7 ][2]+v+wall_vOffset[7 ][2]+wall_objHeight[7 ][2]&&vCount>=wall_vStartPos[7 ][2]+v+wall_vOffset[7 ][2]) Sel<=wall_color[7 ][2]; 
    else if(wall_visible[8 ][2]==1&&hCount<=wall_hStartPos[8 ][2]+h+wall_hOffset[8 ][2]+wall_objWidth[8 ][2]&&hCount>=wall_hStartPos[8 ][2]+h+wall_hOffset[8 ][2]&&vCount<=wall_vStartPos[8 ][2]+v+wall_vOffset[8 ][2]+wall_objHeight[8 ][2]&&vCount>=wall_vStartPos[8 ][2]+v+wall_vOffset[8 ][2]) Sel<=wall_color[8 ][2]; 
    else if(wall_visible[9 ][2]==1&&hCount<=wall_hStartPos[9 ][2]+h+wall_hOffset[9 ][2]+wall_objWidth[9 ][2]&&hCount>=wall_hStartPos[9 ][2]+h+wall_hOffset[9 ][2]&&vCount<=wall_vStartPos[9 ][2]+v+wall_vOffset[9 ][2]+wall_objHeight[9 ][2]&&vCount>=wall_vStartPos[9 ][2]+v+wall_vOffset[9 ][2]) Sel<=wall_color[9 ][2]; 
    else if(wall_visible[10][2]==1&&hCount<=wall_hStartPos[10][2]+h+wall_hOffset[10][2]+wall_objWidth[10][2]&&hCount>=wall_hStartPos[10][2]+h+wall_hOffset[10][2]&&vCount<=wall_vStartPos[10][2]+v+wall_vOffset[10][2]+wall_objHeight[10][2]&&vCount>=wall_vStartPos[10][2]+v+wall_vOffset[10][2]) Sel<=wall_color[10][2]; 
    else if(wall_visible[11][2]==1&&hCount<=wall_hStartPos[11][2]+h+wall_hOffset[11][2]+wall_objWidth[11][2]&&hCount>=wall_hStartPos[11][2]+h+wall_hOffset[11][2]&&vCount<=wall_vStartPos[11][2]+v+wall_vOffset[11][2]+wall_objHeight[11][2]&&vCount>=wall_vStartPos[11][2]+v+wall_vOffset[11][2]) Sel<=wall_color[11][2]; 
    else if(wall_visible[12][2]==1&&hCount<=wall_hStartPos[12][2]+h+wall_hOffset[12][2]+wall_objWidth[12][2]&&hCount>=wall_hStartPos[12][2]+h+wall_hOffset[12][2]&&vCount<=wall_vStartPos[12][2]+v+wall_vOffset[12][2]+wall_objHeight[12][2]&&vCount>=wall_vStartPos[12][2]+v+wall_vOffset[12][2]) Sel<=wall_color[12][2]; 
    else if(wall_visible[13][2]==1&&hCount<=wall_hStartPos[13][2]+h+wall_hOffset[13][2]+wall_objWidth[13][2]&&hCount>=wall_hStartPos[13][2]+h+wall_hOffset[13][2]&&vCount<=wall_vStartPos[13][2]+v+wall_vOffset[13][2]+wall_objHeight[13][2]&&vCount>=wall_vStartPos[13][2]+v+wall_vOffset[13][2]) Sel<=wall_color[13][2]; 
    else if(wall_visible[14][2]==1&&hCount<=wall_hStartPos[14][2]+h+wall_hOffset[14][2]+wall_objWidth[14][2]&&hCount>=wall_hStartPos[14][2]+h+wall_hOffset[14][2]&&vCount<=wall_vStartPos[14][2]+v+wall_vOffset[14][2]+wall_objHeight[14][2]&&vCount>=wall_vStartPos[14][2]+v+wall_vOffset[14][2]) Sel<=wall_color[14][2]; 
    else if(wall_visible[15][2]==1&&hCount<=wall_hStartPos[15][2]+h+wall_hOffset[15][2]+wall_objWidth[15][2]&&hCount>=wall_hStartPos[15][2]+h+wall_hOffset[15][2]&&vCount<=wall_vStartPos[15][2]+v+wall_vOffset[15][2]+wall_objHeight[15][2]&&vCount>=wall_vStartPos[15][2]+v+wall_vOffset[15][2]) Sel<=wall_color[15][2]; 
    else if(wall_visible[16][2]==1&&hCount<=wall_hStartPos[16][2]+h+wall_hOffset[16][2]+wall_objWidth[16][2]&&hCount>=wall_hStartPos[16][2]+h+wall_hOffset[16][2]&&vCount<=wall_vStartPos[16][2]+v+wall_vOffset[16][2]+wall_objHeight[16][2]&&vCount>=wall_vStartPos[16][2]+v+wall_vOffset[16][2]) Sel<=wall_color[16][2]; 
    else if(wall_visible[17][2]==1&&hCount<=wall_hStartPos[17][2]+h+wall_hOffset[17][2]+wall_objWidth[17][2]&&hCount>=wall_hStartPos[17][2]+h+wall_hOffset[17][2]&&vCount<=wall_vStartPos[17][2]+v+wall_vOffset[17][2]+wall_objHeight[17][2]&&vCount>=wall_vStartPos[17][2]+v+wall_vOffset[17][2]) Sel<=wall_color[17][2]; 
    else if(wall_visible[18][2]==1&&hCount<=wall_hStartPos[18][2]+h+wall_hOffset[18][2]+wall_objWidth[18][2]&&hCount>=wall_hStartPos[18][2]+h+wall_hOffset[18][2]&&vCount<=wall_vStartPos[18][2]+v+wall_vOffset[18][2]+wall_objHeight[18][2]&&vCount>=wall_vStartPos[18][2]+v+wall_vOffset[18][2]) Sel<=wall_color[18][2]; 
    else if(wall_visible[19][2]==1&&hCount<=wall_hStartPos[19][2]+h+wall_hOffset[19][2]+wall_objWidth[19][2]&&hCount>=wall_hStartPos[19][2]+h+wall_hOffset[19][2]&&vCount<=wall_vStartPos[19][2]+v+wall_vOffset[19][2]+wall_objHeight[19][2]&&vCount>=wall_vStartPos[19][2]+v+wall_vOffset[19][2]) Sel<=wall_color[19][2]; 
    else if(wall_visible[20][2]==1&&hCount<=wall_hStartPos[20][2]+h+wall_hOffset[20][2]+wall_objWidth[20][2]&&hCount>=wall_hStartPos[20][2]+h+wall_hOffset[20][2]&&vCount<=wall_vStartPos[20][2]+v+wall_vOffset[20][2]+wall_objHeight[20][2]&&vCount>=wall_vStartPos[20][2]+v+wall_vOffset[20][2]) Sel<=wall_color[20][2]; 
    else if(wall_visible[21][2]==1&&hCount<=wall_hStartPos[21][2]+h+wall_hOffset[21][2]+wall_objWidth[21][2]&&hCount>=wall_hStartPos[21][2]+h+wall_hOffset[21][2]&&vCount<=wall_vStartPos[21][2]+v+wall_vOffset[21][2]+wall_objHeight[21][2]&&vCount>=wall_vStartPos[21][2]+v+wall_vOffset[21][2]) Sel<=wall_color[21][2]; 
    else if(wall_visible[22][2]==1&&hCount<=wall_hStartPos[22][2]+h+wall_hOffset[22][2]+wall_objWidth[22][2]&&hCount>=wall_hStartPos[22][2]+h+wall_hOffset[22][2]&&vCount<=wall_vStartPos[22][2]+v+wall_vOffset[22][2]+wall_objHeight[22][2]&&vCount>=wall_vStartPos[22][2]+v+wall_vOffset[22][2]) Sel<=wall_color[22][2]; 
    else if(wall_visible[23][2]==1&&hCount<=wall_hStartPos[23][2]+h+wall_hOffset[23][2]+wall_objWidth[23][2]&&hCount>=wall_hStartPos[23][2]+h+wall_hOffset[23][2]&&vCount<=wall_vStartPos[23][2]+v+wall_vOffset[23][2]+wall_objHeight[23][2]&&vCount>=wall_vStartPos[23][2]+v+wall_vOffset[23][2]) Sel<=wall_color[23][2]; 

// WALL 3
    else if(wall_visible[0 ][3]==1&&hCount<=wall_hStartPos[0 ][3]+h+wall_hOffset[0 ][3]+wall_objWidth[0 ][3]&&hCount>=wall_hStartPos[0 ][3]+h+wall_hOffset[0 ][3]&&vCount<=wall_vStartPos[0 ][3]+v+wall_vOffset[0 ][3]+wall_objHeight[0 ][3]&&vCount>=wall_vStartPos[0 ][3]+v+wall_vOffset[0 ][3]) Sel<=wall_color[0 ][3]; 
    else if(wall_visible[1 ][3]==1&&hCount<=wall_hStartPos[1 ][3]+h+wall_hOffset[1 ][3]+wall_objWidth[1 ][3]&&hCount>=wall_hStartPos[1 ][3]+h+wall_hOffset[1 ][3]&&vCount<=wall_vStartPos[1 ][3]+v+wall_vOffset[1 ][3]+wall_objHeight[1 ][3]&&vCount>=wall_vStartPos[1 ][3]+v+wall_vOffset[1 ][3]) Sel<=wall_color[1 ][3]; 
    else if(wall_visible[2 ][3]==1&&hCount<=wall_hStartPos[2 ][3]+h+wall_hOffset[2 ][3]+wall_objWidth[2 ][3]&&hCount>=wall_hStartPos[2 ][3]+h+wall_hOffset[2 ][3]&&vCount<=wall_vStartPos[2 ][3]+v+wall_vOffset[2 ][3]+wall_objHeight[2 ][3]&&vCount>=wall_vStartPos[2 ][3]+v+wall_vOffset[2 ][3]) Sel<=wall_color[2 ][3]; 
    else if(wall_visible[3 ][3]==1&&hCount<=wall_hStartPos[3 ][3]+h+wall_hOffset[3 ][3]+wall_objWidth[3 ][3]&&hCount>=wall_hStartPos[3 ][3]+h+wall_hOffset[3 ][3]&&vCount<=wall_vStartPos[3 ][3]+v+wall_vOffset[3 ][3]+wall_objHeight[3 ][3]&&vCount>=wall_vStartPos[3 ][3]+v+wall_vOffset[3 ][3]) Sel<=wall_color[3 ][3]; 
    else if(wall_visible[4 ][3]==1&&hCount<=wall_hStartPos[4 ][3]+h+wall_hOffset[4 ][3]+wall_objWidth[4 ][3]&&hCount>=wall_hStartPos[4 ][3]+h+wall_hOffset[4 ][3]&&vCount<=wall_vStartPos[4 ][3]+v+wall_vOffset[4 ][3]+wall_objHeight[4 ][3]&&vCount>=wall_vStartPos[4 ][3]+v+wall_vOffset[4 ][3]) Sel<=wall_color[4 ][3]; 
    else if(wall_visible[5 ][3]==1&&hCount<=wall_hStartPos[5 ][3]+h+wall_hOffset[5 ][3]+wall_objWidth[5 ][3]&&hCount>=wall_hStartPos[5 ][3]+h+wall_hOffset[5 ][3]&&vCount<=wall_vStartPos[5 ][3]+v+wall_vOffset[5 ][3]+wall_objHeight[5 ][3]&&vCount>=wall_vStartPos[5 ][3]+v+wall_vOffset[5 ][3]) Sel<=wall_color[5 ][3]; 
    else if(wall_visible[6 ][3]==1&&hCount<=wall_hStartPos[6 ][3]+h+wall_hOffset[6 ][3]+wall_objWidth[6 ][3]&&hCount>=wall_hStartPos[6 ][3]+h+wall_hOffset[6 ][3]&&vCount<=wall_vStartPos[6 ][3]+v+wall_vOffset[6 ][3]+wall_objHeight[6 ][3]&&vCount>=wall_vStartPos[6 ][3]+v+wall_vOffset[6 ][3]) Sel<=wall_color[6 ][3]; 
    else if(wall_visible[7 ][3]==1&&hCount<=wall_hStartPos[7 ][3]+h+wall_hOffset[7 ][3]+wall_objWidth[7 ][3]&&hCount>=wall_hStartPos[7 ][3]+h+wall_hOffset[7 ][3]&&vCount<=wall_vStartPos[7 ][3]+v+wall_vOffset[7 ][3]+wall_objHeight[7 ][3]&&vCount>=wall_vStartPos[7 ][3]+v+wall_vOffset[7 ][3]) Sel<=wall_color[7 ][3]; 
    else if(wall_visible[8 ][3]==1&&hCount<=wall_hStartPos[8 ][3]+h+wall_hOffset[8 ][3]+wall_objWidth[8 ][3]&&hCount>=wall_hStartPos[8 ][3]+h+wall_hOffset[8 ][3]&&vCount<=wall_vStartPos[8 ][3]+v+wall_vOffset[8 ][3]+wall_objHeight[8 ][3]&&vCount>=wall_vStartPos[8 ][3]+v+wall_vOffset[8 ][3]) Sel<=wall_color[8 ][3]; 
    else if(wall_visible[9 ][3]==1&&hCount<=wall_hStartPos[9 ][3]+h+wall_hOffset[9 ][3]+wall_objWidth[9 ][3]&&hCount>=wall_hStartPos[9 ][3]+h+wall_hOffset[9 ][3]&&vCount<=wall_vStartPos[9 ][3]+v+wall_vOffset[9 ][3]+wall_objHeight[9 ][3]&&vCount>=wall_vStartPos[9 ][3]+v+wall_vOffset[9 ][3]) Sel<=wall_color[9 ][3]; 
    else if(wall_visible[10][3]==1&&hCount<=wall_hStartPos[10][3]+h+wall_hOffset[10][3]+wall_objWidth[10][3]&&hCount>=wall_hStartPos[10][3]+h+wall_hOffset[10][3]&&vCount<=wall_vStartPos[10][3]+v+wall_vOffset[10][3]+wall_objHeight[10][3]&&vCount>=wall_vStartPos[10][3]+v+wall_vOffset[10][3]) Sel<=wall_color[10][3]; 
    else if(wall_visible[11][3]==1&&hCount<=wall_hStartPos[11][3]+h+wall_hOffset[11][3]+wall_objWidth[11][3]&&hCount>=wall_hStartPos[11][3]+h+wall_hOffset[11][3]&&vCount<=wall_vStartPos[11][3]+v+wall_vOffset[11][3]+wall_objHeight[11][3]&&vCount>=wall_vStartPos[11][3]+v+wall_vOffset[11][3]) Sel<=wall_color[11][3]; 
    else if(wall_visible[12][3]==1&&hCount<=wall_hStartPos[12][3]+h+wall_hOffset[12][3]+wall_objWidth[12][3]&&hCount>=wall_hStartPos[12][3]+h+wall_hOffset[12][3]&&vCount<=wall_vStartPos[12][3]+v+wall_vOffset[12][3]+wall_objHeight[12][3]&&vCount>=wall_vStartPos[12][3]+v+wall_vOffset[12][3]) Sel<=wall_color[12][3]; 
    else if(wall_visible[13][3]==1&&hCount<=wall_hStartPos[13][3]+h+wall_hOffset[13][3]+wall_objWidth[13][3]&&hCount>=wall_hStartPos[13][3]+h+wall_hOffset[13][3]&&vCount<=wall_vStartPos[13][3]+v+wall_vOffset[13][3]+wall_objHeight[13][3]&&vCount>=wall_vStartPos[13][3]+v+wall_vOffset[13][3]) Sel<=wall_color[13][3]; 
    else if(wall_visible[14][3]==1&&hCount<=wall_hStartPos[14][3]+h+wall_hOffset[14][3]+wall_objWidth[14][3]&&hCount>=wall_hStartPos[14][3]+h+wall_hOffset[14][3]&&vCount<=wall_vStartPos[14][3]+v+wall_vOffset[14][3]+wall_objHeight[14][3]&&vCount>=wall_vStartPos[14][3]+v+wall_vOffset[14][3]) Sel<=wall_color[14][3]; 
    else if(wall_visible[15][3]==1&&hCount<=wall_hStartPos[15][3]+h+wall_hOffset[15][3]+wall_objWidth[15][3]&&hCount>=wall_hStartPos[15][3]+h+wall_hOffset[15][3]&&vCount<=wall_vStartPos[15][3]+v+wall_vOffset[15][3]+wall_objHeight[15][3]&&vCount>=wall_vStartPos[15][3]+v+wall_vOffset[15][3]) Sel<=wall_color[15][3]; 
    else if(wall_visible[16][3]==1&&hCount<=wall_hStartPos[16][3]+h+wall_hOffset[16][3]+wall_objWidth[16][3]&&hCount>=wall_hStartPos[16][3]+h+wall_hOffset[16][3]&&vCount<=wall_vStartPos[16][3]+v+wall_vOffset[16][3]+wall_objHeight[16][3]&&vCount>=wall_vStartPos[16][3]+v+wall_vOffset[16][3]) Sel<=wall_color[16][3]; 
    else if(wall_visible[17][3]==1&&hCount<=wall_hStartPos[17][3]+h+wall_hOffset[17][3]+wall_objWidth[17][3]&&hCount>=wall_hStartPos[17][3]+h+wall_hOffset[17][3]&&vCount<=wall_vStartPos[17][3]+v+wall_vOffset[17][3]+wall_objHeight[17][3]&&vCount>=wall_vStartPos[17][3]+v+wall_vOffset[17][3]) Sel<=wall_color[17][3]; 
    else if(wall_visible[18][3]==1&&hCount<=wall_hStartPos[18][3]+h+wall_hOffset[18][3]+wall_objWidth[18][3]&&hCount>=wall_hStartPos[18][3]+h+wall_hOffset[18][3]&&vCount<=wall_vStartPos[18][3]+v+wall_vOffset[18][3]+wall_objHeight[18][3]&&vCount>=wall_vStartPos[18][3]+v+wall_vOffset[18][3]) Sel<=wall_color[18][3]; 
    else if(wall_visible[19][3]==1&&hCount<=wall_hStartPos[19][3]+h+wall_hOffset[19][3]+wall_objWidth[19][3]&&hCount>=wall_hStartPos[19][3]+h+wall_hOffset[19][3]&&vCount<=wall_vStartPos[19][3]+v+wall_vOffset[19][3]+wall_objHeight[19][3]&&vCount>=wall_vStartPos[19][3]+v+wall_vOffset[19][3]) Sel<=wall_color[19][3]; 
    else if(wall_visible[20][3]==1&&hCount<=wall_hStartPos[20][3]+h+wall_hOffset[20][3]+wall_objWidth[20][3]&&hCount>=wall_hStartPos[20][3]+h+wall_hOffset[20][3]&&vCount<=wall_vStartPos[20][3]+v+wall_vOffset[20][3]+wall_objHeight[20][3]&&vCount>=wall_vStartPos[20][3]+v+wall_vOffset[20][3]) Sel<=wall_color[20][3]; 
    else if(wall_visible[21][3]==1&&hCount<=wall_hStartPos[21][3]+h+wall_hOffset[21][3]+wall_objWidth[21][3]&&hCount>=wall_hStartPos[21][3]+h+wall_hOffset[21][3]&&vCount<=wall_vStartPos[21][3]+v+wall_vOffset[21][3]+wall_objHeight[21][3]&&vCount>=wall_vStartPos[21][3]+v+wall_vOffset[21][3]) Sel<=wall_color[21][3]; 
    else if(wall_visible[22][3]==1&&hCount<=wall_hStartPos[22][3]+h+wall_hOffset[22][3]+wall_objWidth[22][3]&&hCount>=wall_hStartPos[22][3]+h+wall_hOffset[22][3]&&vCount<=wall_vStartPos[22][3]+v+wall_vOffset[22][3]+wall_objHeight[22][3]&&vCount>=wall_vStartPos[22][3]+v+wall_vOffset[22][3]) Sel<=wall_color[22][3]; 
    else if(wall_visible[23][3]==1&&hCount<=wall_hStartPos[23][3]+h+wall_hOffset[23][3]+wall_objWidth[23][3]&&hCount>=wall_hStartPos[23][3]+h+wall_hOffset[23][3]&&vCount<=wall_vStartPos[23][3]+v+wall_vOffset[23][3]+wall_objHeight[23][3]&&vCount>=wall_vStartPos[23][3]+v+wall_vOffset[23][3]) Sel<=wall_color[23][3]; 
        
// WALL 4
    else if(wall_visible[0 ][4]==1&&hCount<=wall_hStartPos[0 ][4]+h+wall_hOffset[0 ][4]+wall_objWidth[0 ][4]&&hCount>=wall_hStartPos[0 ][4]+h+wall_hOffset[0 ][4]&&vCount<=wall_vStartPos[0 ][4]+v+wall_vOffset[0 ][4]+wall_objHeight[0 ][4]&&vCount>=wall_vStartPos[0 ][4]+v+wall_vOffset[0 ][4]) Sel<=wall_color[0 ][4]; 
    else if(wall_visible[1 ][4]==1&&hCount<=wall_hStartPos[1 ][4]+h+wall_hOffset[1 ][4]+wall_objWidth[1 ][4]&&hCount>=wall_hStartPos[1 ][4]+h+wall_hOffset[1 ][4]&&vCount<=wall_vStartPos[1 ][4]+v+wall_vOffset[1 ][4]+wall_objHeight[1 ][4]&&vCount>=wall_vStartPos[1 ][4]+v+wall_vOffset[1 ][4]) Sel<=wall_color[1 ][4]; 
    else if(wall_visible[2 ][4]==1&&hCount<=wall_hStartPos[2 ][4]+h+wall_hOffset[2 ][4]+wall_objWidth[2 ][4]&&hCount>=wall_hStartPos[2 ][4]+h+wall_hOffset[2 ][4]&&vCount<=wall_vStartPos[2 ][4]+v+wall_vOffset[2 ][4]+wall_objHeight[2 ][4]&&vCount>=wall_vStartPos[2 ][4]+v+wall_vOffset[2 ][4]) Sel<=wall_color[2 ][4]; 
    else if(wall_visible[3 ][4]==1&&hCount<=wall_hStartPos[3 ][4]+h+wall_hOffset[3 ][4]+wall_objWidth[3 ][4]&&hCount>=wall_hStartPos[3 ][4]+h+wall_hOffset[3 ][4]&&vCount<=wall_vStartPos[3 ][4]+v+wall_vOffset[3 ][4]+wall_objHeight[3 ][4]&&vCount>=wall_vStartPos[3 ][4]+v+wall_vOffset[3 ][4]) Sel<=wall_color[3 ][4]; 
    else if(wall_visible[4 ][4]==1&&hCount<=wall_hStartPos[4 ][4]+h+wall_hOffset[4 ][4]+wall_objWidth[4 ][4]&&hCount>=wall_hStartPos[4 ][4]+h+wall_hOffset[4 ][4]&&vCount<=wall_vStartPos[4 ][4]+v+wall_vOffset[4 ][4]+wall_objHeight[4 ][4]&&vCount>=wall_vStartPos[4 ][4]+v+wall_vOffset[4 ][4]) Sel<=wall_color[4 ][4]; 
    else if(wall_visible[5 ][4]==1&&hCount<=wall_hStartPos[5 ][4]+h+wall_hOffset[5 ][4]+wall_objWidth[5 ][4]&&hCount>=wall_hStartPos[5 ][4]+h+wall_hOffset[5 ][4]&&vCount<=wall_vStartPos[5 ][4]+v+wall_vOffset[5 ][4]+wall_objHeight[5 ][4]&&vCount>=wall_vStartPos[5 ][4]+v+wall_vOffset[5 ][4]) Sel<=wall_color[5 ][4]; 
    else if(wall_visible[6 ][4]==1&&hCount<=wall_hStartPos[6 ][4]+h+wall_hOffset[6 ][4]+wall_objWidth[6 ][4]&&hCount>=wall_hStartPos[6 ][4]+h+wall_hOffset[6 ][4]&&vCount<=wall_vStartPos[6 ][4]+v+wall_vOffset[6 ][4]+wall_objHeight[6 ][4]&&vCount>=wall_vStartPos[6 ][4]+v+wall_vOffset[6 ][4]) Sel<=wall_color[6 ][4]; 
    else if(wall_visible[7 ][4]==1&&hCount<=wall_hStartPos[7 ][4]+h+wall_hOffset[7 ][4]+wall_objWidth[7 ][4]&&hCount>=wall_hStartPos[7 ][4]+h+wall_hOffset[7 ][4]&&vCount<=wall_vStartPos[7 ][4]+v+wall_vOffset[7 ][4]+wall_objHeight[7 ][4]&&vCount>=wall_vStartPos[7 ][4]+v+wall_vOffset[7 ][4]) Sel<=wall_color[7 ][4]; 
    else if(wall_visible[8 ][4]==1&&hCount<=wall_hStartPos[8 ][4]+h+wall_hOffset[8 ][4]+wall_objWidth[8 ][4]&&hCount>=wall_hStartPos[8 ][4]+h+wall_hOffset[8 ][4]&&vCount<=wall_vStartPos[8 ][4]+v+wall_vOffset[8 ][4]+wall_objHeight[8 ][4]&&vCount>=wall_vStartPos[8 ][4]+v+wall_vOffset[8 ][4]) Sel<=wall_color[8 ][4]; 
    else if(wall_visible[9 ][4]==1&&hCount<=wall_hStartPos[9 ][4]+h+wall_hOffset[9 ][4]+wall_objWidth[9 ][4]&&hCount>=wall_hStartPos[9 ][4]+h+wall_hOffset[9 ][4]&&vCount<=wall_vStartPos[9 ][4]+v+wall_vOffset[9 ][4]+wall_objHeight[9 ][4]&&vCount>=wall_vStartPos[9 ][4]+v+wall_vOffset[9 ][4]) Sel<=wall_color[9 ][4]; 
    else if(wall_visible[10][4]==1&&hCount<=wall_hStartPos[10][4]+h+wall_hOffset[10][4]+wall_objWidth[10][4]&&hCount>=wall_hStartPos[10][4]+h+wall_hOffset[10][4]&&vCount<=wall_vStartPos[10][4]+v+wall_vOffset[10][4]+wall_objHeight[10][4]&&vCount>=wall_vStartPos[10][4]+v+wall_vOffset[10][4]) Sel<=wall_color[10][4]; 
    else if(wall_visible[11][4]==1&&hCount<=wall_hStartPos[11][4]+h+wall_hOffset[11][4]+wall_objWidth[11][4]&&hCount>=wall_hStartPos[11][4]+h+wall_hOffset[11][4]&&vCount<=wall_vStartPos[11][4]+v+wall_vOffset[11][4]+wall_objHeight[11][4]&&vCount>=wall_vStartPos[11][4]+v+wall_vOffset[11][4]) Sel<=wall_color[11][4]; 
    else if(wall_visible[12][4]==1&&hCount<=wall_hStartPos[12][4]+h+wall_hOffset[12][4]+wall_objWidth[12][4]&&hCount>=wall_hStartPos[12][4]+h+wall_hOffset[12][4]&&vCount<=wall_vStartPos[12][4]+v+wall_vOffset[12][4]+wall_objHeight[12][4]&&vCount>=wall_vStartPos[12][4]+v+wall_vOffset[12][4]) Sel<=wall_color[12][4]; 
    else if(wall_visible[13][4]==1&&hCount<=wall_hStartPos[13][4]+h+wall_hOffset[13][4]+wall_objWidth[13][4]&&hCount>=wall_hStartPos[13][4]+h+wall_hOffset[13][4]&&vCount<=wall_vStartPos[13][4]+v+wall_vOffset[13][4]+wall_objHeight[13][4]&&vCount>=wall_vStartPos[13][4]+v+wall_vOffset[13][4]) Sel<=wall_color[13][4]; 
    else if(wall_visible[14][4]==1&&hCount<=wall_hStartPos[14][4]+h+wall_hOffset[14][4]+wall_objWidth[14][4]&&hCount>=wall_hStartPos[14][4]+h+wall_hOffset[14][4]&&vCount<=wall_vStartPos[14][4]+v+wall_vOffset[14][4]+wall_objHeight[14][4]&&vCount>=wall_vStartPos[14][4]+v+wall_vOffset[14][4]) Sel<=wall_color[14][4]; 
    else if(wall_visible[15][4]==1&&hCount<=wall_hStartPos[15][4]+h+wall_hOffset[15][4]+wall_objWidth[15][4]&&hCount>=wall_hStartPos[15][4]+h+wall_hOffset[15][4]&&vCount<=wall_vStartPos[15][4]+v+wall_vOffset[15][4]+wall_objHeight[15][4]&&vCount>=wall_vStartPos[15][4]+v+wall_vOffset[15][4]) Sel<=wall_color[15][4]; 
    else if(wall_visible[16][4]==1&&hCount<=wall_hStartPos[16][4]+h+wall_hOffset[16][4]+wall_objWidth[16][4]&&hCount>=wall_hStartPos[16][4]+h+wall_hOffset[16][4]&&vCount<=wall_vStartPos[16][4]+v+wall_vOffset[16][4]+wall_objHeight[16][4]&&vCount>=wall_vStartPos[16][4]+v+wall_vOffset[16][4]) Sel<=wall_color[16][4]; 
    else if(wall_visible[17][4]==1&&hCount<=wall_hStartPos[17][4]+h+wall_hOffset[17][4]+wall_objWidth[17][4]&&hCount>=wall_hStartPos[17][4]+h+wall_hOffset[17][4]&&vCount<=wall_vStartPos[17][4]+v+wall_vOffset[17][4]+wall_objHeight[17][4]&&vCount>=wall_vStartPos[17][4]+v+wall_vOffset[17][4]) Sel<=wall_color[17][4]; 
    else if(wall_visible[18][4]==1&&hCount<=wall_hStartPos[18][4]+h+wall_hOffset[18][4]+wall_objWidth[18][4]&&hCount>=wall_hStartPos[18][4]+h+wall_hOffset[18][4]&&vCount<=wall_vStartPos[18][4]+v+wall_vOffset[18][4]+wall_objHeight[18][4]&&vCount>=wall_vStartPos[18][4]+v+wall_vOffset[18][4]) Sel<=wall_color[18][4]; 
    else if(wall_visible[19][4]==1&&hCount<=wall_hStartPos[19][4]+h+wall_hOffset[19][4]+wall_objWidth[19][4]&&hCount>=wall_hStartPos[19][4]+h+wall_hOffset[19][4]&&vCount<=wall_vStartPos[19][4]+v+wall_vOffset[19][4]+wall_objHeight[19][4]&&vCount>=wall_vStartPos[19][4]+v+wall_vOffset[19][4]) Sel<=wall_color[19][4]; 
    else if(wall_visible[20][4]==1&&hCount<=wall_hStartPos[20][4]+h+wall_hOffset[20][4]+wall_objWidth[20][4]&&hCount>=wall_hStartPos[20][4]+h+wall_hOffset[20][4]&&vCount<=wall_vStartPos[20][4]+v+wall_vOffset[20][4]+wall_objHeight[20][4]&&vCount>=wall_vStartPos[20][4]+v+wall_vOffset[20][4]) Sel<=wall_color[20][4]; 
    else if(wall_visible[21][4]==1&&hCount<=wall_hStartPos[21][4]+h+wall_hOffset[21][4]+wall_objWidth[21][4]&&hCount>=wall_hStartPos[21][4]+h+wall_hOffset[21][4]&&vCount<=wall_vStartPos[21][4]+v+wall_vOffset[21][4]+wall_objHeight[21][4]&&vCount>=wall_vStartPos[21][4]+v+wall_vOffset[21][4]) Sel<=wall_color[21][4]; 
    else if(wall_visible[22][4]==1&&hCount<=wall_hStartPos[22][4]+h+wall_hOffset[22][4]+wall_objWidth[22][4]&&hCount>=wall_hStartPos[22][4]+h+wall_hOffset[22][4]&&vCount<=wall_vStartPos[22][4]+v+wall_vOffset[22][4]+wall_objHeight[22][4]&&vCount>=wall_vStartPos[22][4]+v+wall_vOffset[22][4]) Sel<=wall_color[22][4]; 
    else if(wall_visible[23][4]==1&&hCount<=wall_hStartPos[23][4]+h+wall_hOffset[23][4]+wall_objWidth[23][4]&&hCount>=wall_hStartPos[23][4]+h+wall_hOffset[23][4]&&vCount<=wall_vStartPos[23][4]+v+wall_vOffset[23][4]+wall_objHeight[23][4]&&vCount>=wall_vStartPos[23][4]+v+wall_vOffset[23][4]) Sel<=wall_color[23][4]; 
// WALL 5                
    else if(wall_visible[0 ][5]==1&&hCount<=wall_hStartPos[0 ][5]+h+wall_hOffset[0 ][5]+wall_objWidth[0 ][5]&&hCount>=wall_hStartPos[0 ][5]+h+wall_hOffset[0 ][5]&&vCount<=wall_vStartPos[0 ][5]+v+wall_vOffset[0 ][5]+wall_objHeight[0 ][5]&&vCount>=wall_vStartPos[0 ][5]+v+wall_vOffset[0 ][5]) Sel<=wall_color[0 ][5]; 
    else if(wall_visible[1 ][5]==1&&hCount<=wall_hStartPos[1 ][5]+h+wall_hOffset[1 ][5]+wall_objWidth[1 ][5]&&hCount>=wall_hStartPos[1 ][5]+h+wall_hOffset[1 ][5]&&vCount<=wall_vStartPos[1 ][5]+v+wall_vOffset[1 ][5]+wall_objHeight[1 ][5]&&vCount>=wall_vStartPos[1 ][5]+v+wall_vOffset[1 ][5]) Sel<=wall_color[1 ][5]; 
    else if(wall_visible[2 ][5]==1&&hCount<=wall_hStartPos[2 ][5]+h+wall_hOffset[2 ][5]+wall_objWidth[2 ][5]&&hCount>=wall_hStartPos[2 ][5]+h+wall_hOffset[2 ][5]&&vCount<=wall_vStartPos[2 ][5]+v+wall_vOffset[2 ][5]+wall_objHeight[2 ][5]&&vCount>=wall_vStartPos[2 ][5]+v+wall_vOffset[2 ][5]) Sel<=wall_color[2 ][5]; 
    else if(wall_visible[3 ][5]==1&&hCount<=wall_hStartPos[3 ][5]+h+wall_hOffset[3 ][5]+wall_objWidth[3 ][5]&&hCount>=wall_hStartPos[3 ][5]+h+wall_hOffset[3 ][5]&&vCount<=wall_vStartPos[3 ][5]+v+wall_vOffset[3 ][5]+wall_objHeight[3 ][5]&&vCount>=wall_vStartPos[3 ][5]+v+wall_vOffset[3 ][5]) Sel<=wall_color[3 ][5]; 
    else if(wall_visible[4 ][5]==1&&hCount<=wall_hStartPos[4 ][5]+h+wall_hOffset[4 ][5]+wall_objWidth[4 ][5]&&hCount>=wall_hStartPos[4 ][5]+h+wall_hOffset[4 ][5]&&vCount<=wall_vStartPos[4 ][5]+v+wall_vOffset[4 ][5]+wall_objHeight[4 ][5]&&vCount>=wall_vStartPos[4 ][5]+v+wall_vOffset[4 ][5]) Sel<=wall_color[4 ][5]; 
    else if(wall_visible[5 ][5]==1&&hCount<=wall_hStartPos[5 ][5]+h+wall_hOffset[5 ][5]+wall_objWidth[5 ][5]&&hCount>=wall_hStartPos[5 ][5]+h+wall_hOffset[5 ][5]&&vCount<=wall_vStartPos[5 ][5]+v+wall_vOffset[5 ][5]+wall_objHeight[5 ][5]&&vCount>=wall_vStartPos[5 ][5]+v+wall_vOffset[5 ][5]) Sel<=wall_color[5 ][5]; 
    else if(wall_visible[6 ][5]==1&&hCount<=wall_hStartPos[6 ][5]+h+wall_hOffset[6 ][5]+wall_objWidth[6 ][5]&&hCount>=wall_hStartPos[6 ][5]+h+wall_hOffset[6 ][5]&&vCount<=wall_vStartPos[6 ][5]+v+wall_vOffset[6 ][5]+wall_objHeight[6 ][5]&&vCount>=wall_vStartPos[6 ][5]+v+wall_vOffset[6 ][5]) Sel<=wall_color[6 ][5]; 
    else if(wall_visible[7 ][5]==1&&hCount<=wall_hStartPos[7 ][5]+h+wall_hOffset[7 ][5]+wall_objWidth[7 ][5]&&hCount>=wall_hStartPos[7 ][5]+h+wall_hOffset[7 ][5]&&vCount<=wall_vStartPos[7 ][5]+v+wall_vOffset[7 ][5]+wall_objHeight[7 ][5]&&vCount>=wall_vStartPos[7 ][5]+v+wall_vOffset[7 ][5]) Sel<=wall_color[7 ][5]; 
    else if(wall_visible[8 ][5]==1&&hCount<=wall_hStartPos[8 ][5]+h+wall_hOffset[8 ][5]+wall_objWidth[8 ][5]&&hCount>=wall_hStartPos[8 ][5]+h+wall_hOffset[8 ][5]&&vCount<=wall_vStartPos[8 ][5]+v+wall_vOffset[8 ][5]+wall_objHeight[8 ][5]&&vCount>=wall_vStartPos[8 ][5]+v+wall_vOffset[8 ][5]) Sel<=wall_color[8 ][5]; 
    else if(wall_visible[9 ][5]==1&&hCount<=wall_hStartPos[9 ][5]+h+wall_hOffset[9 ][5]+wall_objWidth[9 ][5]&&hCount>=wall_hStartPos[9 ][5]+h+wall_hOffset[9 ][5]&&vCount<=wall_vStartPos[9 ][5]+v+wall_vOffset[9 ][5]+wall_objHeight[9 ][5]&&vCount>=wall_vStartPos[9 ][5]+v+wall_vOffset[9 ][5]) Sel<=wall_color[9 ][5]; 
    else if(wall_visible[10][5]==1&&hCount<=wall_hStartPos[10][5]+h+wall_hOffset[10][5]+wall_objWidth[10][5]&&hCount>=wall_hStartPos[10][5]+h+wall_hOffset[10][5]&&vCount<=wall_vStartPos[10][5]+v+wall_vOffset[10][5]+wall_objHeight[10][5]&&vCount>=wall_vStartPos[10][5]+v+wall_vOffset[10][5]) Sel<=wall_color[10][5]; 
    else if(wall_visible[11][5]==1&&hCount<=wall_hStartPos[11][5]+h+wall_hOffset[11][5]+wall_objWidth[11][5]&&hCount>=wall_hStartPos[11][5]+h+wall_hOffset[11][5]&&vCount<=wall_vStartPos[11][5]+v+wall_vOffset[11][5]+wall_objHeight[11][5]&&vCount>=wall_vStartPos[11][5]+v+wall_vOffset[11][5]) Sel<=wall_color[11][5]; 
    else if(wall_visible[12][5]==1&&hCount<=wall_hStartPos[12][5]+h+wall_hOffset[12][5]+wall_objWidth[12][5]&&hCount>=wall_hStartPos[12][5]+h+wall_hOffset[12][5]&&vCount<=wall_vStartPos[12][5]+v+wall_vOffset[12][5]+wall_objHeight[12][5]&&vCount>=wall_vStartPos[12][5]+v+wall_vOffset[12][5]) Sel<=wall_color[12][5]; 
    else if(wall_visible[13][5]==1&&hCount<=wall_hStartPos[13][5]+h+wall_hOffset[13][5]+wall_objWidth[13][5]&&hCount>=wall_hStartPos[13][5]+h+wall_hOffset[13][5]&&vCount<=wall_vStartPos[13][5]+v+wall_vOffset[13][5]+wall_objHeight[13][5]&&vCount>=wall_vStartPos[13][5]+v+wall_vOffset[13][5]) Sel<=wall_color[13][5]; 
    else if(wall_visible[14][5]==1&&hCount<=wall_hStartPos[14][5]+h+wall_hOffset[14][5]+wall_objWidth[14][5]&&hCount>=wall_hStartPos[14][5]+h+wall_hOffset[14][5]&&vCount<=wall_vStartPos[14][5]+v+wall_vOffset[14][5]+wall_objHeight[14][5]&&vCount>=wall_vStartPos[14][5]+v+wall_vOffset[14][5]) Sel<=wall_color[14][5]; 
    else if(wall_visible[15][5]==1&&hCount<=wall_hStartPos[15][5]+h+wall_hOffset[15][5]+wall_objWidth[15][5]&&hCount>=wall_hStartPos[15][5]+h+wall_hOffset[15][5]&&vCount<=wall_vStartPos[15][5]+v+wall_vOffset[15][5]+wall_objHeight[15][5]&&vCount>=wall_vStartPos[15][5]+v+wall_vOffset[15][5]) Sel<=wall_color[15][5]; 
    else if(wall_visible[16][5]==1&&hCount<=wall_hStartPos[16][5]+h+wall_hOffset[16][5]+wall_objWidth[16][5]&&hCount>=wall_hStartPos[16][5]+h+wall_hOffset[16][5]&&vCount<=wall_vStartPos[16][5]+v+wall_vOffset[16][5]+wall_objHeight[16][5]&&vCount>=wall_vStartPos[16][5]+v+wall_vOffset[16][5]) Sel<=wall_color[16][5]; 
    else if(wall_visible[17][5]==1&&hCount<=wall_hStartPos[17][5]+h+wall_hOffset[17][5]+wall_objWidth[17][5]&&hCount>=wall_hStartPos[17][5]+h+wall_hOffset[17][5]&&vCount<=wall_vStartPos[17][5]+v+wall_vOffset[17][5]+wall_objHeight[17][5]&&vCount>=wall_vStartPos[17][5]+v+wall_vOffset[17][5]) Sel<=wall_color[17][5]; 
    else if(wall_visible[18][5]==1&&hCount<=wall_hStartPos[18][5]+h+wall_hOffset[18][5]+wall_objWidth[18][5]&&hCount>=wall_hStartPos[18][5]+h+wall_hOffset[18][5]&&vCount<=wall_vStartPos[18][5]+v+wall_vOffset[18][5]+wall_objHeight[18][5]&&vCount>=wall_vStartPos[18][5]+v+wall_vOffset[18][5]) Sel<=wall_color[18][5]; 
    else if(wall_visible[19][5]==1&&hCount<=wall_hStartPos[19][5]+h+wall_hOffset[19][5]+wall_objWidth[19][5]&&hCount>=wall_hStartPos[19][5]+h+wall_hOffset[19][5]&&vCount<=wall_vStartPos[19][5]+v+wall_vOffset[19][5]+wall_objHeight[19][5]&&vCount>=wall_vStartPos[19][5]+v+wall_vOffset[19][5]) Sel<=wall_color[19][5]; 
    else if(wall_visible[20][5]==1&&hCount<=wall_hStartPos[20][5]+h+wall_hOffset[20][5]+wall_objWidth[20][5]&&hCount>=wall_hStartPos[20][5]+h+wall_hOffset[20][5]&&vCount<=wall_vStartPos[20][5]+v+wall_vOffset[20][5]+wall_objHeight[20][5]&&vCount>=wall_vStartPos[20][5]+v+wall_vOffset[20][5]) Sel<=wall_color[20][5]; 
    else if(wall_visible[21][5]==1&&hCount<=wall_hStartPos[21][5]+h+wall_hOffset[21][5]+wall_objWidth[21][5]&&hCount>=wall_hStartPos[21][5]+h+wall_hOffset[21][5]&&vCount<=wall_vStartPos[21][5]+v+wall_vOffset[21][5]+wall_objHeight[21][5]&&vCount>=wall_vStartPos[21][5]+v+wall_vOffset[21][5]) Sel<=wall_color[21][5]; 
    else if(wall_visible[22][5]==1&&hCount<=wall_hStartPos[22][5]+h+wall_hOffset[22][5]+wall_objWidth[22][5]&&hCount>=wall_hStartPos[22][5]+h+wall_hOffset[22][5]&&vCount<=wall_vStartPos[22][5]+v+wall_vOffset[22][5]+wall_objHeight[22][5]&&vCount>=wall_vStartPos[22][5]+v+wall_vOffset[22][5]) Sel<=wall_color[22][5]; 
    else if(wall_visible[23][5]==1&&hCount<=wall_hStartPos[23][5]+h+wall_hOffset[23][5]+wall_objWidth[23][5]&&hCount>=wall_hStartPos[23][5]+h+wall_hOffset[23][5]&&vCount<=wall_vStartPos[23][5]+v+wall_vOffset[23][5]+wall_objHeight[23][5]&&vCount>=wall_vStartPos[23][5]+v+wall_vOffset[23][5]) Sel<=wall_color[23][5]; 
//======================================================================================                    
//SCREENS
//======================================================================================= 

    //SCREEN 0
    else if(screen_visible[0 ][0]==1&&hCount<=screen_hStartPos[0 ][0]+h+screen_hOffset[0 ][0]+screen_objWidth[0 ][0]&&hCount>=screen_hStartPos[0 ][0]+h+screen_hOffset[0 ][0]&&vCount<=screen_vStartPos[0 ][0]+v+screen_vOffset[0 ][0]+screen_objHeight[0 ][0]&&vCount>=screen_vStartPos[0 ][0]+v+screen_vOffset[0 ][0]) Sel<=screen_color[0 ][0]; 
    else if(screen_visible[1 ][0]==1&&hCount<=screen_hStartPos[1 ][0]+h+screen_hOffset[1 ][0]+screen_objWidth[1 ][0]&&hCount>=screen_hStartPos[1 ][0]+h+screen_hOffset[1 ][0]&&vCount<=screen_vStartPos[1 ][0]+v+screen_vOffset[1 ][0]+screen_objHeight[1 ][0]&&vCount>=screen_vStartPos[1 ][0]+v+screen_vOffset[1 ][0]) Sel<=screen_color[1 ][0]; 
    else if(screen_visible[2 ][0]==1&&hCount<=screen_hStartPos[2 ][0]+h+screen_hOffset[2 ][0]+screen_objWidth[2 ][0]&&hCount>=screen_hStartPos[2 ][0]+h+screen_hOffset[2 ][0]&&vCount<=screen_vStartPos[2 ][0]+v+screen_vOffset[2 ][0]+screen_objHeight[2 ][0]&&vCount>=screen_vStartPos[2 ][0]+v+screen_vOffset[2 ][0]) Sel<=screen_color[2 ][0]; 
    else if(screen_visible[3 ][0]==1&&hCount<=screen_hStartPos[3 ][0]+h+screen_hOffset[3 ][0]+screen_objWidth[3 ][0]&&hCount>=screen_hStartPos[3 ][0]+h+screen_hOffset[3 ][0]&&vCount<=screen_vStartPos[3 ][0]+v+screen_vOffset[3 ][0]+screen_objHeight[3 ][0]&&vCount>=screen_vStartPos[3 ][0]+v+screen_vOffset[3 ][0]) Sel<=screen_color[3 ][0]; 
    else if(screen_visible[4 ][0]==1&&hCount<=screen_hStartPos[4 ][0]+h+screen_hOffset[4 ][0]+screen_objWidth[4 ][0]&&hCount>=screen_hStartPos[4 ][0]+h+screen_hOffset[4 ][0]&&vCount<=screen_vStartPos[4 ][0]+v+screen_vOffset[4 ][0]+screen_objHeight[4 ][0]&&vCount>=screen_vStartPos[4 ][0]+v+screen_vOffset[4 ][0]) Sel<=screen_color[4 ][0]; 
    else if(screen_visible[5 ][0]==1&&hCount<=screen_hStartPos[5 ][0]+h+screen_hOffset[5 ][0]+screen_objWidth[5 ][0]&&hCount>=screen_hStartPos[5 ][0]+h+screen_hOffset[5 ][0]&&vCount<=screen_vStartPos[5 ][0]+v+screen_vOffset[5 ][0]+screen_objHeight[5 ][0]&&vCount>=screen_vStartPos[5 ][0]+v+screen_vOffset[5 ][0]) Sel<=screen_color[5 ][0]; 
    else if(screen_visible[6 ][0]==1&&hCount<=screen_hStartPos[6 ][0]+h+screen_hOffset[6 ][0]+screen_objWidth[6 ][0]&&hCount>=screen_hStartPos[6 ][0]+h+screen_hOffset[6 ][0]&&vCount<=screen_vStartPos[6 ][0]+v+screen_vOffset[6 ][0]+screen_objHeight[6 ][0]&&vCount>=screen_vStartPos[6 ][0]+v+screen_vOffset[6 ][0]) Sel<=screen_color[6 ][0]; 
    else if(screen_visible[7 ][0]==1&&hCount<=screen_hStartPos[7 ][0]+h+screen_hOffset[7 ][0]+screen_objWidth[7 ][0]&&hCount>=screen_hStartPos[7 ][0]+h+screen_hOffset[7 ][0]&&vCount<=screen_vStartPos[7 ][0]+v+screen_vOffset[7 ][0]+screen_objHeight[7 ][0]&&vCount>=screen_vStartPos[7 ][0]+v+screen_vOffset[7 ][0]) Sel<=screen_color[7 ][0]; 
    else if(screen_visible[8 ][0]==1&&hCount<=screen_hStartPos[8 ][0]+h+screen_hOffset[8 ][0]+screen_objWidth[8 ][0]&&hCount>=screen_hStartPos[8 ][0]+h+screen_hOffset[8 ][0]&&vCount<=screen_vStartPos[8 ][0]+v+screen_vOffset[8 ][0]+screen_objHeight[8 ][0]&&vCount>=screen_vStartPos[8 ][0]+v+screen_vOffset[8 ][0]) Sel<=screen_color[8 ][0]; 
    else if(screen_visible[9 ][0]==1&&hCount<=screen_hStartPos[9 ][0]+h+screen_hOffset[9 ][0]+screen_objWidth[9 ][0]&&hCount>=screen_hStartPos[9 ][0]+h+screen_hOffset[9 ][0]&&vCount<=screen_vStartPos[9 ][0]+v+screen_vOffset[9 ][0]+screen_objHeight[9 ][0]&&vCount>=screen_vStartPos[9 ][0]+v+screen_vOffset[9 ][0]) Sel<=screen_color[9 ][0]; 
    else if(screen_visible[10][0]==1&&hCount<=screen_hStartPos[10][0]+h+screen_hOffset[10][0]+screen_objWidth[10][0]&&hCount>=screen_hStartPos[10][0]+h+screen_hOffset[10][0]&&vCount<=screen_vStartPos[10][0]+v+screen_vOffset[10][0]+screen_objHeight[10][0]&&vCount>=screen_vStartPos[10][0]+v+screen_vOffset[10][0]) Sel<=screen_color[10][0]; 
    else if(screen_visible[11][0]==1&&hCount<=screen_hStartPos[11][0]+h+screen_hOffset[11][0]+screen_objWidth[11][0]&&hCount>=screen_hStartPos[11][0]+h+screen_hOffset[11][0]&&vCount<=screen_vStartPos[11][0]+v+screen_vOffset[11][0]+screen_objHeight[11][0]&&vCount>=screen_vStartPos[11][0]+v+screen_vOffset[11][0]) Sel<=screen_color[11][0]; 
    else if(screen_visible[12][0]==1&&hCount<=screen_hStartPos[12][0]+h+screen_hOffset[12][0]+screen_objWidth[12][0]&&hCount>=screen_hStartPos[12][0]+h+screen_hOffset[12][0]&&vCount<=screen_vStartPos[12][0]+v+screen_vOffset[12][0]+screen_objHeight[12][0]&&vCount>=screen_vStartPos[12][0]+v+screen_vOffset[12][0]) Sel<=screen_color[12][0]; 
    else if(screen_visible[13][0]==1&&hCount<=screen_hStartPos[13][0]+h+screen_hOffset[13][0]+screen_objWidth[13][0]&&hCount>=screen_hStartPos[13][0]+h+screen_hOffset[13][0]&&vCount<=screen_vStartPos[13][0]+v+screen_vOffset[13][0]+screen_objHeight[13][0]&&vCount>=screen_vStartPos[13][0]+v+screen_vOffset[13][0]) Sel<=screen_color[13][0]; 
    else if(screen_visible[14][0]==1&&hCount<=screen_hStartPos[14][0]+h+screen_hOffset[14][0]+screen_objWidth[14][0]&&hCount>=screen_hStartPos[14][0]+h+screen_hOffset[14][0]&&vCount<=screen_vStartPos[14][0]+v+screen_vOffset[14][0]+screen_objHeight[14][0]&&vCount>=screen_vStartPos[14][0]+v+screen_vOffset[14][0]) Sel<=screen_color[14][0]; 
    else if(screen_visible[15][0]==1&&hCount<=screen_hStartPos[15][0]+h+screen_hOffset[15][0]+screen_objWidth[15][0]&&hCount>=screen_hStartPos[15][0]+h+screen_hOffset[15][0]&&vCount<=screen_vStartPos[15][0]+v+screen_vOffset[15][0]+screen_objHeight[15][0]&&vCount>=screen_vStartPos[15][0]+v+screen_vOffset[15][0]) Sel<=screen_color[15][0]; 
    else if(screen_visible[16][0]==1&&hCount<=screen_hStartPos[16][0]+h+screen_hOffset[16][0]+screen_objWidth[16][0]&&hCount>=screen_hStartPos[16][0]+h+screen_hOffset[16][0]&&vCount<=screen_vStartPos[16][0]+v+screen_vOffset[16][0]+screen_objHeight[16][0]&&vCount>=screen_vStartPos[16][0]+v+screen_vOffset[16][0]) Sel<=screen_color[16][0]; 
    else if(screen_visible[17][0]==1&&hCount<=screen_hStartPos[17][0]+h+screen_hOffset[17][0]+screen_objWidth[17][0]&&hCount>=screen_hStartPos[17][0]+h+screen_hOffset[17][0]&&vCount<=screen_vStartPos[17][0]+v+screen_vOffset[17][0]+screen_objHeight[17][0]&&vCount>=screen_vStartPos[17][0]+v+screen_vOffset[17][0]) Sel<=screen_color[17][0]; 
    else if(screen_visible[18][0]==1&&hCount<=screen_hStartPos[18][0]+h+screen_hOffset[18][0]+screen_objWidth[18][0]&&hCount>=screen_hStartPos[18][0]+h+screen_hOffset[18][0]&&vCount<=screen_vStartPos[18][0]+v+screen_vOffset[18][0]+screen_objHeight[18][0]&&vCount>=screen_vStartPos[18][0]+v+screen_vOffset[18][0]) Sel<=screen_color[18][0]; 
    else if(screen_visible[19][0]==1&&hCount<=screen_hStartPos[19][0]+h+screen_hOffset[19][0]+screen_objWidth[19][0]&&hCount>=screen_hStartPos[19][0]+h+screen_hOffset[19][0]&&vCount<=screen_vStartPos[19][0]+v+screen_vOffset[19][0]+screen_objHeight[19][0]&&vCount>=screen_vStartPos[19][0]+v+screen_vOffset[19][0]) Sel<=screen_color[19][0]; 
    else if(screen_visible[20][0]==1&&hCount<=screen_hStartPos[20][0]+h+screen_hOffset[20][0]+screen_objWidth[20][0]&&hCount>=screen_hStartPos[20][0]+h+screen_hOffset[20][0]&&vCount<=screen_vStartPos[20][0]+v+screen_vOffset[20][0]+screen_objHeight[20][0]&&vCount>=screen_vStartPos[20][0]+v+screen_vOffset[20][0]) Sel<=screen_color[20][0]; 
    else if(screen_visible[21][0]==1&&hCount<=screen_hStartPos[21][0]+h+screen_hOffset[21][0]+screen_objWidth[21][0]&&hCount>=screen_hStartPos[21][0]+h+screen_hOffset[21][0]&&vCount<=screen_vStartPos[21][0]+v+screen_vOffset[21][0]+screen_objHeight[21][0]&&vCount>=screen_vStartPos[21][0]+v+screen_vOffset[21][0]) Sel<=screen_color[21][0]; 
    else if(screen_visible[22][0]==1&&hCount<=screen_hStartPos[22][0]+h+screen_hOffset[22][0]+screen_objWidth[22][0]&&hCount>=screen_hStartPos[22][0]+h+screen_hOffset[22][0]&&vCount<=screen_vStartPos[22][0]+v+screen_vOffset[22][0]+screen_objHeight[22][0]&&vCount>=screen_vStartPos[22][0]+v+screen_vOffset[22][0]) Sel<=screen_color[22][0]; 
    else if(screen_visible[23][0]==1&&hCount<=screen_hStartPos[23][0]+h+screen_hOffset[23][0]+screen_objWidth[23][0]&&hCount>=screen_hStartPos[23][0]+h+screen_hOffset[23][0]&&vCount<=screen_vStartPos[23][0]+v+screen_vOffset[23][0]+screen_objHeight[23][0]&&vCount>=screen_vStartPos[23][0]+v+screen_vOffset[23][0]) Sel<=screen_color[23][0]; 





//SCREEN1
    else if(screen_visible[0 ][1]==1&&hCount<=screen_hStartPos[0 ][1]+h+screen_hOffset[0 ][1]+screen_objWidth[0 ][1]&&hCount>=screen_hStartPos[0 ][1]+h+screen_hOffset[0 ][1]&&vCount<=screen_vStartPos[0 ][1]+v+screen_vOffset[0 ][1]+screen_objHeight[0 ][1]&&vCount>=screen_vStartPos[0 ][1]+v+screen_vOffset[0 ][1]) Sel<=screen_color[0 ][1]; 
    else if(screen_visible[1 ][1]==1&&hCount<=screen_hStartPos[1 ][1]+h+screen_hOffset[1 ][1]+screen_objWidth[1 ][1]&&hCount>=screen_hStartPos[1 ][1]+h+screen_hOffset[1 ][1]&&vCount<=screen_vStartPos[1 ][1]+v+screen_vOffset[1 ][1]+screen_objHeight[1 ][1]&&vCount>=screen_vStartPos[1 ][1]+v+screen_vOffset[1 ][1]) Sel<=screen_color[1 ][1]; 
    else if(screen_visible[2 ][1]==1&&hCount<=screen_hStartPos[2 ][1]+h+screen_hOffset[2 ][1]+screen_objWidth[2 ][1]&&hCount>=screen_hStartPos[2 ][1]+h+screen_hOffset[2 ][1]&&vCount<=screen_vStartPos[2 ][1]+v+screen_vOffset[2 ][1]+screen_objHeight[2 ][1]&&vCount>=screen_vStartPos[2 ][1]+v+screen_vOffset[2 ][1]) Sel<=screen_color[2 ][1]; 
    else if(screen_visible[3 ][1]==1&&hCount<=screen_hStartPos[3 ][1]+h+screen_hOffset[3 ][1]+screen_objWidth[3 ][1]&&hCount>=screen_hStartPos[3 ][1]+h+screen_hOffset[3 ][1]&&vCount<=screen_vStartPos[3 ][1]+v+screen_vOffset[3 ][1]+screen_objHeight[3 ][1]&&vCount>=screen_vStartPos[3 ][1]+v+screen_vOffset[3 ][1]) Sel<=screen_color[3 ][1]; 
    else if(screen_visible[4 ][1]==1&&hCount<=screen_hStartPos[4 ][1]+h+screen_hOffset[4 ][1]+screen_objWidth[4 ][1]&&hCount>=screen_hStartPos[4 ][1]+h+screen_hOffset[4 ][1]&&vCount<=screen_vStartPos[4 ][1]+v+screen_vOffset[4 ][1]+screen_objHeight[4 ][1]&&vCount>=screen_vStartPos[4 ][1]+v+screen_vOffset[4 ][1]) Sel<=screen_color[4 ][1]; 
    else if(screen_visible[5 ][1]==1&&hCount<=screen_hStartPos[5 ][1]+h+screen_hOffset[5 ][1]+screen_objWidth[5 ][1]&&hCount>=screen_hStartPos[5 ][1]+h+screen_hOffset[5 ][1]&&vCount<=screen_vStartPos[5 ][1]+v+screen_vOffset[5 ][1]+screen_objHeight[5 ][1]&&vCount>=screen_vStartPos[5 ][1]+v+screen_vOffset[5 ][1]) Sel<=screen_color[5 ][1]; 
    else if(screen_visible[6 ][1]==1&&hCount<=screen_hStartPos[6 ][1]+h+screen_hOffset[6 ][1]+screen_objWidth[6 ][1]&&hCount>=screen_hStartPos[6 ][1]+h+screen_hOffset[6 ][1]&&vCount<=screen_vStartPos[6 ][1]+v+screen_vOffset[6 ][1]+screen_objHeight[6 ][1]&&vCount>=screen_vStartPos[6 ][1]+v+screen_vOffset[6 ][1]) Sel<=screen_color[6 ][1]; 
    else if(screen_visible[7 ][1]==1&&hCount<=screen_hStartPos[7 ][1]+h+screen_hOffset[7 ][1]+screen_objWidth[7 ][1]&&hCount>=screen_hStartPos[7 ][1]+h+screen_hOffset[7 ][1]&&vCount<=screen_vStartPos[7 ][1]+v+screen_vOffset[7 ][1]+screen_objHeight[7 ][1]&&vCount>=screen_vStartPos[7 ][1]+v+screen_vOffset[7 ][1]) Sel<=screen_color[7 ][1]; 
    else if(screen_visible[8 ][1]==1&&hCount<=screen_hStartPos[8 ][1]+h+screen_hOffset[8 ][1]+screen_objWidth[8 ][1]&&hCount>=screen_hStartPos[8 ][1]+h+screen_hOffset[8 ][1]&&vCount<=screen_vStartPos[8 ][1]+v+screen_vOffset[8 ][1]+screen_objHeight[8 ][1]&&vCount>=screen_vStartPos[8 ][1]+v+screen_vOffset[8 ][1]) Sel<=screen_color[8 ][1]; 
    else if(screen_visible[9 ][1]==1&&hCount<=screen_hStartPos[9 ][1]+h+screen_hOffset[9 ][1]+screen_objWidth[9 ][1]&&hCount>=screen_hStartPos[9 ][1]+h+screen_hOffset[9 ][1]&&vCount<=screen_vStartPos[9 ][1]+v+screen_vOffset[9 ][1]+screen_objHeight[9 ][1]&&vCount>=screen_vStartPos[9 ][1]+v+screen_vOffset[9 ][1]) Sel<=screen_color[9 ][1]; 
    else if(screen_visible[10][1]==1&&hCount<=screen_hStartPos[10][1]+h+screen_hOffset[10][1]+screen_objWidth[10][1]&&hCount>=screen_hStartPos[10][1]+h+screen_hOffset[10][1]&&vCount<=screen_vStartPos[10][1]+v+screen_vOffset[10][1]+screen_objHeight[10][1]&&vCount>=screen_vStartPos[10][1]+v+screen_vOffset[10][1]) Sel<=screen_color[10][1]; 
    else if(screen_visible[11][1]==1&&hCount<=screen_hStartPos[11][1]+h+screen_hOffset[11][1]+screen_objWidth[11][1]&&hCount>=screen_hStartPos[11][1]+h+screen_hOffset[11][1]&&vCount<=screen_vStartPos[11][1]+v+screen_vOffset[11][1]+screen_objHeight[11][1]&&vCount>=screen_vStartPos[11][1]+v+screen_vOffset[11][1]) Sel<=screen_color[11][1]; 
    else if(screen_visible[12][1]==1&&hCount<=screen_hStartPos[12][1]+h+screen_hOffset[12][1]+screen_objWidth[12][1]&&hCount>=screen_hStartPos[12][1]+h+screen_hOffset[12][1]&&vCount<=screen_vStartPos[12][1]+v+screen_vOffset[12][1]+screen_objHeight[12][1]&&vCount>=screen_vStartPos[12][1]+v+screen_vOffset[12][1]) Sel<=screen_color[12][1]; 
    else if(screen_visible[13][1]==1&&hCount<=screen_hStartPos[13][1]+h+screen_hOffset[13][1]+screen_objWidth[13][1]&&hCount>=screen_hStartPos[13][1]+h+screen_hOffset[13][1]&&vCount<=screen_vStartPos[13][1]+v+screen_vOffset[13][1]+screen_objHeight[13][1]&&vCount>=screen_vStartPos[13][1]+v+screen_vOffset[13][1]) Sel<=screen_color[13][1]; 
    else if(screen_visible[14][1]==1&&hCount<=screen_hStartPos[14][1]+h+screen_hOffset[14][1]+screen_objWidth[14][1]&&hCount>=screen_hStartPos[14][1]+h+screen_hOffset[14][1]&&vCount<=screen_vStartPos[14][1]+v+screen_vOffset[14][1]+screen_objHeight[14][1]&&vCount>=screen_vStartPos[14][1]+v+screen_vOffset[14][1]) Sel<=screen_color[14][1]; 
    else if(screen_visible[15][1]==1&&hCount<=screen_hStartPos[15][1]+h+screen_hOffset[15][1]+screen_objWidth[15][1]&&hCount>=screen_hStartPos[15][1]+h+screen_hOffset[15][1]&&vCount<=screen_vStartPos[15][1]+v+screen_vOffset[15][1]+screen_objHeight[15][1]&&vCount>=screen_vStartPos[15][1]+v+screen_vOffset[15][1]) Sel<=screen_color[15][1]; 
    else if(screen_visible[16][1]==1&&hCount<=screen_hStartPos[16][1]+h+screen_hOffset[16][1]+screen_objWidth[16][1]&&hCount>=screen_hStartPos[16][1]+h+screen_hOffset[16][1]&&vCount<=screen_vStartPos[16][1]+v+screen_vOffset[16][1]+screen_objHeight[16][1]&&vCount>=screen_vStartPos[16][1]+v+screen_vOffset[16][1]) Sel<=screen_color[16][1]; 
    else if(screen_visible[17][1]==1&&hCount<=screen_hStartPos[17][1]+h+screen_hOffset[17][1]+screen_objWidth[17][1]&&hCount>=screen_hStartPos[17][1]+h+screen_hOffset[17][1]&&vCount<=screen_vStartPos[17][1]+v+screen_vOffset[17][1]+screen_objHeight[17][1]&&vCount>=screen_vStartPos[17][1]+v+screen_vOffset[17][1]) Sel<=screen_color[17][1]; 
    else if(screen_visible[18][1]==1&&hCount<=screen_hStartPos[18][1]+h+screen_hOffset[18][1]+screen_objWidth[18][1]&&hCount>=screen_hStartPos[18][1]+h+screen_hOffset[18][1]&&vCount<=screen_vStartPos[18][1]+v+screen_vOffset[18][1]+screen_objHeight[18][1]&&vCount>=screen_vStartPos[18][1]+v+screen_vOffset[18][1]) Sel<=screen_color[18][1]; 
    else if(screen_visible[19][1]==1&&hCount<=screen_hStartPos[19][1]+h+screen_hOffset[19][1]+screen_objWidth[19][1]&&hCount>=screen_hStartPos[19][1]+h+screen_hOffset[19][1]&&vCount<=screen_vStartPos[19][1]+v+screen_vOffset[19][1]+screen_objHeight[19][1]&&vCount>=screen_vStartPos[19][1]+v+screen_vOffset[19][1]) Sel<=screen_color[19][1]; 
    else if(screen_visible[20][1]==1&&hCount<=screen_hStartPos[20][1]+h+screen_hOffset[20][1]+screen_objWidth[20][1]&&hCount>=screen_hStartPos[20][1]+h+screen_hOffset[20][1]&&vCount<=screen_vStartPos[20][1]+v+screen_vOffset[20][1]+screen_objHeight[20][1]&&vCount>=screen_vStartPos[20][1]+v+screen_vOffset[20][1]) Sel<=screen_color[20][1]; 
    else if(screen_visible[21][1]==1&&hCount<=screen_hStartPos[21][1]+h+screen_hOffset[21][1]+screen_objWidth[21][1]&&hCount>=screen_hStartPos[21][1]+h+screen_hOffset[21][1]&&vCount<=screen_vStartPos[21][1]+v+screen_vOffset[21][1]+screen_objHeight[21][1]&&vCount>=screen_vStartPos[21][1]+v+screen_vOffset[21][1]) Sel<=screen_color[21][1]; 
    else if(screen_visible[22][1]==1&&hCount<=screen_hStartPos[22][1]+h+screen_hOffset[22][1]+screen_objWidth[22][1]&&hCount>=screen_hStartPos[22][1]+h+screen_hOffset[22][1]&&vCount<=screen_vStartPos[22][1]+v+screen_vOffset[22][1]+screen_objHeight[22][1]&&vCount>=screen_vStartPos[22][1]+v+screen_vOffset[22][1]) Sel<=screen_color[22][1]; 
    else if(screen_visible[23][1]==1&&hCount<=screen_hStartPos[23][1]+h+screen_hOffset[23][1]+screen_objWidth[23][1]&&hCount>=screen_hStartPos[23][1]+h+screen_hOffset[23][1]&&vCount<=screen_vStartPos[23][1]+v+screen_vOffset[23][1]+screen_objHeight[23][1]&&vCount>=screen_vStartPos[23][1]+v+screen_vOffset[23][1]) Sel<=screen_color[23][1]; 






//SCREEN 2
    else if(screen_visible[0 ][2]==1&&hCount<=screen_hStartPos[0 ][2]+h+screen_hOffset[0 ][2]+screen_objWidth[0 ][2]&&hCount>=screen_hStartPos[0 ][2]+h+screen_hOffset[0 ][2]&&vCount<=screen_vStartPos[0 ][2]+v+screen_vOffset[0 ][2]+screen_objHeight[0 ][2]&&vCount>=screen_vStartPos[0 ][2]+v+screen_vOffset[0 ][2]) Sel<=screen_color[0 ][2]; 
    else if(screen_visible[1 ][2]==1&&hCount<=screen_hStartPos[1 ][2]+h+screen_hOffset[1 ][2]+screen_objWidth[1 ][2]&&hCount>=screen_hStartPos[1 ][2]+h+screen_hOffset[1 ][2]&&vCount<=screen_vStartPos[1 ][2]+v+screen_vOffset[1 ][2]+screen_objHeight[1 ][2]&&vCount>=screen_vStartPos[1 ][2]+v+screen_vOffset[1 ][2]) Sel<=screen_color[1 ][2]; 
    else if(screen_visible[2 ][2]==1&&hCount<=screen_hStartPos[2 ][2]+h+screen_hOffset[2 ][2]+screen_objWidth[2 ][2]&&hCount>=screen_hStartPos[2 ][2]+h+screen_hOffset[2 ][2]&&vCount<=screen_vStartPos[2 ][2]+v+screen_vOffset[2 ][2]+screen_objHeight[2 ][2]&&vCount>=screen_vStartPos[2 ][2]+v+screen_vOffset[2 ][2]) Sel<=screen_color[2 ][2]; 
    else if(screen_visible[3 ][2]==1&&hCount<=screen_hStartPos[3 ][2]+h+screen_hOffset[3 ][2]+screen_objWidth[3 ][2]&&hCount>=screen_hStartPos[3 ][2]+h+screen_hOffset[3 ][2]&&vCount<=screen_vStartPos[3 ][2]+v+screen_vOffset[3 ][2]+screen_objHeight[3 ][2]&&vCount>=screen_vStartPos[3 ][2]+v+screen_vOffset[3 ][2]) Sel<=screen_color[3 ][2]; 
    else if(screen_visible[4 ][2]==1&&hCount<=screen_hStartPos[4 ][2]+h+screen_hOffset[4 ][2]+screen_objWidth[4 ][2]&&hCount>=screen_hStartPos[4 ][2]+h+screen_hOffset[4 ][2]&&vCount<=screen_vStartPos[4 ][2]+v+screen_vOffset[4 ][2]+screen_objHeight[4 ][2]&&vCount>=screen_vStartPos[4 ][2]+v+screen_vOffset[4 ][2]) Sel<=screen_color[4 ][2]; 
    else if(screen_visible[5 ][2]==1&&hCount<=screen_hStartPos[5 ][2]+h+screen_hOffset[5 ][2]+screen_objWidth[5 ][2]&&hCount>=screen_hStartPos[5 ][2]+h+screen_hOffset[5 ][2]&&vCount<=screen_vStartPos[5 ][2]+v+screen_vOffset[5 ][2]+screen_objHeight[5 ][2]&&vCount>=screen_vStartPos[5 ][2]+v+screen_vOffset[5 ][2]) Sel<=screen_color[5 ][2]; 
    else if(screen_visible[6 ][2]==1&&hCount<=screen_hStartPos[6 ][2]+h+screen_hOffset[6 ][2]+screen_objWidth[6 ][2]&&hCount>=screen_hStartPos[6 ][2]+h+screen_hOffset[6 ][2]&&vCount<=screen_vStartPos[6 ][2]+v+screen_vOffset[6 ][2]+screen_objHeight[6 ][2]&&vCount>=screen_vStartPos[6 ][2]+v+screen_vOffset[6 ][2]) Sel<=screen_color[6 ][2]; 
    else if(screen_visible[7 ][2]==1&&hCount<=screen_hStartPos[7 ][2]+h+screen_hOffset[7 ][2]+screen_objWidth[7 ][2]&&hCount>=screen_hStartPos[7 ][2]+h+screen_hOffset[7 ][2]&&vCount<=screen_vStartPos[7 ][2]+v+screen_vOffset[7 ][2]+screen_objHeight[7 ][2]&&vCount>=screen_vStartPos[7 ][2]+v+screen_vOffset[7 ][2]) Sel<=screen_color[7 ][2]; 
    else if(screen_visible[8 ][2]==1&&hCount<=screen_hStartPos[8 ][2]+h+screen_hOffset[8 ][2]+screen_objWidth[8 ][2]&&hCount>=screen_hStartPos[8 ][2]+h+screen_hOffset[8 ][2]&&vCount<=screen_vStartPos[8 ][2]+v+screen_vOffset[8 ][2]+screen_objHeight[8 ][2]&&vCount>=screen_vStartPos[8 ][2]+v+screen_vOffset[8 ][2]) Sel<=screen_color[8 ][2]; 
    else if(screen_visible[9 ][2]==1&&hCount<=screen_hStartPos[9 ][2]+h+screen_hOffset[9 ][2]+screen_objWidth[9 ][2]&&hCount>=screen_hStartPos[9 ][2]+h+screen_hOffset[9 ][2]&&vCount<=screen_vStartPos[9 ][2]+v+screen_vOffset[9 ][2]+screen_objHeight[9 ][2]&&vCount>=screen_vStartPos[9 ][2]+v+screen_vOffset[9 ][2]) Sel<=screen_color[9 ][2]; 
    else if(screen_visible[10][2]==1&&hCount<=screen_hStartPos[10][2]+h+screen_hOffset[10][2]+screen_objWidth[10][2]&&hCount>=screen_hStartPos[10][2]+h+screen_hOffset[10][2]&&vCount<=screen_vStartPos[10][2]+v+screen_vOffset[10][2]+screen_objHeight[10][2]&&vCount>=screen_vStartPos[10][2]+v+screen_vOffset[10][2]) Sel<=screen_color[10][2]; 
    else if(screen_visible[11][2]==1&&hCount<=screen_hStartPos[11][2]+h+screen_hOffset[11][2]+screen_objWidth[11][2]&&hCount>=screen_hStartPos[11][2]+h+screen_hOffset[11][2]&&vCount<=screen_vStartPos[11][2]+v+screen_vOffset[11][2]+screen_objHeight[11][2]&&vCount>=screen_vStartPos[11][2]+v+screen_vOffset[11][2]) Sel<=screen_color[11][2]; 
    else if(screen_visible[12][2]==1&&hCount<=screen_hStartPos[12][2]+h+screen_hOffset[12][2]+screen_objWidth[12][2]&&hCount>=screen_hStartPos[12][2]+h+screen_hOffset[12][2]&&vCount<=screen_vStartPos[12][2]+v+screen_vOffset[12][2]+screen_objHeight[12][2]&&vCount>=screen_vStartPos[12][2]+v+screen_vOffset[12][2]) Sel<=screen_color[12][2]; 
    else if(screen_visible[13][2]==1&&hCount<=screen_hStartPos[13][2]+h+screen_hOffset[13][2]+screen_objWidth[13][2]&&hCount>=screen_hStartPos[13][2]+h+screen_hOffset[13][2]&&vCount<=screen_vStartPos[13][2]+v+screen_vOffset[13][2]+screen_objHeight[13][2]&&vCount>=screen_vStartPos[13][2]+v+screen_vOffset[13][2]) Sel<=screen_color[13][2]; 
    else if(screen_visible[14][2]==1&&hCount<=screen_hStartPos[14][2]+h+screen_hOffset[14][2]+screen_objWidth[14][2]&&hCount>=screen_hStartPos[14][2]+h+screen_hOffset[14][2]&&vCount<=screen_vStartPos[14][2]+v+screen_vOffset[14][2]+screen_objHeight[14][2]&&vCount>=screen_vStartPos[14][2]+v+screen_vOffset[14][2]) Sel<=screen_color[14][2]; 
    else if(screen_visible[15][2]==1&&hCount<=screen_hStartPos[15][2]+h+screen_hOffset[15][2]+screen_objWidth[15][2]&&hCount>=screen_hStartPos[15][2]+h+screen_hOffset[15][2]&&vCount<=screen_vStartPos[15][2]+v+screen_vOffset[15][2]+screen_objHeight[15][2]&&vCount>=screen_vStartPos[15][2]+v+screen_vOffset[15][2]) Sel<=screen_color[15][2]; 
    else if(screen_visible[16][2]==1&&hCount<=screen_hStartPos[16][2]+h+screen_hOffset[16][2]+screen_objWidth[16][2]&&hCount>=screen_hStartPos[16][2]+h+screen_hOffset[16][2]&&vCount<=screen_vStartPos[16][2]+v+screen_vOffset[16][2]+screen_objHeight[16][2]&&vCount>=screen_vStartPos[16][2]+v+screen_vOffset[16][2]) Sel<=screen_color[16][2]; 
    else if(screen_visible[17][2]==1&&hCount<=screen_hStartPos[17][2]+h+screen_hOffset[17][2]+screen_objWidth[17][2]&&hCount>=screen_hStartPos[17][2]+h+screen_hOffset[17][2]&&vCount<=screen_vStartPos[17][2]+v+screen_vOffset[17][2]+screen_objHeight[17][2]&&vCount>=screen_vStartPos[17][2]+v+screen_vOffset[17][2]) Sel<=screen_color[17][2]; 
    else if(screen_visible[18][2]==1&&hCount<=screen_hStartPos[18][2]+h+screen_hOffset[18][2]+screen_objWidth[18][2]&&hCount>=screen_hStartPos[18][2]+h+screen_hOffset[18][2]&&vCount<=screen_vStartPos[18][2]+v+screen_vOffset[18][2]+screen_objHeight[18][2]&&vCount>=screen_vStartPos[18][2]+v+screen_vOffset[18][2]) Sel<=screen_color[18][2]; 
    else if(screen_visible[19][2]==1&&hCount<=screen_hStartPos[19][2]+h+screen_hOffset[19][2]+screen_objWidth[19][2]&&hCount>=screen_hStartPos[19][2]+h+screen_hOffset[19][2]&&vCount<=screen_vStartPos[19][2]+v+screen_vOffset[19][2]+screen_objHeight[19][2]&&vCount>=screen_vStartPos[19][2]+v+screen_vOffset[19][2]) Sel<=screen_color[19][2]; 
    else if(screen_visible[20][2]==1&&hCount<=screen_hStartPos[20][2]+h+screen_hOffset[20][2]+screen_objWidth[20][2]&&hCount>=screen_hStartPos[20][2]+h+screen_hOffset[20][2]&&vCount<=screen_vStartPos[20][2]+v+screen_vOffset[20][2]+screen_objHeight[20][2]&&vCount>=screen_vStartPos[20][2]+v+screen_vOffset[20][2]) Sel<=screen_color[20][2]; 
    else if(screen_visible[21][2]==1&&hCount<=screen_hStartPos[21][2]+h+screen_hOffset[21][2]+screen_objWidth[21][2]&&hCount>=screen_hStartPos[21][2]+h+screen_hOffset[21][2]&&vCount<=screen_vStartPos[21][2]+v+screen_vOffset[21][2]+screen_objHeight[21][2]&&vCount>=screen_vStartPos[21][2]+v+screen_vOffset[21][2]) Sel<=screen_color[21][2]; 
    else if(screen_visible[22][2]==1&&hCount<=screen_hStartPos[22][2]+h+screen_hOffset[22][2]+screen_objWidth[22][2]&&hCount>=screen_hStartPos[22][2]+h+screen_hOffset[22][2]&&vCount<=screen_vStartPos[22][2]+v+screen_vOffset[22][2]+screen_objHeight[22][2]&&vCount>=screen_vStartPos[22][2]+v+screen_vOffset[22][2]) Sel<=screen_color[22][2]; 
    else if(screen_visible[23][2]==1&&hCount<=screen_hStartPos[23][2]+h+screen_hOffset[23][2]+screen_objWidth[23][2]&&hCount>=screen_hStartPos[23][2]+h+screen_hOffset[23][2]&&vCount<=screen_vStartPos[23][2]+v+screen_vOffset[23][2]+screen_objHeight[23][2]&&vCount>=screen_vStartPos[23][2]+v+screen_vOffset[23][2]) Sel<=screen_color[23][2]; 

// SCREEN 3
    else if(screen_visible[0 ][3]==1&&hCount<=screen_hStartPos[0 ][3]+h+screen_hOffset[0 ][3]+screen_objWidth[0 ][3]&&hCount>=screen_hStartPos[0 ][3]+h+screen_hOffset[0 ][3]&&vCount<=screen_vStartPos[0 ][3]+v+screen_vOffset[0 ][3]+screen_objHeight[0 ][3]&&vCount>=screen_vStartPos[0 ][3]+v+screen_vOffset[0 ][3]) Sel<=screen_color[0 ][3]; 
    else if(screen_visible[1 ][3]==1&&hCount<=screen_hStartPos[1 ][3]+h+screen_hOffset[1 ][3]+screen_objWidth[1 ][3]&&hCount>=screen_hStartPos[1 ][3]+h+screen_hOffset[1 ][3]&&vCount<=screen_vStartPos[1 ][3]+v+screen_vOffset[1 ][3]+screen_objHeight[1 ][3]&&vCount>=screen_vStartPos[1 ][3]+v+screen_vOffset[1 ][3]) Sel<=screen_color[1 ][3]; 
    else if(screen_visible[2 ][3]==1&&hCount<=screen_hStartPos[2 ][3]+h+screen_hOffset[2 ][3]+screen_objWidth[2 ][3]&&hCount>=screen_hStartPos[2 ][3]+h+screen_hOffset[2 ][3]&&vCount<=screen_vStartPos[2 ][3]+v+screen_vOffset[2 ][3]+screen_objHeight[2 ][3]&&vCount>=screen_vStartPos[2 ][3]+v+screen_vOffset[2 ][3]) Sel<=screen_color[2 ][3]; 
    else if(screen_visible[3 ][3]==1&&hCount<=screen_hStartPos[3 ][3]+h+screen_hOffset[3 ][3]+screen_objWidth[3 ][3]&&hCount>=screen_hStartPos[3 ][3]+h+screen_hOffset[3 ][3]&&vCount<=screen_vStartPos[3 ][3]+v+screen_vOffset[3 ][3]+screen_objHeight[3 ][3]&&vCount>=screen_vStartPos[3 ][3]+v+screen_vOffset[3 ][3]) Sel<=screen_color[3 ][3]; 
    else if(screen_visible[4 ][3]==1&&hCount<=screen_hStartPos[4 ][3]+h+screen_hOffset[4 ][3]+screen_objWidth[4 ][3]&&hCount>=screen_hStartPos[4 ][3]+h+screen_hOffset[4 ][3]&&vCount<=screen_vStartPos[4 ][3]+v+screen_vOffset[4 ][3]+screen_objHeight[4 ][3]&&vCount>=screen_vStartPos[4 ][3]+v+screen_vOffset[4 ][3]) Sel<=screen_color[4 ][3]; 
    else if(screen_visible[5 ][3]==1&&hCount<=screen_hStartPos[5 ][3]+h+screen_hOffset[5 ][3]+screen_objWidth[5 ][3]&&hCount>=screen_hStartPos[5 ][3]+h+screen_hOffset[5 ][3]&&vCount<=screen_vStartPos[5 ][3]+v+screen_vOffset[5 ][3]+screen_objHeight[5 ][3]&&vCount>=screen_vStartPos[5 ][3]+v+screen_vOffset[5 ][3]) Sel<=screen_color[5 ][3]; 
    else if(screen_visible[6 ][3]==1&&hCount<=screen_hStartPos[6 ][3]+h+screen_hOffset[6 ][3]+screen_objWidth[6 ][3]&&hCount>=screen_hStartPos[6 ][3]+h+screen_hOffset[6 ][3]&&vCount<=screen_vStartPos[6 ][3]+v+screen_vOffset[6 ][3]+screen_objHeight[6 ][3]&&vCount>=screen_vStartPos[6 ][3]+v+screen_vOffset[6 ][3]) Sel<=screen_color[6 ][3]; 
    else if(screen_visible[7 ][3]==1&&hCount<=screen_hStartPos[7 ][3]+h+screen_hOffset[7 ][3]+screen_objWidth[7 ][3]&&hCount>=screen_hStartPos[7 ][3]+h+screen_hOffset[7 ][3]&&vCount<=screen_vStartPos[7 ][3]+v+screen_vOffset[7 ][3]+screen_objHeight[7 ][3]&&vCount>=screen_vStartPos[7 ][3]+v+screen_vOffset[7 ][3]) Sel<=screen_color[7 ][3]; 
    else if(screen_visible[8 ][3]==1&&hCount<=screen_hStartPos[8 ][3]+h+screen_hOffset[8 ][3]+screen_objWidth[8 ][3]&&hCount>=screen_hStartPos[8 ][3]+h+screen_hOffset[8 ][3]&&vCount<=screen_vStartPos[8 ][3]+v+screen_vOffset[8 ][3]+screen_objHeight[8 ][3]&&vCount>=screen_vStartPos[8 ][3]+v+screen_vOffset[8 ][3]) Sel<=screen_color[8 ][3]; 
    else if(screen_visible[9 ][3]==1&&hCount<=screen_hStartPos[9 ][3]+h+screen_hOffset[9 ][3]+screen_objWidth[9 ][3]&&hCount>=screen_hStartPos[9 ][3]+h+screen_hOffset[9 ][3]&&vCount<=screen_vStartPos[9 ][3]+v+screen_vOffset[9 ][3]+screen_objHeight[9 ][3]&&vCount>=screen_vStartPos[9 ][3]+v+screen_vOffset[9 ][3]) Sel<=screen_color[9 ][3]; 
    else if(screen_visible[10][3]==1&&hCount<=screen_hStartPos[10][3]+h+screen_hOffset[10][3]+screen_objWidth[10][3]&&hCount>=screen_hStartPos[10][3]+h+screen_hOffset[10][3]&&vCount<=screen_vStartPos[10][3]+v+screen_vOffset[10][3]+screen_objHeight[10][3]&&vCount>=screen_vStartPos[10][3]+v+screen_vOffset[10][3]) Sel<=screen_color[10][3]; 
    else if(screen_visible[11][3]==1&&hCount<=screen_hStartPos[11][3]+h+screen_hOffset[11][3]+screen_objWidth[11][3]&&hCount>=screen_hStartPos[11][3]+h+screen_hOffset[11][3]&&vCount<=screen_vStartPos[11][3]+v+screen_vOffset[11][3]+screen_objHeight[11][3]&&vCount>=screen_vStartPos[11][3]+v+screen_vOffset[11][3]) Sel<=screen_color[11][3]; 
    else if(screen_visible[12][3]==1&&hCount<=screen_hStartPos[12][3]+h+screen_hOffset[12][3]+screen_objWidth[12][3]&&hCount>=screen_hStartPos[12][3]+h+screen_hOffset[12][3]&&vCount<=screen_vStartPos[12][3]+v+screen_vOffset[12][3]+screen_objHeight[12][3]&&vCount>=screen_vStartPos[12][3]+v+screen_vOffset[12][3]) Sel<=screen_color[12][3]; 
    else if(screen_visible[13][3]==1&&hCount<=screen_hStartPos[13][3]+h+screen_hOffset[13][3]+screen_objWidth[13][3]&&hCount>=screen_hStartPos[13][3]+h+screen_hOffset[13][3]&&vCount<=screen_vStartPos[13][3]+v+screen_vOffset[13][3]+screen_objHeight[13][3]&&vCount>=screen_vStartPos[13][3]+v+screen_vOffset[13][3]) Sel<=screen_color[13][3]; 
    else if(screen_visible[14][3]==1&&hCount<=screen_hStartPos[14][3]+h+screen_hOffset[14][3]+screen_objWidth[14][3]&&hCount>=screen_hStartPos[14][3]+h+screen_hOffset[14][3]&&vCount<=screen_vStartPos[14][3]+v+screen_vOffset[14][3]+screen_objHeight[14][3]&&vCount>=screen_vStartPos[14][3]+v+screen_vOffset[14][3]) Sel<=screen_color[14][3]; 
    else if(screen_visible[15][3]==1&&hCount<=screen_hStartPos[15][3]+h+screen_hOffset[15][3]+screen_objWidth[15][3]&&hCount>=screen_hStartPos[15][3]+h+screen_hOffset[15][3]&&vCount<=screen_vStartPos[15][3]+v+screen_vOffset[15][3]+screen_objHeight[15][3]&&vCount>=screen_vStartPos[15][3]+v+screen_vOffset[15][3]) Sel<=screen_color[15][3]; 
    else if(screen_visible[16][3]==1&&hCount<=screen_hStartPos[16][3]+h+screen_hOffset[16][3]+screen_objWidth[16][3]&&hCount>=screen_hStartPos[16][3]+h+screen_hOffset[16][3]&&vCount<=screen_vStartPos[16][3]+v+screen_vOffset[16][3]+screen_objHeight[16][3]&&vCount>=screen_vStartPos[16][3]+v+screen_vOffset[16][3]) Sel<=screen_color[16][3]; 
    else if(screen_visible[17][3]==1&&hCount<=screen_hStartPos[17][3]+h+screen_hOffset[17][3]+screen_objWidth[17][3]&&hCount>=screen_hStartPos[17][3]+h+screen_hOffset[17][3]&&vCount<=screen_vStartPos[17][3]+v+screen_vOffset[17][3]+screen_objHeight[17][3]&&vCount>=screen_vStartPos[17][3]+v+screen_vOffset[17][3]) Sel<=screen_color[17][3]; 
    else if(screen_visible[18][3]==1&&hCount<=screen_hStartPos[18][3]+h+screen_hOffset[18][3]+screen_objWidth[18][3]&&hCount>=screen_hStartPos[18][3]+h+screen_hOffset[18][3]&&vCount<=screen_vStartPos[18][3]+v+screen_vOffset[18][3]+screen_objHeight[18][3]&&vCount>=screen_vStartPos[18][3]+v+screen_vOffset[18][3]) Sel<=screen_color[18][3]; 
    else if(screen_visible[19][3]==1&&hCount<=screen_hStartPos[19][3]+h+screen_hOffset[19][3]+screen_objWidth[19][3]&&hCount>=screen_hStartPos[19][3]+h+screen_hOffset[19][3]&&vCount<=screen_vStartPos[19][3]+v+screen_vOffset[19][3]+screen_objHeight[19][3]&&vCount>=screen_vStartPos[19][3]+v+screen_vOffset[19][3]) Sel<=screen_color[19][3]; 
    else if(screen_visible[20][3]==1&&hCount<=screen_hStartPos[20][3]+h+screen_hOffset[20][3]+screen_objWidth[20][3]&&hCount>=screen_hStartPos[20][3]+h+screen_hOffset[20][3]&&vCount<=screen_vStartPos[20][3]+v+screen_vOffset[20][3]+screen_objHeight[20][3]&&vCount>=screen_vStartPos[20][3]+v+screen_vOffset[20][3]) Sel<=screen_color[20][3]; 
    else if(screen_visible[21][3]==1&&hCount<=screen_hStartPos[21][3]+h+screen_hOffset[21][3]+screen_objWidth[21][3]&&hCount>=screen_hStartPos[21][3]+h+screen_hOffset[21][3]&&vCount<=screen_vStartPos[21][3]+v+screen_vOffset[21][3]+screen_objHeight[21][3]&&vCount>=screen_vStartPos[21][3]+v+screen_vOffset[21][3]) Sel<=screen_color[21][3]; 
    else if(screen_visible[22][3]==1&&hCount<=screen_hStartPos[22][3]+h+screen_hOffset[22][3]+screen_objWidth[22][3]&&hCount>=screen_hStartPos[22][3]+h+screen_hOffset[22][3]&&vCount<=screen_vStartPos[22][3]+v+screen_vOffset[22][3]+screen_objHeight[22][3]&&vCount>=screen_vStartPos[22][3]+v+screen_vOffset[22][3]) Sel<=screen_color[22][3]; 
    else if(screen_visible[23][3]==1&&hCount<=screen_hStartPos[23][3]+h+screen_hOffset[23][3]+screen_objWidth[23][3]&&hCount>=screen_hStartPos[23][3]+h+screen_hOffset[23][3]&&vCount<=screen_vStartPos[23][3]+v+screen_vOffset[23][3]+screen_objHeight[23][3]&&vCount>=screen_vStartPos[23][3]+v+screen_vOffset[23][3]) Sel<=screen_color[23][3]; 
        
// SCREEN 4
    else if(screen_visible[0 ][4]==1&&hCount<=screen_hStartPos[0 ][4]+h+screen_hOffset[0 ][4]+screen_objWidth[0 ][4]&&hCount>=screen_hStartPos[0 ][4]+h+screen_hOffset[0 ][4]&&vCount<=screen_vStartPos[0 ][4]+v+screen_vOffset[0 ][4]+screen_objHeight[0 ][4]&&vCount>=screen_vStartPos[0 ][4]+v+screen_vOffset[0 ][4]) Sel<=screen_color[0 ][4]; 
    else if(screen_visible[1 ][4]==1&&hCount<=screen_hStartPos[1 ][4]+h+screen_hOffset[1 ][4]+screen_objWidth[1 ][4]&&hCount>=screen_hStartPos[1 ][4]+h+screen_hOffset[1 ][4]&&vCount<=screen_vStartPos[1 ][4]+v+screen_vOffset[1 ][4]+screen_objHeight[1 ][4]&&vCount>=screen_vStartPos[1 ][4]+v+screen_vOffset[1 ][4]) Sel<=screen_color[1 ][4]; 
    else if(screen_visible[2 ][4]==1&&hCount<=screen_hStartPos[2 ][4]+h+screen_hOffset[2 ][4]+screen_objWidth[2 ][4]&&hCount>=screen_hStartPos[2 ][4]+h+screen_hOffset[2 ][4]&&vCount<=screen_vStartPos[2 ][4]+v+screen_vOffset[2 ][4]+screen_objHeight[2 ][4]&&vCount>=screen_vStartPos[2 ][4]+v+screen_vOffset[2 ][4]) Sel<=screen_color[2 ][4]; 
    else if(screen_visible[3 ][4]==1&&hCount<=screen_hStartPos[3 ][4]+h+screen_hOffset[3 ][4]+screen_objWidth[3 ][4]&&hCount>=screen_hStartPos[3 ][4]+h+screen_hOffset[3 ][4]&&vCount<=screen_vStartPos[3 ][4]+v+screen_vOffset[3 ][4]+screen_objHeight[3 ][4]&&vCount>=screen_vStartPos[3 ][4]+v+screen_vOffset[3 ][4]) Sel<=screen_color[3 ][4]; 
    else if(screen_visible[4 ][4]==1&&hCount<=screen_hStartPos[4 ][4]+h+screen_hOffset[4 ][4]+screen_objWidth[4 ][4]&&hCount>=screen_hStartPos[4 ][4]+h+screen_hOffset[4 ][4]&&vCount<=screen_vStartPos[4 ][4]+v+screen_vOffset[4 ][4]+screen_objHeight[4 ][4]&&vCount>=screen_vStartPos[4 ][4]+v+screen_vOffset[4 ][4]) Sel<=screen_color[4 ][4]; 
    else if(screen_visible[5 ][4]==1&&hCount<=screen_hStartPos[5 ][4]+h+screen_hOffset[5 ][4]+screen_objWidth[5 ][4]&&hCount>=screen_hStartPos[5 ][4]+h+screen_hOffset[5 ][4]&&vCount<=screen_vStartPos[5 ][4]+v+screen_vOffset[5 ][4]+screen_objHeight[5 ][4]&&vCount>=screen_vStartPos[5 ][4]+v+screen_vOffset[5 ][4]) Sel<=screen_color[5 ][4]; 
    else if(screen_visible[6 ][4]==1&&hCount<=screen_hStartPos[6 ][4]+h+screen_hOffset[6 ][4]+screen_objWidth[6 ][4]&&hCount>=screen_hStartPos[6 ][4]+h+screen_hOffset[6 ][4]&&vCount<=screen_vStartPos[6 ][4]+v+screen_vOffset[6 ][4]+screen_objHeight[6 ][4]&&vCount>=screen_vStartPos[6 ][4]+v+screen_vOffset[6 ][4]) Sel<=screen_color[6 ][4]; 
    else if(screen_visible[7 ][4]==1&&hCount<=screen_hStartPos[7 ][4]+h+screen_hOffset[7 ][4]+screen_objWidth[7 ][4]&&hCount>=screen_hStartPos[7 ][4]+h+screen_hOffset[7 ][4]&&vCount<=screen_vStartPos[7 ][4]+v+screen_vOffset[7 ][4]+screen_objHeight[7 ][4]&&vCount>=screen_vStartPos[7 ][4]+v+screen_vOffset[7 ][4]) Sel<=screen_color[7 ][4]; 
    else if(screen_visible[8 ][4]==1&&hCount<=screen_hStartPos[8 ][4]+h+screen_hOffset[8 ][4]+screen_objWidth[8 ][4]&&hCount>=screen_hStartPos[8 ][4]+h+screen_hOffset[8 ][4]&&vCount<=screen_vStartPos[8 ][4]+v+screen_vOffset[8 ][4]+screen_objHeight[8 ][4]&&vCount>=screen_vStartPos[8 ][4]+v+screen_vOffset[8 ][4]) Sel<=screen_color[8 ][4]; 
    else if(screen_visible[9 ][4]==1&&hCount<=screen_hStartPos[9 ][4]+h+screen_hOffset[9 ][4]+screen_objWidth[9 ][4]&&hCount>=screen_hStartPos[9 ][4]+h+screen_hOffset[9 ][4]&&vCount<=screen_vStartPos[9 ][4]+v+screen_vOffset[9 ][4]+screen_objHeight[9 ][4]&&vCount>=screen_vStartPos[9 ][4]+v+screen_vOffset[9 ][4]) Sel<=screen_color[9 ][4]; 
    else if(screen_visible[10][4]==1&&hCount<=screen_hStartPos[10][4]+h+screen_hOffset[10][4]+screen_objWidth[10][4]&&hCount>=screen_hStartPos[10][4]+h+screen_hOffset[10][4]&&vCount<=screen_vStartPos[10][4]+v+screen_vOffset[10][4]+screen_objHeight[10][4]&&vCount>=screen_vStartPos[10][4]+v+screen_vOffset[10][4]) Sel<=screen_color[10][4]; 
    else if(screen_visible[11][4]==1&&hCount<=screen_hStartPos[11][4]+h+screen_hOffset[11][4]+screen_objWidth[11][4]&&hCount>=screen_hStartPos[11][4]+h+screen_hOffset[11][4]&&vCount<=screen_vStartPos[11][4]+v+screen_vOffset[11][4]+screen_objHeight[11][4]&&vCount>=screen_vStartPos[11][4]+v+screen_vOffset[11][4]) Sel<=screen_color[11][4]; 
    else if(screen_visible[12][4]==1&&hCount<=screen_hStartPos[12][4]+h+screen_hOffset[12][4]+screen_objWidth[12][4]&&hCount>=screen_hStartPos[12][4]+h+screen_hOffset[12][4]&&vCount<=screen_vStartPos[12][4]+v+screen_vOffset[12][4]+screen_objHeight[12][4]&&vCount>=screen_vStartPos[12][4]+v+screen_vOffset[12][4]) Sel<=screen_color[12][4]; 
    else if(screen_visible[13][4]==1&&hCount<=screen_hStartPos[13][4]+h+screen_hOffset[13][4]+screen_objWidth[13][4]&&hCount>=screen_hStartPos[13][4]+h+screen_hOffset[13][4]&&vCount<=screen_vStartPos[13][4]+v+screen_vOffset[13][4]+screen_objHeight[13][4]&&vCount>=screen_vStartPos[13][4]+v+screen_vOffset[13][4]) Sel<=screen_color[13][4]; 
    else if(screen_visible[14][4]==1&&hCount<=screen_hStartPos[14][4]+h+screen_hOffset[14][4]+screen_objWidth[14][4]&&hCount>=screen_hStartPos[14][4]+h+screen_hOffset[14][4]&&vCount<=screen_vStartPos[14][4]+v+screen_vOffset[14][4]+screen_objHeight[14][4]&&vCount>=screen_vStartPos[14][4]+v+screen_vOffset[14][4]) Sel<=screen_color[14][4]; 
    else if(screen_visible[15][4]==1&&hCount<=screen_hStartPos[15][4]+h+screen_hOffset[15][4]+screen_objWidth[15][4]&&hCount>=screen_hStartPos[15][4]+h+screen_hOffset[15][4]&&vCount<=screen_vStartPos[15][4]+v+screen_vOffset[15][4]+screen_objHeight[15][4]&&vCount>=screen_vStartPos[15][4]+v+screen_vOffset[15][4]) Sel<=screen_color[15][4]; 
    else if(screen_visible[16][4]==1&&hCount<=screen_hStartPos[16][4]+h+screen_hOffset[16][4]+screen_objWidth[16][4]&&hCount>=screen_hStartPos[16][4]+h+screen_hOffset[16][4]&&vCount<=screen_vStartPos[16][4]+v+screen_vOffset[16][4]+screen_objHeight[16][4]&&vCount>=screen_vStartPos[16][4]+v+screen_vOffset[16][4]) Sel<=screen_color[16][4]; 
    else if(screen_visible[17][4]==1&&hCount<=screen_hStartPos[17][4]+h+screen_hOffset[17][4]+screen_objWidth[17][4]&&hCount>=screen_hStartPos[17][4]+h+screen_hOffset[17][4]&&vCount<=screen_vStartPos[17][4]+v+screen_vOffset[17][4]+screen_objHeight[17][4]&&vCount>=screen_vStartPos[17][4]+v+screen_vOffset[17][4]) Sel<=screen_color[17][4]; 
    else if(screen_visible[18][4]==1&&hCount<=screen_hStartPos[18][4]+h+screen_hOffset[18][4]+screen_objWidth[18][4]&&hCount>=screen_hStartPos[18][4]+h+screen_hOffset[18][4]&&vCount<=screen_vStartPos[18][4]+v+screen_vOffset[18][4]+screen_objHeight[18][4]&&vCount>=screen_vStartPos[18][4]+v+screen_vOffset[18][4]) Sel<=screen_color[18][4]; 
    else if(screen_visible[19][4]==1&&hCount<=screen_hStartPos[19][4]+h+screen_hOffset[19][4]+screen_objWidth[19][4]&&hCount>=screen_hStartPos[19][4]+h+screen_hOffset[19][4]&&vCount<=screen_vStartPos[19][4]+v+screen_vOffset[19][4]+screen_objHeight[19][4]&&vCount>=screen_vStartPos[19][4]+v+screen_vOffset[19][4]) Sel<=screen_color[19][4]; 
    else if(screen_visible[20][4]==1&&hCount<=screen_hStartPos[20][4]+h+screen_hOffset[20][4]+screen_objWidth[20][4]&&hCount>=screen_hStartPos[20][4]+h+screen_hOffset[20][4]&&vCount<=screen_vStartPos[20][4]+v+screen_vOffset[20][4]+screen_objHeight[20][4]&&vCount>=screen_vStartPos[20][4]+v+screen_vOffset[20][4]) Sel<=screen_color[20][4]; 
    else if(screen_visible[21][4]==1&&hCount<=screen_hStartPos[21][4]+h+screen_hOffset[21][4]+screen_objWidth[21][4]&&hCount>=screen_hStartPos[21][4]+h+screen_hOffset[21][4]&&vCount<=screen_vStartPos[21][4]+v+screen_vOffset[21][4]+screen_objHeight[21][4]&&vCount>=screen_vStartPos[21][4]+v+screen_vOffset[21][4]) Sel<=screen_color[21][4]; 
    else if(screen_visible[22][4]==1&&hCount<=screen_hStartPos[22][4]+h+screen_hOffset[22][4]+screen_objWidth[22][4]&&hCount>=screen_hStartPos[22][4]+h+screen_hOffset[22][4]&&vCount<=screen_vStartPos[22][4]+v+screen_vOffset[22][4]+screen_objHeight[22][4]&&vCount>=screen_vStartPos[22][4]+v+screen_vOffset[22][4]) Sel<=screen_color[22][4]; 
    else if(screen_visible[23][4]==1&&hCount<=screen_hStartPos[23][4]+h+screen_hOffset[23][4]+screen_objWidth[23][4]&&hCount>=screen_hStartPos[23][4]+h+screen_hOffset[23][4]&&vCount<=screen_vStartPos[23][4]+v+screen_vOffset[23][4]+screen_objHeight[23][4]&&vCount>=screen_vStartPos[23][4]+v+screen_vOffset[23][4]) Sel<=screen_color[23][4]; 
// SCREEN 5                
    else if(screen_visible[0 ][5]==1&&hCount<=screen_hStartPos[0 ][5]+h+screen_hOffset[0 ][5]+screen_objWidth[0 ][5]&&hCount>=screen_hStartPos[0 ][5]+h+screen_hOffset[0 ][5]&&vCount<=screen_vStartPos[0 ][5]+v+screen_vOffset[0 ][5]+screen_objHeight[0 ][5]&&vCount>=screen_vStartPos[0 ][5]+v+screen_vOffset[0 ][5]) Sel<=screen_color[0 ][5]; 
    else if(screen_visible[1 ][5]==1&&hCount<=screen_hStartPos[1 ][5]+h+screen_hOffset[1 ][5]+screen_objWidth[1 ][5]&&hCount>=screen_hStartPos[1 ][5]+h+screen_hOffset[1 ][5]&&vCount<=screen_vStartPos[1 ][5]+v+screen_vOffset[1 ][5]+screen_objHeight[1 ][5]&&vCount>=screen_vStartPos[1 ][5]+v+screen_vOffset[1 ][5]) Sel<=screen_color[1 ][5]; 
    else if(screen_visible[2 ][5]==1&&hCount<=screen_hStartPos[2 ][5]+h+screen_hOffset[2 ][5]+screen_objWidth[2 ][5]&&hCount>=screen_hStartPos[2 ][5]+h+screen_hOffset[2 ][5]&&vCount<=screen_vStartPos[2 ][5]+v+screen_vOffset[2 ][5]+screen_objHeight[2 ][5]&&vCount>=screen_vStartPos[2 ][5]+v+screen_vOffset[2 ][5]) Sel<=screen_color[2 ][5]; 
    else if(screen_visible[3 ][5]==1&&hCount<=screen_hStartPos[3 ][5]+h+screen_hOffset[3 ][5]+screen_objWidth[3 ][5]&&hCount>=screen_hStartPos[3 ][5]+h+screen_hOffset[3 ][5]&&vCount<=screen_vStartPos[3 ][5]+v+screen_vOffset[3 ][5]+screen_objHeight[3 ][5]&&vCount>=screen_vStartPos[3 ][5]+v+screen_vOffset[3 ][5]) Sel<=screen_color[3 ][5]; 
    else if(screen_visible[4 ][5]==1&&hCount<=screen_hStartPos[4 ][5]+h+screen_hOffset[4 ][5]+screen_objWidth[4 ][5]&&hCount>=screen_hStartPos[4 ][5]+h+screen_hOffset[4 ][5]&&vCount<=screen_vStartPos[4 ][5]+v+screen_vOffset[4 ][5]+screen_objHeight[4 ][5]&&vCount>=screen_vStartPos[4 ][5]+v+screen_vOffset[4 ][5]) Sel<=screen_color[4 ][5]; 
    else if(screen_visible[5 ][5]==1&&hCount<=screen_hStartPos[5 ][5]+h+screen_hOffset[5 ][5]+screen_objWidth[5 ][5]&&hCount>=screen_hStartPos[5 ][5]+h+screen_hOffset[5 ][5]&&vCount<=screen_vStartPos[5 ][5]+v+screen_vOffset[5 ][5]+screen_objHeight[5 ][5]&&vCount>=screen_vStartPos[5 ][5]+v+screen_vOffset[5 ][5]) Sel<=screen_color[5 ][5]; 
    else if(screen_visible[6 ][5]==1&&hCount<=screen_hStartPos[6 ][5]+h+screen_hOffset[6 ][5]+screen_objWidth[6 ][5]&&hCount>=screen_hStartPos[6 ][5]+h+screen_hOffset[6 ][5]&&vCount<=screen_vStartPos[6 ][5]+v+screen_vOffset[6 ][5]+screen_objHeight[6 ][5]&&vCount>=screen_vStartPos[6 ][5]+v+screen_vOffset[6 ][5]) Sel<=screen_color[6 ][5]; 
    else if(screen_visible[7 ][5]==1&&hCount<=screen_hStartPos[7 ][5]+h+screen_hOffset[7 ][5]+screen_objWidth[7 ][5]&&hCount>=screen_hStartPos[7 ][5]+h+screen_hOffset[7 ][5]&&vCount<=screen_vStartPos[7 ][5]+v+screen_vOffset[7 ][5]+screen_objHeight[7 ][5]&&vCount>=screen_vStartPos[7 ][5]+v+screen_vOffset[7 ][5]) Sel<=screen_color[7 ][5]; 
    else if(screen_visible[8 ][5]==1&&hCount<=screen_hStartPos[8 ][5]+h+screen_hOffset[8 ][5]+screen_objWidth[8 ][5]&&hCount>=screen_hStartPos[8 ][5]+h+screen_hOffset[8 ][5]&&vCount<=screen_vStartPos[8 ][5]+v+screen_vOffset[8 ][5]+screen_objHeight[8 ][5]&&vCount>=screen_vStartPos[8 ][5]+v+screen_vOffset[8 ][5]) Sel<=screen_color[8 ][5]; 
    else if(screen_visible[9 ][5]==1&&hCount<=screen_hStartPos[9 ][5]+h+screen_hOffset[9 ][5]+screen_objWidth[9 ][5]&&hCount>=screen_hStartPos[9 ][5]+h+screen_hOffset[9 ][5]&&vCount<=screen_vStartPos[9 ][5]+v+screen_vOffset[9 ][5]+screen_objHeight[9 ][5]&&vCount>=screen_vStartPos[9 ][5]+v+screen_vOffset[9 ][5]) Sel<=screen_color[9 ][5]; 
    else if(screen_visible[10][5]==1&&hCount<=screen_hStartPos[10][5]+h+screen_hOffset[10][5]+screen_objWidth[10][5]&&hCount>=screen_hStartPos[10][5]+h+screen_hOffset[10][5]&&vCount<=screen_vStartPos[10][5]+v+screen_vOffset[10][5]+screen_objHeight[10][5]&&vCount>=screen_vStartPos[10][5]+v+screen_vOffset[10][5]) Sel<=screen_color[10][5]; 
    else if(screen_visible[11][5]==1&&hCount<=screen_hStartPos[11][5]+h+screen_hOffset[11][5]+screen_objWidth[11][5]&&hCount>=screen_hStartPos[11][5]+h+screen_hOffset[11][5]&&vCount<=screen_vStartPos[11][5]+v+screen_vOffset[11][5]+screen_objHeight[11][5]&&vCount>=screen_vStartPos[11][5]+v+screen_vOffset[11][5]) Sel<=screen_color[11][5]; 
    else if(screen_visible[12][5]==1&&hCount<=screen_hStartPos[12][5]+h+screen_hOffset[12][5]+screen_objWidth[12][5]&&hCount>=screen_hStartPos[12][5]+h+screen_hOffset[12][5]&&vCount<=screen_vStartPos[12][5]+v+screen_vOffset[12][5]+screen_objHeight[12][5]&&vCount>=screen_vStartPos[12][5]+v+screen_vOffset[12][5]) Sel<=screen_color[12][5]; 
    else if(screen_visible[13][5]==1&&hCount<=screen_hStartPos[13][5]+h+screen_hOffset[13][5]+screen_objWidth[13][5]&&hCount>=screen_hStartPos[13][5]+h+screen_hOffset[13][5]&&vCount<=screen_vStartPos[13][5]+v+screen_vOffset[13][5]+screen_objHeight[13][5]&&vCount>=screen_vStartPos[13][5]+v+screen_vOffset[13][5]) Sel<=screen_color[13][5]; 
    else if(screen_visible[14][5]==1&&hCount<=screen_hStartPos[14][5]+h+screen_hOffset[14][5]+screen_objWidth[14][5]&&hCount>=screen_hStartPos[14][5]+h+screen_hOffset[14][5]&&vCount<=screen_vStartPos[14][5]+v+screen_vOffset[14][5]+screen_objHeight[14][5]&&vCount>=screen_vStartPos[14][5]+v+screen_vOffset[14][5]) Sel<=screen_color[14][5]; 
    else if(screen_visible[15][5]==1&&hCount<=screen_hStartPos[15][5]+h+screen_hOffset[15][5]+screen_objWidth[15][5]&&hCount>=screen_hStartPos[15][5]+h+screen_hOffset[15][5]&&vCount<=screen_vStartPos[15][5]+v+screen_vOffset[15][5]+screen_objHeight[15][5]&&vCount>=screen_vStartPos[15][5]+v+screen_vOffset[15][5]) Sel<=screen_color[15][5]; 
    else if(screen_visible[16][5]==1&&hCount<=screen_hStartPos[16][5]+h+screen_hOffset[16][5]+screen_objWidth[16][5]&&hCount>=screen_hStartPos[16][5]+h+screen_hOffset[16][5]&&vCount<=screen_vStartPos[16][5]+v+screen_vOffset[16][5]+screen_objHeight[16][5]&&vCount>=screen_vStartPos[16][5]+v+screen_vOffset[16][5]) Sel<=screen_color[16][5]; 
    else if(screen_visible[17][5]==1&&hCount<=screen_hStartPos[17][5]+h+screen_hOffset[17][5]+screen_objWidth[17][5]&&hCount>=screen_hStartPos[17][5]+h+screen_hOffset[17][5]&&vCount<=screen_vStartPos[17][5]+v+screen_vOffset[17][5]+screen_objHeight[17][5]&&vCount>=screen_vStartPos[17][5]+v+screen_vOffset[17][5]) Sel<=screen_color[17][5]; 
    else if(screen_visible[18][5]==1&&hCount<=screen_hStartPos[18][5]+h+screen_hOffset[18][5]+screen_objWidth[18][5]&&hCount>=screen_hStartPos[18][5]+h+screen_hOffset[18][5]&&vCount<=screen_vStartPos[18][5]+v+screen_vOffset[18][5]+screen_objHeight[18][5]&&vCount>=screen_vStartPos[18][5]+v+screen_vOffset[18][5]) Sel<=screen_color[18][5]; 
    else if(screen_visible[19][5]==1&&hCount<=screen_hStartPos[19][5]+h+screen_hOffset[19][5]+screen_objWidth[19][5]&&hCount>=screen_hStartPos[19][5]+h+screen_hOffset[19][5]&&vCount<=screen_vStartPos[19][5]+v+screen_vOffset[19][5]+screen_objHeight[19][5]&&vCount>=screen_vStartPos[19][5]+v+screen_vOffset[19][5]) Sel<=screen_color[19][5]; 
    else if(screen_visible[20][5]==1&&hCount<=screen_hStartPos[20][5]+h+screen_hOffset[20][5]+screen_objWidth[20][5]&&hCount>=screen_hStartPos[20][5]+h+screen_hOffset[20][5]&&vCount<=screen_vStartPos[20][5]+v+screen_vOffset[20][5]+screen_objHeight[20][5]&&vCount>=screen_vStartPos[20][5]+v+screen_vOffset[20][5]) Sel<=screen_color[20][5]; 
    else if(screen_visible[21][5]==1&&hCount<=screen_hStartPos[21][5]+h+screen_hOffset[21][5]+screen_objWidth[21][5]&&hCount>=screen_hStartPos[21][5]+h+screen_hOffset[21][5]&&vCount<=screen_vStartPos[21][5]+v+screen_vOffset[21][5]+screen_objHeight[21][5]&&vCount>=screen_vStartPos[21][5]+v+screen_vOffset[21][5]) Sel<=screen_color[21][5]; 
    else if(screen_visible[22][5]==1&&hCount<=screen_hStartPos[22][5]+h+screen_hOffset[22][5]+screen_objWidth[22][5]&&hCount>=screen_hStartPos[22][5]+h+screen_hOffset[22][5]&&vCount<=screen_vStartPos[22][5]+v+screen_vOffset[22][5]+screen_objHeight[22][5]&&vCount>=screen_vStartPos[22][5]+v+screen_vOffset[22][5]) Sel<=screen_color[22][5]; 
    else if(screen_visible[23][5]==1&&hCount<=screen_hStartPos[23][5]+h+screen_hOffset[23][5]+screen_objWidth[23][5]&&hCount>=screen_hStartPos[23][5]+h+screen_hOffset[23][5]&&vCount<=screen_vStartPos[23][5]+v+screen_vOffset[23][5]+screen_objHeight[23][5]&&vCount>=screen_vStartPos[23][5]+v+screen_vOffset[23][5]) Sel<=screen_color[23][5]; 

//======================================================================================                    
//SROLLS
//=======================================================================================                    
//Scroll 0
                                //object 1 
                        else if(scroll_visible[0][0]==1&&hCount<=hStartPos[0][0]+h+hOffset[0][0]+objWidth[0][0]&&hCount>=hStartPos[0][0]+h+hOffset[0][0]&&vCount<=vStartPos[0][0]+v+vOffset[0][0]+objHeight[0][0]&&vCount>=vStartPos[0][0]+v+vOffset[0][0])
                         begin
                                Sel<=scroll_color[0][0]; 
                        end 
                        //object 2
                        else if(scroll_visible[1][0]==1&&hCount<=hStartPos[1][0]+h+hOffset[1][0]+objWidth[1][0]&&hCount>=hStartPos[1][0]+h+hOffset[1][0]&&vCount<=vStartPos[1][0]+v+vOffset[1][0]+objHeight[1][0]&&vCount>=vStartPos[1][0]+v+vOffset[1][0])
                            begin
                                Sel<=scroll_color[1][0]; 
                            end 
                    //        //object 3
                        else if(scroll_visible[2][0]==1&&hCount<=hStartPos[2][0]+h+hOffset[2][0]+objWidth[2][0]&&hCount>=hStartPos[2][0]+h+hOffset[2][0]&&vCount<=vStartPos[2][0]+v+vOffset[2][0]+objHeight[2][0]&&vCount>=vStartPos[2][0]+v+vOffset[2][0])
                            begin
                                Sel<=scroll_color[2][0]; 
                            end 
                    //        //object 4
                        else if(scroll_visible[3][0]==1&&hCount<=hStartPos[3][0]+h+hOffset[3][0]+objWidth[3][0]&&hCount>=hStartPos[3][0]+h+hOffset[3][0]&&vCount<=vStartPos[3][0]+v+vOffset[3][0]+objHeight[3][0]&&vCount>=vStartPos[3][0]+v+vOffset[3][0])
                            begin
                                Sel<=scroll_color[3][0]; 
                            end 
                    
                    
                    
                    
                    
                    
                    //SCROLL1
                        else if(scroll_visible[0][1]==1&&hCount<=hStartPos[0][1]+h+hOffset[0][1]+objWidth[0][1]&&hCount>=hStartPos[0][1]+h+hOffset[0][1]&&vCount<=vStartPos[0][1]+v+vOffset[0][1]+objHeight[0][1]&&vCount>=vStartPos[0][1]+v+vOffset[0][1])
                         begin
                                Sel<=scroll_color[0][1]; 
                        end 
                        //object 2
                        else if(scroll_visible[1][1]==1&&hCount<=hStartPos[1][1]+h+hOffset[1][1]+objWidth[1][1]&&hCount>=hStartPos[1][1]+h+hOffset[1][1]&&vCount<=vStartPos[1][1]+v+vOffset[1][1]+objHeight[1][1]&&vCount>=vStartPos[1][1]+v+vOffset[1][1])
                            begin
                                Sel<=scroll_color[1][1]; 
                            end 
                    //        //object 3
                        else if(scroll_visible[2][1]==1&&hCount<=hStartPos[2][1]+h+hOffset[2][1]+objWidth[2][1]&&hCount>=hStartPos[2][1]+h+hOffset[2][1]&&vCount<=vStartPos[2][1]+v+vOffset[2][1]+objHeight[2][1]&&vCount>=vStartPos[2][1]+v+vOffset[2][1])
                            begin
                                Sel<=scroll_color[2][1]; 
                            end 
                    //        //object 4
                        else if(scroll_visible[3][1]==1&&hCount<=hStartPos[3][1]+h+hOffset[3][1]+objWidth[3][1]&&hCount>=hStartPos[3][1]+h+hOffset[3][1]&&vCount<=vStartPos[3][1]+v+vOffset[3][1]+objHeight[3][1]&&vCount>=vStartPos[3][1]+v+vOffset[3][1])
                            begin
                                Sel<=scroll_color[3][1]; 
                            end 
                    
                    
                    
                    
                    
                    
                    //SCROLL 2
                        else if(scroll_visible[0][2]==1&&hCount<=hStartPos[0][2]+h+hOffset[0][2]+objWidth[0][2]&&hCount>=hStartPos[0][2]+h+hOffset[0][2]&&vCount<=vStartPos[0][2]+v+vOffset[0][2]+objHeight[0][2]&&vCount>=vStartPos[0][2]+v+vOffset[0][2])
                         begin
                                Sel<=scroll_color[0][2]; 
                        end 
                        //object 2
                        else if(scroll_visible[1][2]==1&&hCount<=hStartPos[1][2]+h+hOffset[1][2]+objWidth[1][2]&&hCount>=hStartPos[1][2]+h+hOffset[1][2]&&vCount<=vStartPos[1][2]+v+vOffset[1][2]+objHeight[1][2]&&vCount>=vStartPos[1][2]+v+vOffset[1][2])
                            begin
                                Sel<=scroll_color[1][2]; 
                            end 
                    //        //object 3
                        else if(scroll_visible[2][2]==1&&hCount<=hStartPos[2][2]+h+hOffset[2][2]+objWidth[2][2]&&hCount>=hStartPos[2][2]+h+hOffset[2][2]&&vCount<=vStartPos[2][2]+v+vOffset[2][2]+objHeight[2][2]&&vCount>=vStartPos[2][2]+v+vOffset[2][2])
                            begin
                                Sel<=scroll_color[2][2]; 
                            end 
                    //        //object 4
                        else if(scroll_visible[3][2]==1&&hCount<=hStartPos[3][2]+h+hOffset[3][2]+objWidth[3][2]&&hCount>=hStartPos[3][2]+h+hOffset[3][2]&&vCount<=vStartPos[3][2]+v+vOffset[3][2]+objHeight[3][2]&&vCount>=vStartPos[3][2]+v+vOffset[3][2])
                            begin
                                Sel<=scroll_color[3][2]; 
                            end 
                    
                    // SCROLL 3
                        else if(scroll_visible[0][3]==1&&hCount<=hStartPos[0][3]+h+hOffset[0][3]+objWidth[0][3]&&hCount>=hStartPos[0][3]+h+hOffset[0][3]&&vCount<=vStartPos[0][3]+v+vOffset[0][3]+objHeight[0][3]&&vCount>=vStartPos[0][3]+v+vOffset[0][3])
                         begin
                                Sel<=scroll_color[0][3]; 
                        end 
                        //object 2
                        else if(scroll_visible[1][3]==1&&hCount<=hStartPos[1][3]+h+hOffset[1][3]+objWidth[1][3]&&hCount>=hStartPos[1][3]+h+hOffset[1][3]&&vCount<=vStartPos[1][3]+v+vOffset[1][3]+objHeight[1][3]&&vCount>=vStartPos[1][3]+v+vOffset[1][3])
                            begin
                                Sel<=scroll_color[1][3]; 
                            end 
                    //        //object 3
                        else if(scroll_visible[2][3]==1&&hCount<=hStartPos[2][3]+h+hOffset[2][3]+objWidth[2][3]&&hCount>=hStartPos[2][3]+h+hOffset[2][3]&&vCount<=vStartPos[2][3]+v+vOffset[2][3]+objHeight[2][3]&&vCount>=vStartPos[2][3]+v+vOffset[2][3])
                            begin
                                Sel<=scroll_color[2][3]; 
                            end 
                    //        //object 4
                        else if(scroll_visible[3][3]==1&&hCount<=hStartPos[3][3]+h+hOffset[3][3]+objWidth[3][3]&&hCount>=hStartPos[3][3]+h+hOffset[3][3]&&vCount<=vStartPos[3][3]+v+vOffset[3][3]+objHeight[3][3]&&vCount>=vStartPos[3][3]+v+vOffset[3][3])
                            begin
                                Sel<=scroll_color[3][3]; 
                            end 
                            
                    // SCROLL 4
                                    else if(scroll_visible[0][4]==1&&hCount<=hStartPos[0][4]+h+hOffset[0][4]+objWidth[0][4]&&hCount>=hStartPos[0][4]+h+hOffset[0][4]&&vCount<=vStartPos[0][4]+v+vOffset[0][4]+objHeight[0][4]&&vCount>=vStartPos[0][4]+v+vOffset[0][4])
                                     begin
                                Sel<=scroll_color[0][4]; 
                                    end 
                                    //object 2
                                    else if(scroll_visible[1][4]==1&&hCount<=hStartPos[1][4]+h+hOffset[1][4]+objWidth[1][4]&&hCount>=hStartPos[1][4]+h+hOffset[1][4]&&vCount<=vStartPos[1][4]+v+vOffset[1][4]+objHeight[1][4]&&vCount>=vStartPos[1][4]+v+vOffset[1][4])
                                        begin
                                Sel<=scroll_color[1][4]; 
                                        end 
                            //        //object 3
                                    else if(scroll_visible[2][4]==1&&hCount<=hStartPos[2][4]+h+hOffset[2][4]+objWidth[2][4]&&hCount>=hStartPos[2][4]+h+hOffset[2][4]&&vCount<=vStartPos[2][4]+v+vOffset[2][4]+objHeight[2][4]&&vCount>=vStartPos[2][4]+v+vOffset[2][4])
                                        begin
                                Sel<=scroll_color[2][4]; 
                                        end 
                            //        //object 4
                                    else if(scroll_visible[3][4]==1&&hCount<=hStartPos[3][4]+h+hOffset[3][4]+objWidth[3][4]&&hCount>=hStartPos[3][4]+h+hOffset[3][4]&&vCount<=vStartPos[3][4]+v+vOffset[3][4]+objHeight[3][4]&&vCount>=vStartPos[3][4]+v+vOffset[3][4])
                                        begin
                                Sel<=scroll_color[3][4]; 
                                        end 
                    // SCROLL 5
                                    else if(scroll_visible[0][5]==1&&hCount<=hStartPos[0][5]+h+hOffset[0][5]+objWidth[0][5]&&hCount>=hStartPos[0][5]+h+hOffset[0][5]&&vCount<=vStartPos[0][5]+v+vOffset[0][5]+objHeight[0][5]&&vCount>=vStartPos[0][5]+v+vOffset[0][5])
                                     begin
                                        Sel<=scroll_color[0][5]; 
                                    end 
                                    //object 2
                                    else if(scroll_visible[1][5]==1&&hCount<=hStartPos[1][5]+h+hOffset[1][5]+objWidth[1][5]&&hCount>=hStartPos[1][5]+h+hOffset[1][5]&&vCount<=vStartPos[1][5]+v+vOffset[1][5]+objHeight[1][5]&&vCount>=vStartPos[1][5]+v+vOffset[1][5])
                                        begin
                                        Sel<=scroll_color[1][5]; 
                                        end 
                            //        //object 3
                                    else if(scroll_visible[2][5]==1&&hCount<=hStartPos[2][5]+h+hOffset[2][5]+objWidth[2][5]&&hCount>=hStartPos[2][5]+h+hOffset[2][5]&&vCount<=vStartPos[2][5]+v+vOffset[2][5]+objHeight[2][5]&&vCount>=vStartPos[2][5]+v+vOffset[2][5])
                                        begin
                                        Sel<=scroll_color[2][5]; 
                                        end 
                            //        //object 4
                                    else if(scroll_visible[3][5]==1&&hCount<=hStartPos[3][5]+h+hOffset[3][5]+objWidth[3][5]&&hCount>=hStartPos[3][5]+h+hOffset[3][5]&&vCount<=vStartPos[3][5]+v+vOffset[3][5]+objHeight[3][5]&&vCount>=vStartPos[3][5]+v+vOffset[3][5])
                                        begin
                                        Sel<=scroll_color[3][5]; 
                                        end 


   else
    begin
        Sel<=0;
    end
    
end
endmodule
