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
	
	always_comb begin
		case(reg1)
			2'b00: d1 <= registers[0];
			2'b01: d1 <= registers[1];
			2'b10: d1 <= registers[2];
			2'b11: d1 <= registers[3];			
		endcase
	end
	
	always_comb begin
		case(reg2)
			2'b00: d2 <= registers[0];
			2'b01: d2 <= registers[1];
			2'b10: d2 <= registers[2];
			2'b11: d2 <= registers[3];			
		endcase
	end
		
	always @(write) begin
		case(reg1)
			2'b00: registers[0] <= write_data;
			2'b01: registers[1] <= write_data;
			2'b10: registers[2] <= write_data;
			2'b11: registers[3] <= write_data;	
		endcase
	end
	
	assign data1 = d1;
	assign data2 = d2;

	
endmodule: register_file