module program_counter(
	input[31:0] jump_target,
	input reset, clk, write,
	output logic[31:0] result	
);
	//pc local variables
	logic[31:0] current, next;

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
				next = current + 4;
			current = next;
		end
	end
		
	assign result = next;

endmodule: program_counter