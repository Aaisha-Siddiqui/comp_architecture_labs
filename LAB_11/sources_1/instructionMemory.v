`timescale 1ns / 1ps
// Instruction memory matches the Lab 10 byte-oriented memory file format.
module instructionMemory #(
    parameter OPERAND_LENGTH = 31
)(
    input  [OPERAND_LENGTH:0] instAddress,
    output reg [31:0] instruction
);
    reg [7:0] memory [0:255];
    integer i;
    wire [7:0] a = {instAddress[7:2], 2'b00};

    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 8'h00;
        $readmemh("fsm_program.mem", memory);
    end

    always @(*) begin
        instruction = {memory[a+3], memory[a+2],
                       memory[a+1], memory[a]};
    end
endmodule
