// 1-bit ALU core code
module alu_core
#(parameter N=16) (
  input logic[N-1:0] operand1, operand2,
  input logic[2:0] operation,
  output logic[(2*N)-1:0] alu_out
);

	always_comb begin
		case(operation)
			3'b000: // add
				alu_out = operand1 + operand2;
			3'b001: // logical and
				alu_out = operand1 & operand2;
			3'b010: // subtract
				alu_out = operand1 + (~operand2 + 1'b1);
			3'b011: // logical or
				alu_out = operand1 | operand2;
			3'b100: // bitwise xor
				alu_out = operand1 ^ operand2;
			3'b101: // mult
				alu_out = operand1 * operand2;
			3'b110: // div
				alu_out = operand1 / operand2;
			3'b111:  begin// set less than
				if (operand1 < operand2)
					alu_out = operand1;
				else
					alu_out = operand2;
				end
				
		//this alu can handle add, addi, sub, and, andi, or, xor, mult, div, slt, slti
		//can not handle beq, bne, j, lw, sw, srl
		
		default:
			alu_out = operand1 + operand2;
	endcase

  end
endmodule: alu_core

