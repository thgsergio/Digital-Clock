module topo(
	input clock,
	input reset,
	output logic [6:0] s_Lsd,
	output logic [6:0] s_Msd,
	output logic [6:0] m_Lsd,
	output logic [6:0] m_Msd,
	output logic [6:0] h_Lsd,
	output logic [6:0] h_Msd
);

logic enable1hz;

//maq_s
logic [3:0] bcd_s_Lsd;
logic [2:0] bcd_s_Msd;
logic incrementa_minuto;

//maq_m
logic [3:0] bcd_m_Lsd;
logic [2:0] bcd_m_Msd;
logic incrementa_hora;

//maq_h
logic [3:0] bcd_h_Lsd;
logic [2:0] bcd_h_Msd;

enable_1hz meuhabilitador(
.enable_clock(clock),
.enable_reset(reset),
.enable_pulseout(enable1hz));

//maq_s + display_7
maq_s maqs_display_s(
.maqs_clock(clock),
.maqs_reset(reset),
.maqs_enable(enable1hz),
.maqs_Lsd(bcd_s_Lsd),
.maqs_Msd(bcd_s_Msd),
.maqs_addminuto(incrementa_minuto));

display_7 display_s_Lsd(
.bcd_bcd_in(bcd_s_Lsd),
.bcd_display_out(s_Lsd));

display_7 display_s_Msd(
.bcd_bcd_in({1'b0,bcd_s_Msd}),
.bcd_display_out(s_Msd));


//maq_m + display
maq_m maq_display_m(
.maqm_clock(clock),
.maqm_reset(reset),
.maqm_enable(enable1hz),
.maqm_incremento(incrementa_minuto),
.maqm_Lsd(bcd_m_Lsd),
.maqm_Msd(bcd_m_Msd),
.maqm_incrementahora(incrementa_hora));

display_7 display_m_Lsd(
.bcd_bcd_in(bcd_m_Lsd),
.bcd_display_out(m_Lsd));

display_7 display_m_Msd(
.bcd_bcd_in({1'b0,bcd_m_Msd}),
.bcd_display_out(m_Msd));

//maq_h + display
maq_h maq_display_h(
.maqh_clock(clock),
.maqh_reset(reset),
.maqh_enable(enable1hz),
.maqh_incremento(incrementa_hora),
.maqh_Lsd(bcd_h_Lsd),
.maqh_Msd(bcd_h_Msd));

display_7 display_h_Lsd(
.bcd_bcd_in(bcd_h_Lsd),
.bcd_display_out(h_Lsd));

display_7 display_h_Msd(
.bcd_bcd_in({2'd0,bcd_h_Msd}),
.bcd_display_out(h_Msd));

endmodule