
module control_decoder(
  input logic[8:0] instruct,
  output logic bt,
  output logic[2:0] oc,
  output logic[1:0] rd,
  output logic[1:0] ro,
  output logic[1:0] fn
);
	
	always_comb begin
		bt <= instruct[8];
		oc <= instruct[7:5];
		rd <= instruct[4:3];
		ro <= instruct[2:1];
		fn <= instruct[0];
	end
  
endmodule: control_decoder