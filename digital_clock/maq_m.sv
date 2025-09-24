module maq_m(
    input  logic maqm_clock,
    input  logic maqm_reset,
    input  logic maqm_enable,
    input  logic maqm_incremento,     // pulso vindo dos segundos
    output logic [3:0] maqm_Lsd,
    output logic [2:0] maqm_Msd,
    output logic maqm_incrementahora  // pulso para horas
);

    logic [3:0] Lsd_reg, Lsd_next;
    logic [2:0] Msd_reg, Msd_next;

    // Estado atual
    always_ff @(posedge maqm_clock or negedge maqm_reset) begin
        if (!maqm_reset) begin
            Lsd_reg <= 4'd9;
            Msd_reg <= 3'd5;
        end
        else if (maqm_enable && maqm_incremento) begin
            Lsd_reg <= Lsd_next;
            Msd_reg <= Msd_next;
        end
    end

    // Lógica combinacional
    always_comb begin
        Lsd_next = Lsd_reg;
        Msd_next = Msd_reg;

        if (Msd_reg == 3'd5 && Lsd_reg == 4'd9) begin
            Lsd_next = 4'd0;
            Msd_next = 3'd0;
        end
        else if (Lsd_reg == 4'd9) begin
            Lsd_next = 4'd0;
            Msd_next = Msd_reg + 1'b1;
        end
        else begin
            Lsd_next = Lsd_reg + 1'b1;
        end
    end

    // Saídas
    assign maqm_Lsd = Lsd_reg;
    assign maqm_Msd = Msd_reg;
    assign maqm_incrementahora = (Msd_reg == 3'd5 && Lsd_reg == 4'd9);

endmodule
