`timescale 1ns / 1ps

module tb_memory2D;

    // Signals
    reg clk;
    reg reset;
    reg wrt_read;          // 0 = write, 1 = read
    reg [2:0] row_addr;
    reg [2:0] col_addr;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // Instantiate DUT (Device Under Test)
    memory2D uut (
        .clk(clk),
        .reset(reset),
        .wrt_read(wrt_read),
        .row_addr(row_addr),
        .col_addr(col_addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation (10ns period = 100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Init
        clk = 0;
        reset = 1;
        wrt_read = 0;
        row_addr = 0;
        col_addr = 0;
        data_in  = 0;

        // Apply reset
        #10 reset = 0;

        // --- WRITE PHASE ---
        $display("=== WRITE PHASE ===");
        wrt_read = 0;

        row_addr = 3'b001; col_addr = 3'b010; data_in = 8'hAA; #10;  // write 0xAA
        row_addr = 3'b100; col_addr = 3'b101; data_in = 8'h55; #10;  // write 0x55
        row_addr = 3'b111; col_addr = 3'b000; data_in = 8'hF0; #10;  // write 0xF0

        // --- READ PHASE ---
        $display("=== READ PHASE ===");
        wrt_read = 1;

        row_addr = 3'b001; col_addr = 3'b010; #10;
        $display("Read (1,2) = %h (expected AA)", data_out);

        row_addr = 3'b100; col_addr = 3'b101; #10;
        $display("Read (4,5) = %h (expected 55)", data_out);

        row_addr = 3'b111; col_addr = 3'b000; #10;
        $display("Read (7,0) = %h (expected F0)", data_out);

        // --- CHECK OUTPUT DURING WRITE ---
        $display("=== OUTPUT DURING WRITE ===");
        wrt_read = 0;
        row_addr = 3'b010; col_addr = 3'b011; data_in = 8'h77; #10;
        $display("During write, data_out = %h (expected 00)", data_out);

        $finish;
    end

endmodule