module booth_mul(
    input clk,
    input rst,
    input start,
    input [7:0] M,   // Multiplicand
    input [7:0] Q_in, // Multiplier
    output reg [15:0] product,
    output reg done
);
    reg [7:0] A, Q;
    reg Q_1;
    reg [3:0] count;
    reg busy;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A <= 0; Q <= 0; Q_1 <= 0;
            count <= 0; done <= 0; product <= 0; busy <= 0;
        end else if (start && !busy) begin
            A <= 0;
            Q <= Q_in;
            Q_1 <= 0;
            count <= 8;
            busy <= 1;
            done <= 0;
        end else if (busy && count > 0) begin
            case ({Q[0], Q_1})
                2'b01: {A, Q, Q_1} <= $signed({A + M, Q, Q_1}) >>> 1;
                2'b10: {A, Q, Q_1} <= $signed({A - M, Q, Q_1}) >>> 1;
                default: {A, Q, Q_1} <= $signed({A, Q, Q_1}) >>> 1;
            endcase
            count <= count - 1;
        end else if (busy && count == 0) begin
            product <= {A, Q};
            done <= 1;
            busy <= 0;
        end else begin
            done <= 0; // Pulse done for one cycle
        end
    end
endmodule