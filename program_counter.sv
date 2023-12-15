module program_counter(
	input logic[8:0] jump_target,
	input logic[4:0] branch_target,
	input logic reset, clk, write, do_branch,
	output logic[8:0] result	
);
	//pc local variables
	logic[8:0] current, next;
	logic[4:0] pclut[0:31];

	initial begin
		current <= '0;
		next <= '0;
		pclut[0] <= 2;
		//change to read in from file with branch defs in it
		//$readmemh("code.txt",pclut);
	end
	
	
	always @(posedge clk or posedge reset)
	begin
		if(reset)
			next = '0;
		else begin
			if(write)
				next = jump_target;
			else if (do_branch) begin
				next = pclut[branch_target];
			end
			else 
				next = current + 1'b1; //instructions stored in 2d array so only need to increment by 1
			current = next;
		end
	end
		
	assign result = next;

endmodule: program_counter