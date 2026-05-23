`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 19:45:12
// Design Name: 
// Module Name: CLA_4bit
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


module CLA_4bit(
input  [3:0] a,
input  [3:0] b,
input  cin,
output [3:0] sum,
output cout
);

wire [3:1] c;

wire [3:0] p;  // propagate
wire [3:0] g;  // generate

assign p = a ^ b;
assign g = a & b;

// Carry equations
assign c[1] = g[0] | (p[0] & cin);

assign c[2] = g[1] | (p[1] & g[0]) 
                    | (p[1] & p[0] & cin);

assign c[3] = g[2] | (p[2] & g[1]) 
                    | (p[2] & p[1] & g[0]) 
                    | (p[2] & p[1] & p[0] & cin);

assign cout = g[3] | (p[3] & g[2]) 
                     | (p[3] & p[2] & g[1]) 
                     | (p[3] & p[2] & p[1] & g[0]) 
                     | (p[3] & p[2] & p[1] & p[0] & cin);

// Sum equations
assign sum[0] = p[0] ^ cin;
assign sum[1] = p[1] ^ c[1];
assign sum[2] = p[2] ^ c[2];
assign sum[3] = p[3] ^ c[3];

endmodule