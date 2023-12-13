module register_file (
	input[1:0] reg1, reg2, //addresses for the registers
	input clk, reset, write,
	input[15:0] write_data, //of size 16
	output[15:0] data1, data2

);

	//only 4 registers used indexed using 2 bits
	logic[15:0] registers[0:3];
	logic[15:0] d1, d2;
	
	initial begin
		registers[0] <= '0;
		registers[1] <= '0;
		registers[2] <= '0;
		registers[3] <= '0;
	end

	always@(negedge clk or posedge reset) begin
		if(reset) begin
			registers[0] <= '0;
			registers[1] <= '0;
			registers[2] <= '0;
			registers[3] <= '0;
		end
		else if(write)
			registers[reg1] <= write_data;
			
	end
	always@(posedge clk) begin
		d1 <= registers[reg1];
		d2 <= registers[reg2];				
	
	end

	assign data1 = d1;
	assign data2 = d2;

	
endmodule: register_file