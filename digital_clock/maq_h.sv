module maq_h(
    input  logic maqh_clock,
    input  logic maqh_reset,
    input  logic maqh_enable,
    input  logic maqh_incremento_min,
    input  logic maqh_incremento_seg,
    output logic [3:0] maqh_Lsd,
    output logic [1:0] maqh_Msd
);

    logic [3:0] Lsd_reg, Lsd_next;
    logic [1:0] Msd_reg, Msd_next;

    // Pulso de incremento da hora -> quando estamos em 59 min e 59 seg
    logic maqh_incremento;
    assign maqh_incremento = (maqh_incremento_min && maqh_incremento_seg);

    // Estado atual
    always_ff @(posedge maqh_clock or negedge maqh_reset) begin
        if (!maqh_reset) begin
            Lsd_reg <= 4'd0;
            Msd_reg <= 2'd0;
        end
        else if (maqh_enable && maqh_incremento) begin
            Lsd_reg <= Lsd_next;
            Msd_reg <= Msd_next;
        end
    end

    // Lógica combinacional
    always_comb begin
        Lsd_next = Lsd_reg;
        Msd_next = Msd_reg;

        // Caso: 23 → 00
        if (Msd_reg == 2'd2 && Lsd_reg == 4'd3) begin
            Lsd_next = 4'd0;
            Msd_next = 2'd0;
        end
        // Caso: passou de 9 unidades (quando dezena < 2)
        else if (Lsd_reg == 4'd9 && Msd_reg < 2) begin
            Lsd_next = 4'd0;
            Msd_next = Msd_reg + 1'b1;
        end
        // Caso: passou de 3 unidades (quando dezena == 2)
        else if (Msd_reg == 2'd2 && Lsd_reg == 4'd3) begin
            Lsd_next = 4'd0;
            Msd_next = 2'd0;
        end
        // Incremento normal
        else begin
            Lsd_next = Lsd_reg + 1'b1;
        end
    end

    // Saídas
    assign maqh_Lsd = Lsd_reg;
    assign maqh_Msd = Msd_reg;

endmodule
