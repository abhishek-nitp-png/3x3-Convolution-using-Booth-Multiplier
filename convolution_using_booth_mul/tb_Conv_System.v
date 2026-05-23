module tb_Conv_System;
 reg clk; reg rst;
 reg start; 
reg i_comp;
 reg [7:0] weight_in;
 reg [7:0] pixel_in; 
wire [16:0] final_result;
 wire done_all;
 reg [7:0] weight_rom [0:8];
 reg [7:0] image_rom [0:8];
 integer i;
 Conv_Controller uut ( .clk(clk),
                       .rst(rst),
                       .start(start), 
                       .i_comp(i_comp),
                       .weight_in(weight_in),
                       .pixel_in(pixel_in), 
                       .final_result(final_result),
                       .done_all(done_all) ); 
 always #5 clk = ~clk;

// Task to send inputs
task send_data;
    input [7:0] weight_val;
    input [7:0] pixel_val;
begin
    @(posedge clk);
    weight_in = weight_val;
    pixel_in  = pixel_val;

    repeat(9) @(posedge clk);
end
endtask


initial begin
    clk = 0;
    rst = 1;
    start = 0;
    i_comp = 0;
    weight_in = 0;
    pixel_in = 0;

    // Sobel-like filter
    weight_rom[0] = 8'd2;  weight_rom[1] = 8'd3;  weight_rom[2] = 8'd1;
    weight_rom[3] = 8'd0;  weight_rom[4] = 8'd0;  weight_rom[5] = 8'd0;
    weight_rom[6] = 8'd2;
    weight_rom[7] = 8'd5;
    weight_rom[8] = -8'd2;

    for(i=0;i<9;i=i+1)
        image_rom[i] = 8'd10;

    #20 rst = 0;

    #10 start = 1;
    #10 start = 0;

    for(i=0; i<9; i=i+1) begin
        // 1. Set the data
       send_data( weight_rom[i], image_rom[i]);
    end

    // Now that the loop is done, the 9th pixel is processed.
    wait(uut.state==3'b100);
    
    
    #20 i_comp = 1;

    
    wait(done_all==1);
    #5;
    $display("Convolution Result: %d", $signed(final_result));
    $display("Done = %d",done_all);
    $display("Verification Finished.");

    #100 $finish;
end
endmodule