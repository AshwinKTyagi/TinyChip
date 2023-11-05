// 1-bit ALU core code - R
module alu_read
#(parameter N=2) (
  input logic[N-1:0] operand1, operand2,
  input logic[3:0] operation,
  output logic[(2*N)-1:0] alu_out
);

  always@(operand1 or operand2 or operation) 
  begin
	 
	 case(operation)
		4'b0001: // add
			alu_out = operand1 + operand2;
		4'b0010: // logical and
			alu_out = operand1 & operand2;
		4'b0011: // subtract
			alu_out = operand1 + (~operand2 + 1);
		4'b0100: // logical or
			alu_out = operand1 | operand2;
		4'b0101: // bitwise xor
			alu_out = operand1 ^ operand2;
		4'b0110:  begin// set less than
			if (operand1 < operand2)
				alu_out = operand1;
			else
				alu_out = operand2;
			end
		4'b0111: //jump
//			alu_out = operand1 & operand2;
		4'b1000: // mult
			alu_out = operand1 * operand2;
		4'b1001: // div
			alu_out = operand1 / operand2;

		default:
			alu_out = operand1 + operand2;
	endcase

  end
endmodule: alu_read

