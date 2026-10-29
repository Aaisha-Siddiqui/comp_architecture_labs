`timescale 1ns / 1ps
// Lab 11 Task 2: Integrated single-cycle RV32I processor.
// Reuses Lab 6 ALU, Lab 7 RegisterFile, Lab 8 memory interfaces,
// and Lab 9 control modules.
module TopLevelProcessor(
    input wire clk,
    input wire rst,
    input wire [15:0] physical_sw,
    output wire [15:0] physical_leds,
    output wire [31:0] debugPC,
    output wire [31:0] debugInstruction
);
    wire [31:0] PC;
    wire [31:0] nextPC;
    wire [31:0] PCPlus4;
    wire [31:0] instruction;
    wire [31:0] immediate;
    wire [31:0] branchTarget;
    wire [31:0] rs1Data;
    wire [31:0] rs2Data;
    wire [31:0] aluB;
    wire [31:0] aluResult;
    wire [31:0] memoryReadData;
    wire [31:0] writeBackData;
    wire [31:0] memoryAddress;
    wire [31:0] dataReadValue;

    wire RegWrite;
    wire [1:0] ALUOp;
    wire MemRead;
    wire MemWrite;
    wire ALUSrc;
    wire MemtoReg;
    wire Branch;
    wire [3:0] ALUControl;
    wire Zero;
    wire PCSrc;

    assign debugPC = PC;
    assign debugInstruction = instruction;

    ProgramCounter pc_register(
        .clk(clk),
        .rst(rst),
        .nextPC(nextPC),
        .PC(PC)
    );

    pcAdder pc_plus_four(
        .PC(PC),
        .PCPlus4(PCPlus4)
    );

    instructionMemory instruction_memory(
        .instAddress(PC),
        .instruction(instruction)
    );

    immGen immediate_generator(
        .instruction(instruction),
        .immediate(immediate)
    );

    branchAdder branch_address(
        .PC(PC),
        .imm(immediate),
        .branchTarget(branchTarget)
    );

    ControlPath control_path(
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .ALUControl(ALUControl)
    );

    RegisterFile register_file(
        .clk(clk),
        .rst(rst),
        .WriteEnable(RegWrite),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .WriteData(writeBackData),
        .ReadData1(rs1Data),
        .ReadData2(rs2Data)
    );

    assign aluB = ALUSrc ? immediate : rs2Data;

    ALU_32bit alu(
        .A(rs1Data),
        .B(aluB),
        .ShiftAmount(instruction[24:20]),
        .ALUControl(ALUControl),
        .ALUResult(aluResult),
        .Zero(Zero)
    );

    assign memoryAddress = aluResult;

    // Address decoder and the original Lab 8 memory-mapped I/O.
    addressDecoderTop memory_system(
        .clk(clk),
        .rst(rst),
        .address(memoryAddress),
        .readEnable(MemRead),
        .writeEnable(MemWrite),
        .writeData(rs2Data),
        .switches(physical_sw),
        .readData(dataReadValue),
        .leds(physical_leds)
    );

    assign writeBackData = MemtoReg ? dataReadValue : aluResult;
    assign PCSrc = Branch & Zero;

    mux2 next_pc_mux(
        .in0(PCPlus4),
        .in1(branchTarget),
        .select(PCSrc),
        .out(nextPC)
    );
endmodule
