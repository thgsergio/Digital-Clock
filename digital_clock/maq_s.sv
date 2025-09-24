module maq_s(
    input  logic maqs_clock,
    input  logic maqs_reset,
    input  logic maqs_enable,
    output logic [3:0] maqs_Lsd,       
    output logic [2:0] maqs_Msd,       
    output logic maqs_addminuto        
);

    // Estado atual
    logic [3:0] Lsd_reg, Lsd_next;
    logic [2:0] Msd_reg, Msd_next;

    // Lógica sequencial
    always_ff @(posedge maqs_clock or negedge maqs_reset) begin
        if (!maqs_reset) begin
            Lsd_reg <= 4'd0;
            Msd_reg <= 3'd0;
        end
        else if (maqs_enable) begin
            Lsd_reg <= Lsd_next;
            Msd_reg <= Msd_next;
        end
    end

    // Lógica combinacional (próximo estado)
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
    assign maqs_Lsd = Lsd_reg;
    assign maqs_Msd = Msd_reg;
    assign maqs_addminuto = (Msd_reg == 3'd5 && Lsd_reg == 4'd9);

endmodule
