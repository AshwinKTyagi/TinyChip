module instruction_memory (
	input logic[7:0] addr, //change size of address depending on size of memory: initially 8bits
	input logic clk, reset,
	output logic[8:0] instruct,
);

	logic[8:0] mem[0:256];
	
	
	initial begin
		//init memory
		mem[0] = 9'b000000000
		//subject to change depending on requirements
	end

	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			instruct <= 9'b000000000;
		else
			instruct <= mem[addr];
	end
endmodule: instruction_memory