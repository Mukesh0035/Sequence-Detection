module seq_detector_mealy(
    input clk,
    input reset,
    input din,
    output reg detected
);

    typedef enum reg [2:0] {
        S0, S1, S2, S3
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        detected = 0;
        case(state)
            S0: begin
                if (din) next_state = S1; else next_state = S0;
            end
            S1: begin
                if (!din) next_state = S2; else next_state = S1;
            end
            S2: begin
                if (din) begin
                    next_state = S3;
                    detected = 0;
                end else
                    next_state = S0;
            end
            S3: begin
                if (din) begin
                    detected = 1;  // Sequence detected here (1011)
                    next_state = S1; // allow overlapping sequences
                end else begin
                    detected = 0;
                    next_state = S2;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule
