module Conv_Controller(
    input clk, rst,
    input start, i_comp,
    input [7:0] weight_in, 
    input [7:0] pixel_in,
    output reg [16:0] final_result,
    output reg done_all
);

    parameter IDLE = 0, FETCH = 1, WAIT_MAC = 2,HOLD = 3, FINISH = 4;
    reg [2:0] state;
    reg [3:0] count; 

    reg mac_rst;
    wire [16:0] current_acc;
    wire mac_load = (state == FETCH); // Logic signal to trigger MAC

    MAC_8bit your_mac (
        .A(weight_in), 
        .B(pixel_in), 
        .clk(clk), 
        .rst(mac_rst),
        .load_new_data(mac_load), // Connect the trigger here
        .Acc(current_acc)
    );
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            count <= 0;
            mac_rst <= 1;
            done_all <= 0;
            final_result <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done_all <= 0;
                    if (start) begin
                        state <= FETCH;
                        count <= 0;
                        mac_rst <= 0; 
                    end else begin
                        mac_rst <= 1; 
                    end
                end

                FETCH: begin
                    state <= WAIT_MAC;
                end

WAIT_MAC: begin
                    // Wait until the MAC says it is actually done with the math
                    if (uut.your_mac.booth_done) begin 
                        if (count < 8) begin
                            count <= count + 1;
                            state <= FETCH;
                        end else begin
                            state <= HOLD;
                        end
                    end else begin
                        state <= WAIT_MAC; // Stay here until booth_done is high
                    end
                end

                    HOLD: begin
                    state <= FINISH;     // MAC accumulator now updated
                          end
                FINISH: begin
                    if(i_comp) begin
                        final_result <= current_acc;
                        done_all <= 1;
                        state <= IDLE; // Return to IDLE after finishing
                    end
                    // If i_comp isn't ready, we stay in FINISH to hold current_acc
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule