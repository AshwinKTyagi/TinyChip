`timescale 1ns/1ps

module controller_testbench;

    // Testbench Signals
    logic clk, reset;
    logic done;

    // Instantiate the controller module
    controller uut (
        .clk(clk),
        .reset(reset),
        .done(done)
    );

    // Clock generation
    always #10 clk = ~clk; // Generate a clock with a period of 20 ns

    // Test sequence
    initial begin
        // Initialize testbench variables
        clk = 1;
        reset = 0;

        // Finish the simulation
        #200 $finish;
    end

    initial begin
        $monitor("Time = %0t, clk = %0b, reset = %0b, done = %0h",
                 $time, clk, reset, done);
    end

endmodule
