module enable_1hz(
    input  enable_clock,
    input  enable_reset,
    output logic enable_pulseout
);

logic [2:0] contador;  // só precisa de 3 bits agora

always_ff @(posedge enable_clock) begin
    if(!enable_reset)
        contador <= 3'd0;
    else if(contador == 3'd4)   // conta 0,1,2,3,4 -> 5 ciclos
        contador <= 3'd0;
    else
        contador <= contador + 3'd1;
end

always_comb 
    enable_pulseout = (contador == 3'd4);

endmodule
