// ============================================================================
// COMPAÑÍA: SILICON -28- SYNTHETICS
// MÓDULO EDUCATIVO: tutorial_mce_basics.v
// DESCRIPCIÓN: Guía práctica de componentes lógicos aplicados a la MCE.
//              Muestra cómo las compuertas y los registros (FF) guían al
//              Dubit de dualidad de forma determinista y sin azar cuántico.
// ============================================================================

module tutorial_mce_basics (
    input  wire        clk,            // El Reloj: Sincronizador de la frecuencia de red
    input  wire        rst_n,          // El Reset: Devuelve el muelle a su estado de reposo
    input  wire        onda_bit_0,     // Canal físico del Bit 0 (Modo Onda Guía)
    input  wire        particula_bit_1,// Canal físico del Bit 1 (Modo Coordenada Fija)
    output wire        dubit_conmutado,// Resultado de la dualidad lógica resultante
    output reg         registro_dubit  // El Flip-Flop: Almacenamiento elástico de fase
);

    // ========================================================================
    // CONCEPTO 1: LAS COMPUERTAS LÓGICAS (GATES) COMO RAÍLES DE DIFRACCIÓN
    // ========================================================================
    // En el silicio ordinario, una compuerta XOR es un interruptor que suma voltajes.
    // En Silicon -28- Synthetics, las compuertas son "Slots" o ranuras elásticas.
    // Hacen que la Onda y la Partícula interfieran físicamente entre sí.
    // No hay azar cuántico: si coinciden en fase, el Dubit cambia de estado.
    
    assign dubit_conmutado = onda_bit_0 ^ particula_bit_1; // Compuerta XOR determinista


    // ========================================================================
    // CONCEPTO 2: EL FLIP-FLOP / REGISTRO (FF) COMO MUELLE DE RETENCIÓN
    // ========================================================================
    // En la computación clásica, un Flip-Flop (FF) es un circuito biestable que 
    // atrapa electrones en un bucle cerrado, disipando calor de forma constante.
    //
    // En la MCE, el Flip-Flop es un "Muelle de Retención Mecánica":
    // 1. Aprovecha la viscoelasticidad intrínseca del sustrato de pureza 28.
    // 2. Al llegar el pulso de reloj (clk), el muelle "atrapa" la fase de la onda.
    // 3. Almacena el Dubit a temperatura ambiente sin consumir energía ni agua.
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Al activar el reset, el muelle libera la tensión acumulada (Fase 0)
            registro_dubit <= 1'b0;
        end else begin
            // En cada flanco de subida, el Flip-Flop congela y memoriza la 
            // dualidad onda-partícula actual, actuando como memoria continua.
            registro_dubit <= dubit_conmutado;
        end
    end

endmodule
