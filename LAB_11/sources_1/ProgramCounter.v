`timescale 1ns / 1ps
// Lab 11 Task 1: Program Counter
module ProgramCounter(
    input wire clk,
    input wire rst,
    input wire [31:0] nextPC,
    output reg [31:0] PC
);
    always @(posedge clk) begin
        if (rst)
            PC <= 32'd0;
        else
            PC <= nextPC;
    end
endmodule
