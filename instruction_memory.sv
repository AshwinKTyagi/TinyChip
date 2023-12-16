module instruction_memory (
	input logic[7:0] addr, //change size of address depending on size of memory: initially 8bits
	input logic clk, reset,
	output logic[8:0] instruct,
	output logic done
);

	logic[8:0] mem[0:255];
	logic[7:0] last_addr;
	
	initial begin
		//init memory
		last_addr = '0;
		//this shit is dumb but change w full path of file
		$readmemb("//amznfsx7umcv4bw.AD.UCSD.EDU/share/users/aktyagi/Desktop/TinyChip/TinyChip/prog1_instructs.txt",mem);
		
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			last_addr <= '0;
			done = 1;
		end
		else begin
			last_addr <= addr;
			done <= (mem[addr] == 'bx);
		end
	end
	
	always_comb begin
		if(addr != last_addr) 
			instruct <= mem[addr];
		else
			instruct <= mem[addr];

	end
	
endmodule: instruction_memory