`default_nettype none

// just a stub to keep the Tiny Tapeout tools happy

module tt_um_mattvenn_r2r_dac_3v3 (
    input  wire       VGND,
    input  wire       VDPWR,    // 1v8
    input  wire       VAPWR,    // 3v3
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua, // analog pins
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    wire [7:0] r2r_out;

    r2r_dac_control r2r_dac_control(
        .clk(clk),                  // expect a 10M clock
        .n_rst(rst_n),
        .ext_data(uio_in[0]),       // if this is high, then DAC data comes from ui_in[7:0]
        .load_divider(uio_in[1]),   // load value set on data to the clock divider
        .data(ui_in),               // connect to ui_in[7:0]
        .r2r_out(r2r_out),          // 8 bit out to the R2R DAC
        .VPWR(VDPWR),
        .VGND(VGND)
        );

    r2r r2r(
        .b0(r2r_out[0]),
        .b1(r2r_out[1]),
        .b2(r2r_out[2]),
        .b3(r2r_out[3]),
        .b4(r2r_out[4]),
        .b5(r2r_out[5]),
        .b6(r2r_out[6]),
        .b7(r2r_out[7]),
        .out(ua[0]),
        .GND(VGND)
        .VAPWR(VAPWR)
        .VDPWR(VDPWR)
        );

    // ties for the output enables
    assign uo_out[0] = VGND;
    assign uo_out[1] = VGND;
    assign uo_out[2] = VGND;
    assign uo_out[3] = VGND;
    assign uo_out[4] = VGND;
    assign uo_out[5] = VGND;
    assign uo_out[6] = VGND;
    assign uo_out[7] = VGND;

    assign uio_out[0] = VGND;
    assign uio_out[1] = VGND;
    assign uio_out[2] = VGND;
    assign uio_out[3] = VGND;
    assign uio_out[4] = VGND;
    assign uio_out[5] = VGND;
    assign uio_out[6] = VGND;
    assign uio_out[7] = VGND;

    assign uio_oe[0] = VGND;
    assign uio_oe[1] = VGND;
    assign uio_oe[2] = VGND;
    assign uio_oe[3] = VGND;
    assign uio_oe[4] = VGND;
    assign uio_oe[5] = VGND;
    assign uio_oe[6] = VGND;
    assign uio_oe[7] = VGND;

endmodule
