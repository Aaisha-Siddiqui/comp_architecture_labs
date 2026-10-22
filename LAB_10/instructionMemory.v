module instructionMemory #(
    parameter OPERAND_LENGTH = 31
)(
    input [OPERAND_LENGTH:0] instAddress,
    output reg [31:0] instruction
);

    reg [7:0] memory [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 8'h00;

        $readmemh("fsm_machine_code.hex", memory);
    end

    always @(*) begin
        instruction = {
            memory[instAddress[7:0] + 3],
            memory[instAddress[7:0] + 2],
            memory[instAddress[7:0] + 1],
            memory[instAddress[7:0]]
        };
    end

endmodule
