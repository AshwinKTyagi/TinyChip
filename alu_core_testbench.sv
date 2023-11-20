//1-bit ALU testbench code
`timescale 1ns/1ps
module alu_core_testbench;
	
	parameter N = 4;
	logic [N-1:0] operand1, operand2;
	logic [(2*N)-1:0] alu_out;
	logic [2:0] operation;
  
	alu_core #(N) alu (
		.operand1(operand1),
		.operand2(operand2),
		.operation(operation),
		.alu_out(alu_out)
	);

  // Testbench stimulus
	initial begin
		// Initialize inputs
		operand1 = 0;
		operand2 = 0;
		operation = 0 ; 
		#20ns
		operand1 = 2;
		operand2 = 1;
		operation = 0; // add

		#20ns;
		operand1 = 9;
		operand2 = 5;
		operation = 1; // and

		#20ns;
		operand1 = 12;
		operand2 = 10;
		operation = 2; // sub

		#20ns;
		operand1 = 7;
		operand2 = 4;
		operation = 3; // or

		#20ns
		operand1 = 12;
		operand2 = 6;
		operation = 4; // xor

		#20ns;
		operand1 = 4;
		operand2 = 2;
		operation = 5; // mult

		#20ns;
		operand1 = 6;
		operand2 = 3;
		operation = 6; //div

		#20ns;
		operand1 = 10;
		operand2 = 3;
		operation = 7; // slt
		
		#20ns;
		operand1 = 0;
		operand2 = 0;
		operation = 0;
		

    $display("alu_out = %h", alu_out);

    $finish;
  end
endmodule
