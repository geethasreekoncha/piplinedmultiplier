module testbench();
    reg signed [15:0] A;
    reg signed [15:0] B;
    wire Op;
    wire signed [15:0] S;
    wire On;
    subtractor DUT(A,B,S,Op,On);
    initial begin
        $monitor("time=%3d, A=%d, B=%d, S =%d, Op=%d, On=%d\n", $time, A, B, S, Op, On);
        A=192; B=-192;
    end
endmodule