module instruction_memory (
	input logic[7:0] addr, //change size of address depending on size of memory: initially 8bits
	input logic clk, reset,
	output logic[8:0] instruct,
	output logic done
);

	logic[8:0] mem[0:255];
	logic d;
	
	initial begin
		//init memory
		mem[0] = 9'b100001111; //add #7 to r1
		mem[1] = 9'b100001111; //add #7 to r1
		mem[2] = 9'b110101011; //str r3 from mem #3
		mem[3] = 9'b010101001; //mult r1 by 0
		//change to read in from file with instructions in it
		//$readmemh("code.txt",mem);
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			instruct <= 9'b000000000;
		else
			instruct <= mem[addr];
			
			d <= (mem[addr] == 9'bx);
	end
	
	assign done = d;
	
endmodule: instruction_memory