
module control_decoder(
  input logic[8:0] instruct, 
  output logic bit_type,
  output logic[2:0] opcode,
  output logic[1:0] reg_dest,
  output logic[1:0] reg_op,
  output logic[1:0] funct,
  output logic alu_src
);
  
	always@(instruct)
	begin
		assign bit_type = instruct[8];
		assign opcode = instruct[7:5];
		assign reg_dest = instruct[4:3];
		assign reg_op = instruct[2:1];
		assign funct = instruct[0];
	end
  
endmodule: control_decoder