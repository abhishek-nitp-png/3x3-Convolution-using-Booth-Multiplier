module MAC_8bit(
    input [7:0] A, B,
    input clk, rst,
    input load_new_data, // NEW INPUT from Controller
    output reg [16:0] Acc
);
    wire booth_done;
    reg start_mul;
    wire [15:0] product;
    wire [16:0] sum_out;
    reg done_delayed;
    wire[15:0] r1;
    booth_mul Mul (clk, rst, start_mul, A, B, product, booth_done);
    register R1(product,clk,rst,r1);

    // Structural Adder instance
    CLA_17bit A1 (
        .A(Acc), 
        .B({{1{r1[15]}}, r1}), // Proper sign extension
        .sum(sum_out)
    );

always @(posedge clk or posedge rst) begin
        if (rst) begin
            Acc <= 0;
            start_mul <= 0;
            done_delayed <= 0;
        end else begin
            done_delayed <= booth_done; 
            
            if (load_new_data) begin
                start_mul <= 1;   // Start the Booth Multiplier
            end else if (booth_done) begin
                start_mul <= 0;   // Stop once finished
            end

            if (done_delayed) begin
                Acc <= sum_out;   // Accumulate the result
            end
        end
    end
endmodule