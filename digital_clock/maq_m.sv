module maq_m(
	input maqm_clock,
	input maqm_reset,
	input maqm_enable,
	input maqm_incremento,
	output logic [3:0] maqm_Lsd,
	output logic [2:0] maqm_Msd,
	output logic maqm_incrementahora
);

always_ff @(posedge maqm_clock or negedge maqm_reset)
begin
	if(!maqm_reset)
	begin
		maqm_Lsd <= 4'b1001;
		maqm_Msd <= 3'b101;
		maqm_incrementahora <= 1'b0;
	end
	else if(maqm_enable && maqm_incremento)
	begin
		if(maqm_Lsd >= 4'b1001) 
		begin
			maqm_Lsd <= 4'b0000;

			if(maqm_Msd >= 3'b101) 
			begin
				maqm_Msd <= 3'b000;
				maqm_incrementahora <= 1'b0;
			end 
			else 
			begin
				maqm_Msd <= maqm_Msd + 1'b1;
				maqm_incrementahora <= 1'b0;
			end
		end
		else if(maqm_Msd >= 3'b101)
		begin
			if(maqm_Lsd >= 4'b1000 && maqm_Lsd < 4'b1001)
			begin
				maqm_incrementahora <= 1'b1;
			end
			else 
			begin
				maqm_incrementahora <= 0;
			end
			maqm_Lsd <= maqm_Lsd + 1;
		end
		else 
			begin
				maqm_Lsd <= maqm_Lsd + 1;
				maqm_incrementahora <= 0;
			end
	end
end

endmodule