`timescale 1ns/1ns
module program_counter_testbench();

    logic [8:0] next;
    logic reset, clk, write;
    wire [8:0] result;
    
    // Instantiate the program_counter module
    program_counter PC (
        .next(next),
        .reset(reset),
        .clk(clk),
        .write(write),
        .result(result)
    );
    
    // Clock generation
    reg clock = 0;
    always begin
        #5 clock = ~clock;
    end
    
    // Test stimulus generation
    initial begin
        reset = 1;
        write = 0;
        clk = 0;
        next = 10;
        
        #10ns reset = 0;
		  
        #20ns next = 42;
        write = 1;
		  
        #30ns write = 0;
		  next = 32;
		  write = 1;
        
		  #40ns next = 9'b010101010;
		  
		  #50ns reset = 1;
        // Add more test cases here as needed
        
        $finish;
    end
    
    always @(posedge clk) begin
        $display("Time=%t, PC=%h", $time, result);
    end
endmodule