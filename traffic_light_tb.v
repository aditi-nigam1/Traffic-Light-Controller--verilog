`timescale 1ns / -1ps

module trafficlight1_tb;

    reg clk;
    reg rst;

    wire [1:0] north_light;
    wire [1:0] west_light;
    wire [1:0] south_light;
    wire [1:0] east_light;

    // DUT instantiation
    trafficlight1 dut (
        .clk(clk),
        .rst(rst),
        .north_light(north_light),
        .west_light(west_light),
        .south_light(south_light),
        .east_light(east_light)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        clk = 0;
        rst = 1;

        // Hold reset for few cycles
        #20;
        rst = 0;

        // Run simulation long enough to see full cycle
        #10000000000000000;

        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time | N  W  S  E");
        $monitor("%4t | %b  %b  %b  %b",
                 $time,
                 north_light,
                 west_light,
                 south_light,
                 east_light);
    end

    // Dump waveform
    initial begin
        $dumpfile("trafficlight1.vcd");
        $dumpvars(0, trafficlight1_tb);
    end

endmodule