`timescale 1ns / 1ps
// Lab 11 Task 1: Branch target address
module branchAdder(
    input wire [31:0] PC,
    input wire [31:0] imm,
    output wire [31:0] branchTarget
);
    assign branchTarget = PC + (imm << 1);
endmodule
