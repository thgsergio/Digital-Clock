module maq_s(
	input maqs_clock,
	input maqs_reset,
	input maqs_enable,
	output logic [3:0] maqs_Lsd,
	output logic [2:0] maqs_Msd,
	output logic maqs_addminuto
);

always_ff @(posedge maqs_clock, negedge maqs_reset) begin
	if(!maqs_reset)
		begin
		maqs_Lsd <= 4'b0000;
        maqs_Msd <= 3'b000;
        maqs_addminuto <= 1'b0;
		end
	else if(maqs_enable) 
		begin
		if((maqs_Lsd == 4'b0000) && (maqs_Msd == 3'b000))
			begin
			maqs_addminuto <= 1'b0;
			end
		maqs_Lsd <= maqs_Lsd + 1'b1;
		if(maqs_Lsd == 4'b1010) 
			begin
			maqs_Lsd <= 4'b0000;
			maqs_Msd <= maqs_Msd + 1'b1;
				
			if(maqs_Msd == 3'b110) 
				begin
					maqs_Msd <= 3'b000;
					maqs_addminuto <= 1'b1;
				end
			end	
		end
	end

endmodule