module tb();
	reg clk;
	reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9;
	wire [15:0] Y;
	fir dut(clk,x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,Y);
	initial clk =0;
	always #5 clk =~clk;
	initial begin
	    $dumpfile("waveforms.vcd");
        $dumpvars(0, tb);
		x0 = 0;
		x1 = 16;
		x2 = 8;
		x3 = 4 ;
		x4 = 14;
		x5 = 12;
		x6 = 18;
		x7 = 3;
		x8 = 5;
		x9 = 6;
		#100;
	    $finish;
    end
	always @(posedge clk) begin
        $monitor("At time = %t, clk = %b, Y = %d",  $time, clk, Y);
    end

endmodule
