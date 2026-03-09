module memory2D (
    input  wire        clk,
    input  wire        reset,
    input  wire        wrt_read,    // 0 = write, 1 = read
    input  wire [2:0]  row_addr,    // Row index (0-7)
    input  wire [2:0]  col_addr,    // Column index (0-7)
    input  wire [7:0]  data_in,     // 8-bit input
    output reg  [7:0]  data_out     // 8-bit output
);

    // 2D memory: 8x8 cells, each cell is 8 bits
    reg [7:0] mem [0:7][0:7];

    integer i, j;

    always @(posedge clk) begin
        if (reset) begin
            data_out <= 8'b00000000;
            // Optional: clear memory
            for (i=0; i<8; i=i+1)
                for (j=0; j<8; j=j+1)
                    mem[i][j] <= 8'b00000000;
        end else begin
            if (wrt_read == 1'b0) begin
                // Write mode
                mem[row_addr][col_addr] <= data_in;
                data_out <= 8'b00000000;   // not reading
            end else begin
                // Read mode
                data_out <= mem[row_addr][col_addr];
            end
        end
    end

endmodule