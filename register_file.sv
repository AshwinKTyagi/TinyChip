module register_file (
	input[1:0] reg1, reg2, reg_write, //addresses for the registers
	input clk, reset, do_write,
	input[7:0] write_data, //of size 8 for now but change if needed
	output[7:0] data1, data2

);

	//only 4 registers used indexed using 2 bits
	reg[3:0] registers;
	
	initial begin
		registers[0] <= 8'b00000000;
		registers[1] <= 8'b00000000;
		registers[2] <= 8'b00000000;
		registers[3] <= 8'b00000000;
	end

	always@(posedge clk or reset) begin
		if(reset) begin
			registers[0] <= 8'b00000000;
			registers[1] <= 8'b00000000;
			registers[2] <= 8'b00000000;
			registers[3] <= 8'b00000000;
		end
		else if(do_write)
			registers[reg_write] <= write_data;
	
	end
	always@(negedge clk) begin
		data1 <= registers[reg1];
		data2 <= registers[reg2];
	end

endmodule: register_file