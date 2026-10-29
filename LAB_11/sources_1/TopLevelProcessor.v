`timescale 1ns / 1ps
// Lab 11 Task 2: Integrated single-cycle RV32I processor.
// Uses the ALU, register file, and control path from Labs 6, 7, and 9.
// Address map from Lab 8: RAM 0x000-0x1FF, LEDs 0x200-0x2FF,
// physical switches 0x300-0x3FF.
module TopLevelProcessor(
    input wire clk,
    input wire rst,
    input wire [15:0] physical_sw,
    output wire [15:0] physical_leds,
    output wire [31:0] debugPC,
    output wire [31:0] debugInstruction
);
    wire [31:0] PC, nextPC, PCPlus4, instruction, immediate, branchTarget;
    wire [31:0] rs1Data, rs2Data, aluB, aluResult, writeBackData;
    reg  [31:0] dataReadValue;

    wire RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire Zero, PCSrc;

    wire [9:0] address10;
    wire DataMemRead, DataMemWrite, LEDWrite, SwitchReadEnable;
    wire [31:0] switchReadData;
    reg [31:0] memory [0:511];
    reg [15:0] led_reg;
    integer i;

    assign debugPC = PC;
    assign debugInstruction = instruction;

    ProgramCounter pc_register(.clk(clk), .rst(rst), .nextPC(nextPC), .PC(PC));
    pcAdder pc_plus_four(.PC(PC), .PCPlus4(PCPlus4));
    instructionMemory instruction_memory(.instAddress(PC), .instruction(instruction));
    immGen immediate_generator(.instruction(instruction), .immediate(immediate));
    branchAdder branch_address(.PC(PC), .imm(immediate), .branchTarget(branchTarget));

    ControlPath control_path(
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .RegWrite(RegWrite), .ALUOp(ALUOp), .MemRead(MemRead),
        .MemWrite(MemWrite), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg),
        .Branch(Branch), .ALUControl(ALUControl)
    );

    RegisterFile register_file(
        .clk(clk), .rst(rst), .WriteEnable(RegWrite),
        .rs1(instruction[19:15]), .rs2(instruction[24:20]),
        .rd(instruction[11:7]), .WriteData(writeBackData),
        .ReadData1(rs1Data), .ReadData2(rs2Data)
    );

    assign aluB = ALUSrc ? immediate : rs2Data;
    ALU_32bit alu(
        .A(rs1Data), .B(aluB), .ShiftAmount(instruction[24:20]),
        .ALUControl(ALUControl), .ALUResult(aluResult), .Zero(Zero)
    );

    assign address10 = aluResult[9:0];

    // Match Lab 8 AddressDecoder's regions.
    assign DataMemRead = MemRead && (address10[9:8] != 2'b10)
                                  && (address10[9:8] != 2'b11);
    assign DataMemWrite = MemWrite && (address10[9:8] != 2'b10)
                                    && (address10[9:8] != 2'b11);
    assign LEDWrite = MemWrite && (address10[9:8] == 2'b10);
    assign SwitchReadEnable = MemRead && (address10[9:8] == 2'b11);
    assign switchReadData = {16'd0, physical_sw};

    // Asynchronous read for single-cycle LW.
    always @(*) begin
        if (SwitchReadEnable)
            dataReadValue = switchReadData;
        else if (DataMemRead)
            dataReadValue = memory[address10[8:0]];
        else
            dataReadValue = 32'd0;
    end

    // Synchronous data-memory writes and memory-mapped LED writes.
    always @(posedge clk) begin
        if (rst) begin
            led_reg <= 16'd0;
            for (i = 0; i < 512; i = i + 1)
                memory[i] <= 32'd0;
        end
        else begin
            if (DataMemWrite)
                memory[address10[8:0]] <= rs2Data;
            if (LEDWrite)
                led_reg <= rs2Data[15:0];
        end
    end

    assign physical_leds = led_reg;
    assign writeBackData = MemtoReg ? dataReadValue : aluResult;
    assign PCSrc = Branch & Zero;

    mux2 next_pc_mux(.in0(PCPlus4), .in1(branchTarget), .select(PCSrc), .out(nextPC));
endmodule
