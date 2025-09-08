module maq_h(
	input maqh_clock,
	input maqh_reset,
	input maqh_enable,
	input maqh_incremento,
	output logic [3:0] maqh_Lsd,
	output logic [1:0] maqh_Msd
);

always_ff @(posedge maqh_clock, negedge maqh_reset) begin
	if(!maqh_reset)
		begin
		maqh_Lsd <= 4'b0000;
		maqh_Msd <= 2'b00;
		end
	else if((maqh_enable) && (maqh_incremento))
		begin
        if ((maqh_Msd == 2'b10) && (maqh_Lsd == 4'b0100)) begin
            maqh_Lsd <= 4'b0000;
            maqh_Msd <= 2'b00;
        end
        else if (maqh_Lsd == 9) begin
            maqh_Lsd <= 0;
            maqh_Msd <= maqh_Msd + 1;
        end
        else begin
            maqh_Lsd <= maqh_Lsd + 1;
        end
	end
end

endmodule