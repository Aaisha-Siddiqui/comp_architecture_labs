`timescale 1ns / 1ps
module Task1_tb;
    reg clk;
    reg rst;
    reg [31:0] instruction;
    reg PCSrc;
    reg [31:0] testPC;
    wire [31:0] PC;
    wire [31:0] PCPlus4;
    wire [31:0] immediate;
    wire [31:0] branchTarget;
    wire [31:0] nextPC;

    ProgramCounter pc0(.clk(clk), .rst(rst), .nextPC(nextPC), .PC(PC));
    pcAdder add4(.PC(PC), .PCPlus4(PCPlus4));
    immGen imm0(.instruction(instruction), .immediate(immediate));
    branchAdder ba(.PC(PC), .imm(immediate), .branchTarget(branchTarget));
    mux2 m0(.in0(PCPlus4), .in1(branchTarget), .select(PCSrc), .out(nextPC));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        PCSrc = 0;
        instruction = 32'h00500093; // addi x1,x0,5 (I-type immediate 5)
        #10;
        rst = 0;
        #10;
        if (PC !== 32'd4) $display("FAIL: PC should be 4, got %h", PC);
        else $display("PASS: PC increments by 4");

        // B-type example with branch immediate of +8 bytes.
        // Immediate generator returns encoded branch immediate (offset/2).
        instruction = 32'h00000463; // beq x0,x0,+8
        PCSrc = 1;
        #10;
        if (PC !== 32'd12) $display("FAIL: branch PC expected 12, got %h", PC);
        else $display("PASS: branch target selected");

        instruction = 32'hFFF00113; // addi x2,x0,-1
        #1;
        if (immediate !== 32'hFFFFFFFF)
            $display("FAIL: I-type sign extension: %h", immediate);
        else
            $display("PASS: I-type signed immediate");

        $finish;
    end
endmodule
