module register_file (
	input logic[1:0] reg1, reg2, //addresses for the registers
	input logic clk, reset, write,
	input logic[15:0] write_data, //of size 16
	output logic[15:0] data1, data2

);

	//only 4 registers used indexed using 2 bits
	logic[15:0] registers[0:3];
	
	initial begin
		registers[0] <= '0;
		registers[1] <= '0;
		registers[2] <= '0;
		registers[3] <= '0;
	end 
	
	always_comb begin
		case(reg1)
			2'b00: data1 <= registers[0];
			2'b01: data1 <= registers[1];
			2'b10: data1 <= registers[2];
			2'b11: data1 <= registers[3];			
		endcase
	end
	
	
	always_comb begin
		case(reg2)
			2'b00: data2 <= registers[0];
			2'b01: data2 <= registers[1];
			2'b10: data2 <= registers[2];
			2'b11: data2 <= registers[3];
		endcase
	end

	always @(posedge clk or posedge reset) begin 
		if (reset) begin
		registers[0] <= '0;
		registers[1] <= '0;
		registers[2] <= '0;
		registers[3] <= '0;
		end
		else begin
			if(write)
				registers[reg1] <= write_data;
		end
	
	end
	

	
endmodule: register_file