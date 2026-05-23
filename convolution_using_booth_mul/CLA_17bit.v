module CLA_17bit(
    input [16:0] A, B,
    output [16:0] sum
);
    wire [4:1] c;
    CLA_4bit A1(A[3:0],   B[3:0],   1'b0, sum[3:0],   c[1]);
    CLA_4bit A2(A[7:4],   B[7:4],   c[1], sum[7:4],   c[2]);
    CLA_4bit A3(A[11:8],  B[11:8],  c[2], sum[11:8],  c[3]);
    CLA_4bit A4(A[15:12], B[15:12], c[3], sum[15:12], c[4]);
    
    // Final bit with carry-in from bit 15
    assign sum[16] = A[16] ^ B[16] ^ c[4];
endmodule