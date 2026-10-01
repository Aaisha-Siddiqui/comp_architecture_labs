`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: top_ALU_system
// Target Devices: Basys 3
//////////////////////////////////////////////////////////////////////////////////

module top_ALU_system (
    input wire clk,
    input wire pbin,
    input wire [15:0] physical_sw,
    output wire [15:0] physical_leds
);

    // Debouncer and Bus Signals
    wire rst_clean;
    wire [31:0] switch_data;           // Holds values read from switches
    reg  [31:0] led_write_data = 32'd0; // Data routed to the LED writer
    wire slow_clk;
  
    debouncer rst_db (
        .clk(clk),
        .pbin(pbin), 
        .pbout(rst_clean)
    );   

    leds switch_reader (
        .clk(clk), 
        .rst(rst_clean),
        .btns(16'd0),            
        .writeData(32'd0),       
        .writeEnable(1'b0),      
        .readEnable(1'b1),       // Active to read physical switches
        .memAddress(30'd0),       
        .switches(physical_sw),  
        .readData(switch_data)   
    );

    switches led_writer (
        .clk(clk), 
        .rst(rst_clean),
        .writeData(led_write_data),
        .writeEnable(1'b1),      
        .readEnable(1'b0), 
        .memAddress(30'd0),
        .readData(),             
        .leds(physical_leds)     
    );

    clock_divider ticker (
        .clk_in(clk),            
        .rst(rst_clean),         
        .clk_out(slow_clk)       
    );

    // FSM COUNTER LOGIC
    localparam WAIT      = 1'b0;
    localparam COUNTDOWN = 1'b1;

    reg state;
    reg [15:0] counter;

    always @(posedge clk) begin
        if (rst_clean) begin
            state   <= WAIT;
            counter <= 16'd0;
        end
        else if (state == WAIT) begin
            if (switch_data != 32'd0) begin
                counter <= switch_data[15:0];
                state   <= COUNTDOWN;
            end
            else begin
                counter <= 16'd0;
                state   <= WAIT;
            end
        end
        else if (state == COUNTDOWN) begin
            if (counter == 16'd1) begin
                counter <= 16'd0;
                state   <= WAIT;
            end
            else if (counter != 16'd0) begin
                counter <= counter - 16'd1;
                state   <= COUNTDOWN;
            end
            else begin
                counter <= 16'd0;
                state   <= WAIT;
            end
        end
        else begin
            state   <= WAIT;
            counter <= 16'd0;
        end
    end

    // ALU_32bit INSTANTIATION (32-Bit Binary Operands)
    wire [31:0] alu_result;
    wire zero_flag;

    // A = 0x10101010 
    // B = 0x01010101 
    ALU_32bit u_alu (
        .A(32'h10101010), 
        .B(32'h01010101), 
        .ShiftAmount(switch_data[8:4]),           // Shift amount mapped to switches [8:4]
        .ALUControl(switch_data[3:0]),            // ALU operation mapped to switches [3:0]
        .ALUResult(alu_result),
        .Zero(zero_flag)
    );

    // Continuous LED output assignment:
    // LED[15]   = Zero Flag
    // LED[14:0] = Lower 15 bits of ALU Result
    always @(*) begin
        led_write_data = {16'd0, zero_flag, alu_result[14:0]};
    end

endmodule