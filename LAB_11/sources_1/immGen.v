`timescale 1ns / 1ps
// Lab 11 Task 1: RV32I I, S and B immediate generator
module immGen(
    input wire [31:0] instruction,
    output reg [31:0] immediate
);
    always @(*) begin
        case (instruction[6:0])
            // I-type immediate
            7'b0010011, 7'b0000011, 7'b1100111:
                immediate = {{20{instruction[31]}}, instruction[31:20]};

            // S-type immediate (sw)
            7'b0100011:
                immediate = {{20{instruction[31]}},
                             instruction[31:25], instruction[11:7]};

            // B-type immediate in bytes: bit 0 is always zero
            7'b1100011:
                immediate = {{19{instruction[31]}},
                             instruction[31], instruction[7],
                             instruction[30:25], instruction[11:8], 1'b0};

            default:
                immediate = 32'd0;
        endcase
    end
endmodule
