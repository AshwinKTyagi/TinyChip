module register_file_tb;

  reg [1:0] reg1, reg2;
  reg clk, reset, write;
  reg [15:0] write_data;
  wire [15:0] data1, data2;

  // Instantiate the register_file module
  register_file uut (
    .reg1(reg1),
    .reg2(reg2),
    .clk(clk),
    .reset(reset),
    .write(write),
    .write_data(write_data),
    .data1(data1),
    .data2(data2)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initial stimulus
  initial begin
    // Initialize signals
    reg1 = 2'b00; // Example register 0
    reg2 = 2'b01; // Example register 1
    reset = 1;
    write = 0;

    // Apply reset
    #10 reset = 0;

    // Write data to registers
    #20 write = 1;
    #30 write_data = 16'hABCD; // Writing data to register 0
    #40 write = 0;

    // Read data from registers
    #60 reg1 = 2'b10; // Example register 2
    #70 reg2 = 2'b11; // Example register 3

    // Add more test scenarios as needed

    #100 $finish; // End simulation
  end

endmodule: register_file_tb
