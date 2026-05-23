`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 19:47:21
// Design Name: 
// Module Name: register
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


module register(
input[15:0] A,
input clk,rst,
output reg[15:0] out 
    );
    always@(posedge clk or posedge rst)begin
    if(rst)begin
    out<=0;
    end
    else
    out<=A;
    end
endmodule
