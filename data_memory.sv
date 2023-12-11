module data_memory (
	input[7:0] addr, // change size of address depending on size of memory
	input[7:0] write_data, // data to be written in mem
	input mem_read, mem_write, clk,
	output[7:0] read_data

);

	logic[7:0] mem[0:256];

	always@(posedge clk) begin
		if(mem_write)
			mem[addr] = write_data;
		
		if(mem_read)
			read_data <= mem[addr];
	end 
		
endmodule: data_memory