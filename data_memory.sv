module data_memory (
	input[5:0] addr, // change size of address depending on size of memory
	input[15:0] write_data, // data to be written in mem
	input mem_read, mem_write, clk,
	output[15:0] read_data

);

	logic[15:0] mem[0:63];
	
	logic[15:0] rd;

	always@(posedge clk) begin
		if(mem_write)
			mem[addr] <= write_data;
		
		if(mem_read)
			rd <= mem[addr];
	end 
		
	assign read_data = rd;
	
endmodule: data_memory