`include "alu_core.sv"
`include "register_file.sv"
`include "control_decoder.sv"
`include "data_memory.sv"
module controller (
	input logic[8:0] instruction,
	input logic clk, reset,
	output logic[8:0] output_data
	); 
	
	logic[8:0] out;
	//output from cd_module
	logic[1:0] reg_dest, reg_op, immed_val;
	logic bit_type;
	logic[2:0] opcode;
	logic[1:0] funct;
	//output from alu
	logic[3:0] alu_out;
	
	//changing these variables will cause updates in alu and rf_module
	logic[7:0] alu_data2, data_to_reg; 
	logic[1:0] reg_write;
	logic do_write;
	//output from register file module
	logic[7:0] data1, data2;
	
	//changing these will update data_memory
	logic[7:0] data_address;
	logic[7:0] data_to_mem;
	logic mem_read = 0;
	logic mem_write = 0;
	//output from data_memory file
	logic[7:0] data_from_mem;
	
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
		.reg_w(reg_write),
		.clk(clk),
		.reset(reset),
		.do_write(do_write),
		.write_data(data_to_reg),
		//outputs
		.data1(data1),
		.data2(data2)
	);
	
	//handle alu
	alu_core #(.N(3)) alu_module (
		.operand1(data1),
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
		//outputs
		.read_data(data_from_mem)
	);
	
	
	
	always@(posedge clk) begin
		
		//if(funct) //funct == 1 means immediate mode
		//double check this bc idk if we need to have funct and bittype to diff immed vs reg
		//	alu_data2<=immed_val;
			
		if(bit_type) begin //bit_type = 1 --> immeditate
			immed_val <= reg_op;
			case(opcode) 
				3'b010: //beq - TODO: needs implementation for taking the branch
					out <= (data1 == immed_val);
				3'b011: //bne
					out <= (data1 != immed_val);
				3'b100: begin//lw: load word -- data_memory
					mem_read <= 1;
					mem_write <= 0;
					data_address <= data2;
					out <= data_from_mem;
				end
				3'b101: begin//sw: store word -- data memory
					mem_read <= 0;
					mem_write <= 1;
					data_to_mem <= data2;
					data_address <= data1;
					out <= data2;
				end
				3'b110: //srl
					out <= data1 >>> immed_val;
				default: begin
					alu_data2 <= immed_val;
					out <= alu_out; //handles addi, andi, slti
				end
			endcase
		end
		else begin //bit_type  = 0 --> register
			//TODO: update dat2 to get contents from reg2
			case(opcode) //need to come up with opcode for jump still
				3'b111: begin //slt
					alu_data2 <= data2;
					out <= alu_out;
				end
				default: begin
					alu_data2 <= data2;
					out <= alu_out;
				end
			endcase
		end
		
		
	end
	
	assign output_data = out;
endmodule: controller