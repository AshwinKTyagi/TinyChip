module program_counter(
	input[8:0] jump_target,
	input reset, clk, write,
	output logic[8:0] result	
);
	//pc local variables
	logic[8:0] current;

	initial begin
		current <= '0;
		result <= '0;
	end

	always@(posedge clk or posedge reset)
	begin
		if(reset)
			result = '0;
		else begin
			result <= current + 4;
			if(write)
				result <= jump_target;
				
		end
	end
	
	always@(negedge clk) begin
		current <= result;
	end
	

endmodule: program_counter