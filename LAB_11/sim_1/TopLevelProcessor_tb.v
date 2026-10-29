`timescale 1ns / 1ps
module TopLevelProcessor_tb;
    reg clk;
    reg rst;
    reg [15:0] physical_sw;
    wire [15:0] physical_leds;
    wire [31:0] debugPC;
    wire [31:0] debugInstruction;

    TopLevelProcessor dut(
        .clk(clk),
        .rst(rst),
        .physical_sw(physical_sw),
        .physical_leds(physical_leds),
        .debugPC(debugPC),
        .debugInstruction(debugInstruction)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        physical_sw = 16'd0;
        #20;
        rst = 0;

        // Watch PC, instruction, LEDs and memory/register state in waveform.
        repeat (100) begin
            @(posedge clk);
            $display("PC=%h INST=%h LED=%h", debugPC, debugInstruction, physical_leds);
        end

        $finish;
    end
endmodule
