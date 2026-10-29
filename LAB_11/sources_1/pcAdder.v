`timescale 1ns / 1ps
// Lab 11 Task 1: PC + 4
module pcAdder(
    input wire [31:0] PC,
    output wire [31:0] PCPlus4
);
    assign PCPlus4 = PC + 32'd4;
endmodule
