`default_nettype none
module r2r_dac_control (
    input wire clk,                 // expect a 10M clock
    input wire n_rst,
    input wire ext_data,            // if this is high, then DAC data comes from ui_in[7:0]
    input wire [7:0] data,          // connect to ui_in[7:0]
    input wire load_divider,        // load value set on data to the clock divider
    output wire cnt_zero,
    output reg [7:0] r2r_out        // 8 bit out to the R2R DAC
    );

    reg rst;
    reg [7:0] divider;
    reg [7:0] sample;

    initial begin
        $dumpfile ("r2r_dac_control.vcd");
        $dumpvars (0, r2r_dac_control);
    end

    // sine wave
    sine_lookup sine_lookup(
        .clk(clk),
        .rst(rst),
        .divider({4'b0000, divider}), // only bottom 8 bits of the divider can be set
        .sample(sample),
        .cnt_zero(cnt_zero)
    );

    // reset handling
    always @(posedge clk or posedge n_rst) begin
        if(n_rst)
            rst <= 1'b0;
        else
            rst <= 1'b1;
    end

    always @(posedge clk) begin
        if(rst)
            divider <= 0;
        if(load_divider)
            divider <= data;
    end

    // counter and r2r output
    always @(posedge clk) begin
        if(rst) begin
            r2r_out <= 0;
        end else if(ext_data)
            r2r_out <= data;
        else begin
            r2r_out <= sample;
        end
    end

endmodule
