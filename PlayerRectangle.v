`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 10:37:58 PM
// Design Name: 
// Module Name: PlayerRectangle
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


module PlayerRectangle(
    input upEnable,
input downEnable,
input leftEnable,
input rightEnable,

input rst,
input btnClk,
input   [3:0] btns,
input   [3:0] color,
input  [10:0] vStartPos,
input  [10:0] hStartPos,
input  [10:0] objWidth,
input  [10:0] objHeight,
output  [10:0] vStartPos_o,
output  [10:0] hStartPos_o,
output  [10:0] objWidth_o,
output  [10:0] objHeight_o,
output reg [10:0] vOffset,
output reg [10:0] hOffset,
output reg [10:0] hPos,
output reg [10:0] vPos,
output [3:0] color_o
//output reg [2:0] status       //blocked, alive, dead, moving

);
assign color_o= color;

assign vStartPos_o=vStartPos;
assign hStartPos_o=hStartPos;
assign objWidth_o=objWidth;
assign objHeight_o=objHeight;

//update objects location

always@(posedge btnClk, posedge rst)
begin

if(rst==1)
begin
    vOffset<=0;
    hOffset<=0;
    
end
else begin
    case(btns)
    8: //btnU
        begin 
            if(upEnable==1) begin
            if(vOffset+vStartPos>0) vOffset<=vOffset-12;
            else vOffset<=480-objHeight-vStartPos;
            end
        end
    4://btnD
        begin
            if(downEnable==1) begin
            if(!(upEnable==1&&vOffset+vStartPos>=480)) vOffset<=vOffset+12;
            else vOffset<=0-vStartPos;
            end
        end
    2://btnR
        begin 
            if(rightEnable==1) begin
            if(!(hStartPos>=640-objWidth-hOffset)) hOffset<=hOffset+12;
            else  hOffset<=0-hStartPos;
            end
        end
    1://btnL
        begin 
            if(leftEnable==1) begin
            if(hStartPos+hOffset>0)  hOffset<=hOffset-12;
            else hOffset<=640-objWidth-hStartPos;
            end
        end
    default: //else do nothing
        begin 

        end
    endcase
    hPos<=hStartPos+hOffset;
    vPos<=vStartPos+vOffset;    
    end

end


endmodule