`timescale 1ns / 1ps

module tb_seq_detector_mealy;

    reg clk;
    reg reset;
    reg din;
    wire detected;

    // Instantiate the sequence detector
    seq_detector_mealy uut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .detected(detected)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        reset = 1; din = 0;
        #15;
        reset = 0;

        // Apply input sequence with some patterns including the target sequence 1011
        // bit input applied on each rising edge of clk

        // Input bits: 1 0 1 1 (should detect at last bit)
        @(posedge clk); din = 1;
        @(posedge clk); din = 0;
        @(posedge clk); din = 1;
        @(posedge clk); din = 1;  // detected should assert here
        @(posedge clk); din = 0;

        // Random bits with overlapping sequence 1011 (testing overlap)
        @(posedge clk); din = 1;
        @(posedge clk); din = 0;
        @(posedge clk); din = 1;
        @(posedge clk); din = 1;  // detected again here

        // Another sequence without detection
        @(posedge clk); din = 0;
        @(posedge clk); din = 0;
        @(posedge clk); din = 1;
        @(posedge clk); din = 0;

        // Finish simulation
        #20;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | din=%b | detected=%b", $time, din, detected);
    end

endmodule
