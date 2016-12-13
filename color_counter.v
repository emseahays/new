`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2016 05:31:51 PM
// Design Name: 
// Module Name: color_counter
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


module color_counter(
    input clk,
    input rst,
    input countinue_btn,
    output reg [3:0] color //2=red, 3==cyan, 4=yellow, 5=magenta
    );
    always @ (posedge clk, posedge rst) begin
        if(rst==1)begin
        color<=2; //red
        end
//        else if(countinue_btn==1)begin //if continue_btn is pressed, it will advance the color
////            if(color<=1) color<=2;
////            else if(color==2) color<=3;
////            else if(color==3) color<=4;
////            else if(color==4) color<=5;
////            else if(color>=5) color<=2;
//            if(color>=0&&color<=1) color<=2;
//            else if(color>=2&&color<5) color<=color+1;
//            else if(color>=5) color<=2;
//        end
        else begin
            if(color>=0&&color<=1) color<=2;
            else if(color>=2&&color<5) color<=color+1;
            else if(color>=5) color<=2;
        end
    end
    
endmodule
