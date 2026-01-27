`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2026 03:51:31 PM
// Design Name: 
// Module Name: minilab0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module minilab0(
    input clk,
    input en,
    input wire [7:0] address,
    output reg [7:0] data_out
    );
    
    reg [7:0] rom_memory [0:7];
    
    initial begin
    
    rom_memory[0] = 8'h10;
    rom_memory[1] = 8'h12;
    rom_memory[2] = 8'h21;
    rom_memory[3] = 8'hCC;
    rom_memory[4] = 8'hAF;
    rom_memory[5] = 8'hFF;
    rom_memory[6] = 8'hEE;
    rom_memory[7] = 8'hDD;
    
    end
    
    always @(posedge clk) begin
        if (!en) begin
            data_out <= 8'b0;
        end else begin
            if (en) begin
                case (address)
                    8'b00000001: data_out <= rom_memory[0];
                    8'b00000010: data_out <= rom_memory[1];
                    8'b00000100: data_out <= rom_memory[2];
                    8'b00001000: data_out <= rom_memory[3];
                    8'b00010000: data_out <= rom_memory[4];
                    8'b00100000: data_out <= rom_memory[5];
                    8'b01000000: data_out <= rom_memory[6];
                    8'b10000000: data_out <= rom_memory[7];
                    default: data_out <= 8'b0;
                endcase
            end
          end
       end
endmodule
