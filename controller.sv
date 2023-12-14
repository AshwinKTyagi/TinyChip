`include "alu_core.sv"
`include "register_file.sv"
`include "control_decoder.sv"
`include "data_memory.sv"
`include "program_counter.sv"
`include "instruction_memory.sv"
module controller (
	input logic clk, reset,
	output logic done
	); 
	
	
	//local controller variables
	logic[8:0] out; //output from last command(used for branching)
	
	//pc variables
	logic pc_write = 0;
	logic[7:0] jump, pc_result;
	
	//instruction handling
	logic[8:0] instruction;
	logic eof;
	
	//output from cd_module
	logic[1:0] reg_dest, reg_op;
	logic[2:0] immed_val;
	logic bit_type;
	logic[2:0] opcode;
	logic funct;
	
	//output from alu
	logic[15:0] alu_out;
	
	//changing these variables will cause updates in alu and rf_module
	logic[15:0] alu_data1, alu_data2;
	logic[15:0] data_to_reg = '0;
	logic reg_write = 0;
	//output from register file module
	logic[15:0] data1, data2;
	
	//changing these will update data_memory
	logic[5:0] data_address;
	logic[5:0] data_to_mem;
	logic mem_read = 0;
	logic mem_write = 0;
	//output from data_memory file
	logic[15:0] data_from_mem;

	
	//program counter
	program_counter pc(
		.reset(reset),
		.clk(clk),
		.write(pc_write),
		.jump_target(jump),
		.result(pc_result)
	);
	
	//instruction memory -- retrieves instruction from memory given address
	instruction_memory im_module(
		.addr(pc_result),
		.clk(clk),
		.reset(reset),
		.instruct(instruction),
		.done(eof)
	);
	
	//decode instructions
	control_decoder cd_module(
		.instruct(instruction),
		//outputs
		.bt(bit_type),
		.oc(opcode),
		.rd(reg_dest),
		.ro(reg_op),
		.fn(funct)
	);
	
	
	//handle getting and setting register file using rf_module
	register_file rf_module(
		.reg1(reg_dest),
		.reg2(reg_op),
		.clk(clk),
		.reset(reset),
		.write(reg_write),
		.write_data(data_to_reg),
		//outputs
		.data1(data1),
		.data2(data2)
	);
	
	//handle alu
	alu_core #(.N(16)) alu_module (
		.operand1(alu_data1),
		.operand2(alu_data2),
		.operation(opcode),
		//outputs
		.alu_out(alu_out)
	);
	
	//handle data mem
	data_memory dm_module (
		.addr(data_address),
		.write_data(data_to_mem),
		.mem_read(mem_read),
		.mem_write(mem_write),
		.clk(clk),
		//outputs
		.read_data(data_from_mem)
	);

	
	always @(clk) begin // for bit type 1: addi, store funct name, beq, bne
		if(bit_type) begin //bit_type = 1 --> immeditate
			immed_val <= {reg_op, funct};
			case(opcode) 
				3'b010: begin//beq - TODO: needs implementation for taking the branch
					out = (data1 == immed_val);
				end
				3'b011: //bne
					out = (data1 != immed_val);
				3'b100: begin//lw: load word -- data_memory
					mem_read = 1;
					mem_write = 0;
					data_address = data2[5:0];
					data_to_reg = data_from_mem;
				end
				3'b101: begin//sw: store word -- data memory
					mem_read = 0;
					mem_write = 1;
					data_to_mem = {'0, data2};
					data_address = data1[5:0];
				end
				3'b110: begin//shift right
					reg_write = ~reg_write;
					data_to_reg = {'0, data1 >>> immed_val};
				end
				3'b111: begin //shift left
					reg_write = ~reg_write;
					data_to_reg = {'0, data1 <<< immed_val};
				end
				default: begin
					alu_data1 = {'0, data1};
					alu_data2 = {13'b0, reg_op, funct};
					reg_write = ~reg_write;
					data_to_reg = alu_out; //handles addi
				end
			endcase
		end
		else begin //bit_type  = 0 --> register
			//TODO: update dat2 to get contents from reg2
			case({funct, opcode}) //when funct = 1, 000->j, 101->clr reg,
				4'b1000: begin //jump when funct bit 1 and opcode 0
					jump = data2[7:0];
					out = pc_result;
				end
				4'b1101: begin //mult by 0(clears a register)
					alu_data1 = data1;
					alu_data2 = '0;
					reg_write = ~reg_write;
					data_to_reg = alu_out;
				end
				default: begin
					alu_data1 = data1;
					alu_data2 = data2;
					reg_write = ~reg_write;
					data_to_reg = alu_out;
				end
			endcase
		end
		
		
	end
	
	assign done = eof;
	
	
endmodule: controller