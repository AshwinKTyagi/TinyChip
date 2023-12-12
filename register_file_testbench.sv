module register_file_testbench;

    reg [1:0] reg1, reg2, reg_write;
    reg clk, reset, do_write;
    reg [7:0] write_data;
    wire [7:0] data1, data2;

    // Instantiate the register_file module
    register_file RF (
        .reg1(reg1),
        .reg2(reg2),
        .reg_w(reg_write),
        .clk(clk),
        .reset(reset),
		  .do_write(do_write),
        .write_data(write_data),
        .data1(data1),
        .data2(data2)
    );

    always begin
        #5 clk = ~clk;
    end


    initial begin
        reset = 1;
        clk = 0;
        write_data = 8'b11001100;
        reg_write = 3'b001;
        reg1 = 3'b000;
        reg2 = 3'b001;

        
		  #10 reset = 0;
		  do_write = 0;
        
		  
		  #10 
		  do_write = 1;
		  reg_write = 2'b01;
        write_data = 8'b10101010;
		  
		  
        #10 do_write = 0; 
		  reg1 = 2'b01;
        reg2 = 2'b10;

        // Add more test cases here as needed
		  
		  #10 do_write = 1;
		  reg_write = 2'b11;
		  write_data = 8'b11111111;
		  reg2 = 3'b00;
			
		

        $finish;
    end

    always @(posedge clk) begin
        $display("Time=%t, Data1=%h, Data2=%h", $time, data1, data2);
    end

endmodule
