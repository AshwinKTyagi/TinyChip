module program_counter(
	input[8:0] jump_target,
	input reset, clk, write,
	output logic[8:0] result	
);
	//pc local variables
	logic[8:0] current, next;

	initial begin
		current <= '0;
		next <= '0;
	end

	always@(posedge clk or posedge reset)
	begin
		if(reset)
			next = '0;
		else begin
			if(write)
				next = jump_target;
			else 
				next = current + 1; //instructions stored in 2d array so only need to increment by 1
			current = next;
		end
	end
		
	assign result = next;

endmodule: program_counter