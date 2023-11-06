module program_counter(
	input[8:0] next,
	input reset, clk, write,
	output logic[8:0] result	
);

	always@(posedge clk or posedge reset)
	begin
		if(reset)
			result = '0;
		else begin
			if(write)
				result <= next;
				
		$display("PC=%h", PCResult);
		
		end
	
	end

endmodule: program_counter