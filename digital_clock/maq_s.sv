module maq_s2(
	input maqs_clock,
	input maqs_reset,
	input maqs_enable,
	output logic [3:0] maqs_Lsd,
	output logic [2:0] maqs_Msd,
	output logic maqs_addminuto
);

always_ff @(posedge maqs_clock or negedge maqs_reset) begin
	if(!maqs_reset)
	begin
		maqs_Lsd <= 4'b0000;
      maqs_Msd <= 3'b000;
      maqs_addminuto <= 1'b0;
	end
	else if(maqs_enable) 
	begin
		if(maqs_Lsd >= 4'b1001) 
		begin
			maqs_Lsd <= 4'b0000;

			if(maqs_Msd >= 3'b101) 
			begin
				maqs_Msd <= 3'b000;
				maqs_addminuto <= 1'b1;
			end 
			else 
			begin
				maqs_Msd <= maqs_Msd + 1'b1;
				maqs_addminuto <= 1'b0;
			end
		end
		else 
		begin
			maqs_Lsd <= maqs_Lsd + 1;
			maqs_addminuto <= 0;
		end
	end
end

endmodule