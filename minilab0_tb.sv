`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2026 04:35:31 PM
// Design Name: 
// Module Name: minilab0_tb
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


module minilab0_tb();

    // Inputs to DUT (Device Under Test)
    reg clk;
    reg enable;
    reg [7:0] address;

    // Outputs from DUT
    wire [7:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    minilab0 iDUT (
        .clk(clk), 
        .en(enable), 
        .address(address), 
        .out(data_out));


    // Reference memory for checking results (must match design)
    reg [7:0] ref_rom [0:7];

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Variables for loop
    integer i = 0;
    integer val = 0;

    initial begin
        // Initialize Inputs
        clk = 0;
        enable = 0;
        address = 0;

        for (int i = 0; i < 8; i = i + 1) begin
            val = $random();
            ref_rom[i] = val;
            iDUT.rom_memory[i] = val;
        end

        //global reset
        #100;
        $display("-----------------------------------------");
        $display("Starting Simulation...");
        $display("-----------------------------------------");

        // TEST CASE 1: Test with Enable HIGH
        $display("Test Case 1: Reading all addresses with Enable HIGH");
        enable = 1;
        
        for (i = 0; i < 8; i = i + 1) begin
            address = (8'b1 << i);
            
            // Wait one clock cycle for the synchronous read
            @(posedge clk); 
            #1;
            
            // Check output
            if (data_out == ref_rom[i]) begin
                $display("[PASS] Index %0d (Addr: %b) -> Read: %h | Expected: %h", 
                          i, address, data_out, ref_rom[i]);
            end else begin
                $display("[FAIL] Index %0d (Addr: %b) -> Read: %h | Expected: %h", 
                          i, address, data_out, ref_rom[i]);
            end
        end

        // TEST CASE 2: Test with Enable LOW
        $display("\nTest Case 2: Checking Enable LOW behavior (Expect 0)");
        enable = 0;
        address = 8'b00000001;
        
        @(posedge clk);
        #1;
        
        if (data_out == 8'h00) begin
            $display("[PASS] Enable Low Test -> Read: %h | Expected: 00", data_out);
        end else begin
            $display("[FAIL] Enable Low Test -> Read: %h | Expected: 00", data_out);
        end

        $display("-----------------------------------------");
        $display("Simulation Complete.");
        $finish;
    end
      
endmodule
