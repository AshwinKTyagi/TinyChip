`include "alu_core.sv"
`include "register_file.sv"
`include "control_decoder.sv"
`include "data_memory.sv"
module controller (
	input logic[8:0] instruction,
	input logic clk, reset,
	
	
)

	//output from cd_module
	logic[1:0] reg_dest, reg_op, immed_val;
	logic bit_type;
	logic[2:0] opcode;
	logic[1:0] funct;
	//output from alu
	logic[3:0] alu_out;
	
	//changing these variables will cause updates in rf_module
	logic[7:0] data1, data2, data_write; 
	logic[1:0] reg_write;
	logic do_write;
	//changing these will update data_memory
	logic[7:0] data_address, data_from_mem;
	logic mem_read = 0;
	logic mem_write = 0;
	
	//decode instructions
	control_decoder cd_module(
		instruct=instruction,
		//outputs
		bt=bit_type,
		oc=opcode,
		rd=reg_dest,
		ro=reg_op,
		fn=funct
	);
	
	
	//handle getting and setting register file using rf_module
	register_file rf_module(
		reg1=reg_dest,
		reg2=reg_op,
		reg_w=reg_write,
		clk=clk,
		reset=reset,
		do_write=do_write,
		write_data=data_write,
		//outputs
		data1=data1,
		data2=data2
	);
	
	//handle alu
	alu_core alu_module #(2)(
		operand1=data1,
		operand2=data2,
		operation=opcode,
		//outputs
		alu_out=alu_out
	);
	
	//handle data mem
	data_memory dm_module (
		addr=data_address,
		data_write=dat_write,
		mem_read=mem_read,
		mem_write=mem_write,
		//outputs
		data_read=data_from_mem
	);
	
	
	
	always@(posedge clk) begin
		
		if(funct) //funct == 1 means immediate mode
			dat2<=immed_val;
		if(bit_type) begin //bit_type = 1 --> immeditate
			case(operation) 
				3'b010: //beq - TODO: needs implementation for taking the branch
					out <= (dat1 == immed_val);
				3'b011: //bne
					out <= (dat1 != immed_val);
				3'b100: begin//lw
					mem_read <= 1;
					addr <= dat2;
					out <= data_from_mem;
				end
				3'b101: begin//sw
					mem_write <= 1;
					dat_write <= dat2;
					addr <= dat1;
					out <= data_from_mem;
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
		

endmodule: controller