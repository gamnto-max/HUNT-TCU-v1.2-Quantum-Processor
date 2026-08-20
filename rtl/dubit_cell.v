// ============================================================================
// COMPAÑÍA: SILICON -28- SYNTHETICS
// ARQUITECTURA: IP CORE HUNT-TCU v1.2
// MÓDULO: dubit_cell.v
// DESCRIPCIÓN: Celda lógica elemental de Dualidad. Conmuta entre Estado 0 
//              (Onda Guía) y Estado 1 (Partícula) controlando el umbral óptico.
// ============================================================================

module dubit_cell (
    input  wire        clk,          // Frecuencia de reloj de la malla
    input  wire        rst_n,        // Reinicio elástico del sistema
    input  wire        laser_en,     // Activación del láser tenue
    input  wire [15:0] laser_power,  // Potencia parametrizada (Calibrado a 0.4 uW)
    input  wire [31:0] entrada_fase, // Flujo de ondas de datos entrantes
    output reg  [31:0] salida_dubit, // Salida determinista del bit de dualidad
    output reg         colapso_error // Alerta de cizallamiento (Exceso de potencia fotónica)
);

    // Parámetro inmutable de seguridad: Umbral crítico de 0.4 uW expresado en código entero
    localparam [15:0] UMBRAL_CRITICO_04UW = 16'h0190; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            salida_dubit  <= 32'h00000000;
            colapso_error <= 1'b0;
        end else begin
            if (laser_en) begin
                if (laser_power > UMBRAL_CRITICO_04UW) begin
                    // El fotón actúa como un misil mecánico destructivo por exceso de vatios
                    salida_dubit  <= 32'hFFFFFFFF; 
                    colapso_error <= 1'b1; // Alerta de dispersión caótica: Vete a buscar la partícula
                end else begin
                    // Acoplamiento armónico exitoso por debajo de los 0.4 uW
                    salida_dubit  <= entrada_fase ^ (entrada_fase >> 2) + 32'hD4AF37;
                    colapso_error <= 1'b0;
                end
            end else begin
                // Fase latente pasiva sin inyección lumínica
                salida_dubit  <= entrada_fase;
                colapso_error <= 1'b0;
            end
        end
    end

endmodule
