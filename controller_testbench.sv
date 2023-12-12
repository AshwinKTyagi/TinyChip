`timescale 1ns/1ps

module controller_testbench;

    // Testbench Signals
    logic clk, reset;
    logic[8:0] output_data;

    // Instantiate the controller module
    controller uut (
        .clk(clk),
        .reset(reset),
        .output_data(output_data)
    );

    // Clock generation
    always #10 clk = ~clk; // Generate a clock with a period of 20 ns

    // Test sequence
    initial begin
        // Initialize testbench variables
        clk = 0;
        reset = 0;

        // Finish the simulation
        #300 $finish;
    end

    initial begin
        $monitor("Time = %0t, clk = %0b, reset = %0b, output_data = %0h",
                 $time, clk, reset, output_data);
    end

endmodule
