`include "alu_core.sv"
`include "register_file.sv"
`include "control_decoder.sv"
module controller (
	input logic[8:0] instruction,
	input logic clk, reset,
	
	output logic[1:0] reg_dest, reg_op, immed_val, 
	output logic bit_type,
	output logic[2:0] opcode,
	output logic[1:0] funct,
	output logic[(2*N)-1:0] out
)
	//decode instructions
	control_decoder cd(
		instruct=instruction,
		bt=bit_type,
		oc=opcode,
		rd=reg_dest,
		ro=reg_op,
		fn=funct,
	);

	input logic[7:0] dat1, dat2; //store data from registers

	
	/*
	always@(posedge clk) begin
		//TODO: update dat1 to get contents from reg1
		if(bit_type) begin //bit_type = 1 --> immeditate
			case(operation) 
				3'b010: //beq - TODO: needs implementation for taking the branch
					out <= (dat1 == immed_val);
				3'b011: //bne
					out <= (dat1 != immed_val);
				3'b100: begin//lw
				end
				3'b101: begin//sw 
				end
				3'b110: //srl
					out <= dat1 >>> immed_val;
				default:
					out <= alu_core(dat1, immed_val, operation); //handles addi, andi, slti
			endcase
		else begin //bit_type  = 0 --> register
			
			//TODO: update dat2 to get contents from reg2
			case(operation) //need to come up with opcode for jump still
				3'b111: begin //slt
					out
				end
				default:
					out <= alu_core(dat1, dat2, operation);
		end
		*/

endmodule: controller