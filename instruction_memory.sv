module instruction_memory (
	input logic[7:0] addr, //change size of address depending on size of memory: initially 8bits
	input logic clk, reset,
	output logic[8:0] instruct
);

	logic[8:0] mem[0:255];
	
	initial begin
		//init memory
		mem[0] = 9'b100001111; //add #7 to r1
		mem[1] = 9'b110101011; //str r3 from mem #3
		mem[2] = 9'b1; //mult r1 by 0
		mem[3] = 9'b; //store r2 at addr(3)
		//change to read in from file with instructions in it
		//$readmemh("code.txt",mem);
	end

	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			instruct <= 9'b000000000;
		else
			instruct <= mem[addr];
	end
endmodule: instruction_memory