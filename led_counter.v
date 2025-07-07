module Counter #(
    parameter CLK_FREQ = 25_000_000
) (
    input  wire clk,
    input  wire rst_n,
    output reg [7:0] leds
);

    reg [7:0] counter;
    reg [31:0] clock_counter;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 8'b0;
            clock_counter <= 32'b0;
            leds <= 8'b0;
        end
        else begin
            if (clock_counter < CLK_FREQ - 1) begin
                clock_counter <= clock_counter + 1;
            end
            else begin
                // Passou 1 segundo - reinicia o contador e incrementa o valor dos LEDs
                clock_counter <= 32'b0;
                counter <= counter + 1;
                leds <= counter + 1; // Atualiza os LEDs com o novo valor
            end
        end
    end

endmodule