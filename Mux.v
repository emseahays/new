`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 10:26:40 AM
// Design Name: 
// Module Name: Mux
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


module Mux(
    input [2:0] Sel, // 3 bits for crosshairs and 4 quadrants
    input [2:0] In, //cross hair color selection
    input [3:0] dimCounter, //0-16 brightness levels
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
    );

    always@( dimCounter, Sel)
    begin
        //Cross Hairs
        if(Sel==1) 
        begin
            case(In)
                3'b000: //black
                begin
                    vgaRed<=4'b1111;
                    vgaGreen<=4'b1111;
                    vgaBlue<=4'b1111;                     
                end
                3'b001: //Green
                begin
                    vgaRed<=0;
                    vgaGreen<=dimCounter;
                    vgaBlue<=0;    
                end
                3'b010: //Blue
                begin
                    vgaRed<=0;
                    vgaGreen<=0;
                    vgaBlue<=dimCounter;        
                end
                3'b011: //Cyan
                begin
                    vgaRed<=0;
                    vgaGreen<=dimCounter;
                    vgaBlue<=dimCounter;                  
                end  
                3'b100: //Red
                begin
                    vgaRed<=dimCounter;
                    vgaGreen<=0;
                    vgaBlue<=0;   
                end
                3'b101: //Magenta
                begin
                    vgaRed<=dimCounter;
                    vgaGreen<=0;
                    vgaBlue<=dimCounter;   
                end
                3'b110: //Yellow
                begin
                    vgaRed<=dimCounter;
                    vgaGreen<=dimCounter;
                    vgaBlue<=0;    
                end                
                3'b111: //White
                begin
                    vgaRed<=dimCounter;
                    vgaGreen<=dimCounter;
                    vgaBlue<=dimCounter;   
                end                                                                
            endcase
        end
        //first block - red
        else if(Sel==2) 
        begin
            vgaRed<=dimCounter;
            vgaGreen<=0;
            vgaBlue<=0;   
        end
        //2nd block - cyan
        else if(Sel==3)
        begin
            vgaRed<=0;
            vgaGreen<=dimCounter;
            vgaBlue<=dimCounter;   
        end
        //3rd block -- yellow
        else if(Sel==4)
        begin
            vgaRed<=dimCounter;
            vgaGreen<=dimCounter;
            vgaBlue<=0;   
        end
        //4th block -- magenta
        else if(Sel==5)
        begin
            vgaRed<=dimCounter;
            vgaGreen<=0;
            vgaBlue<=dimCounter;   
        end
        //boarder/wall -- white
        else if(Sel==6)
        begin
            vgaRed<=dimCounter;
            vgaGreen<=dimCounter;
            vgaBlue<=dimCounter;   
        end
        else
        begin
            //Default to black pixels
            vgaRed<=4'b0000;
            vgaGreen<=4'b0000;
            vgaBlue<=4'b0000;
        end

    end
endmodule
