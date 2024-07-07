`default_nettype none
// Thanks to Mike Bell
// https://github.com/MichaelBell/tt08-pwm-example/blob/main/src/sine.v
module sine_lookup(
    input wire clk,
    input wire rst,

    input wire [11:0] divider,  // Ouput frequency is clk / (256 * (divider+1)), giving a minimum frequency of ~47Hz at a 50MHz clock

    output wire [7:0] sample
);


    // The sine data table has 64 entries, and these are reflected to create a total of 256
    // values across a full period.  Every divider+1 clocks, we move to the next entry in the table.
    reg [11:0] count;
    reg [7:0] sine_input;

    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
            sine_input <= 0;
        end
        else begin
            count <= count + 1;
            if (count == divider) begin
                count <= 0;
                sine_input <= sine_input + 1;
            end
        end
    end

    // ROM to look up values across 1/4 of a sine wave
    // Data generated with the following Python:
    /*
        resolution = 64
        scale = 127
        start = 0.5 - math.asin(1/(2*scale))*resolution
        end = resolution - 0.5
        for i in range(resolution):
            x = start + (end - start) * i / (resolution - 1)
            val = int(round(math.sin(x*math.pi/(2*resolution))*scale))
            print(f"{i}: raw_sine_rom = 7'd{val};")
    */
    function [6:0] raw_sine_rom(input [5:0] val);
        case (val)
0: raw_sine_rom = 7'd1;
1: raw_sine_rom = 7'd4;
2: raw_sine_rom = 7'd7;
3: raw_sine_rom = 7'd10;
4: raw_sine_rom = 7'd13;
5: raw_sine_rom = 7'd16;
6: raw_sine_rom = 7'd19;
7: raw_sine_rom = 7'd23;
8: raw_sine_rom = 7'd26;
9: raw_sine_rom = 7'd29;
10: raw_sine_rom = 7'd32;
11: raw_sine_rom = 7'd35;
12: raw_sine_rom = 7'd38;
13: raw_sine_rom = 7'd41;
14: raw_sine_rom = 7'd44;
15: raw_sine_rom = 7'd47;
16: raw_sine_rom = 7'd49;
17: raw_sine_rom = 7'd52;
18: raw_sine_rom = 7'd55;
19: raw_sine_rom = 7'd58;
20: raw_sine_rom = 7'd61;
21: raw_sine_rom = 7'd63;
22: raw_sine_rom = 7'd66;
23: raw_sine_rom = 7'd69;
24: raw_sine_rom = 7'd71;
25: raw_sine_rom = 7'd74;
26: raw_sine_rom = 7'd77;
27: raw_sine_rom = 7'd79;
28: raw_sine_rom = 7'd81;
29: raw_sine_rom = 7'd84;
30: raw_sine_rom = 7'd86;
31: raw_sine_rom = 7'd88;
32: raw_sine_rom = 7'd91;
33: raw_sine_rom = 7'd93;
34: raw_sine_rom = 7'd95;
35: raw_sine_rom = 7'd97;
36: raw_sine_rom = 7'd99;
37: raw_sine_rom = 7'd101;
38: raw_sine_rom = 7'd103;
39: raw_sine_rom = 7'd105;
40: raw_sine_rom = 7'd106;
41: raw_sine_rom = 7'd108;
42: raw_sine_rom = 7'd110;
43: raw_sine_rom = 7'd111;
44: raw_sine_rom = 7'd113;
45: raw_sine_rom = 7'd114;
46: raw_sine_rom = 7'd115;
47: raw_sine_rom = 7'd117;
48: raw_sine_rom = 7'd118;
49: raw_sine_rom = 7'd119;
50: raw_sine_rom = 7'd120;
51: raw_sine_rom = 7'd121;
52: raw_sine_rom = 7'd122;
53: raw_sine_rom = 7'd123;
54: raw_sine_rom = 7'd124;
55: raw_sine_rom = 7'd124;
56: raw_sine_rom = 7'd125;
57: raw_sine_rom = 7'd125;
58: raw_sine_rom = 7'd126;
59: raw_sine_rom = 7'd126;
60: raw_sine_rom = 7'd127;
61: raw_sine_rom = 7'd127;
62: raw_sine_rom = 7'd127;
63: raw_sine_rom = 7'd127;
        endcase
    endfunction

    // Function to compute roughly 127.5 + 127.5 * sin(2pi * val / 256)
    function automatic [7:0] sine(input [7:0] val);
        reg [5:0] negated_val;
        reg [6:0] half_sine;
        negated_val = 6'd63 - val[5:0];
        half_sine = raw_sine_rom(val[6] ? negated_val[5:0] : val[5:0]);
        sine = val[7] ? 7'd127 - half_sine : {1'b1, half_sine};
    endfunction

    assign sample = sine(sine_input);

endmodule
