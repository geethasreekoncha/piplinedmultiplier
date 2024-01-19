module halfadder(A,B,S,C);
    input wire A,B;
    output wire S,C;
    xor(S,A,B);
    and(C,A,B);
endmodule

module fulladder(A,B,Cin,S,Cout);
    input wire A,B,Cin;
    output wire S, Cout;
    wire Y1;
    wire Y2;
    wire Y3;
    halfadder ha1(A,B,Y1,Y2);
    halfadder ha2(Y1,Cin,S,Y3);
    or(Cout,Y3,Y2);
endmodule

module ripple_carry(A,B,Cin,S,Ov);
    input wire [7:0] A;
    input wire [7:0] B;
    input wire Cin;
    output wire [7:0] S;
    output wire Ov;
    wire [6:0] C;
    fulladder fa1(A[0],B[0],Cin, S[0],C[0]);
    fulladder fa2(A[1],B[1],C[0],S[1],C[1]);
    fulladder fa3(A[2],B[2],C[1],S[2],C[2]);
    fulladder fa4(A[3],B[3],C[2],S[3],C[3]);
    fulladder fa5(A[4],B[4],C[3],S[4],C[4]);
    fulladder fa6(A[5],B[5],C[4],S[5],C[5]);
    fulladder fa7(A[6],B[6],C[5],S[6],C[6]);
    fulladder fa8(A[7],B[7],C[6],S[7],Ov);
endmodule

module adder(A,B,Cin,S,Ov);
    input wire [15:0] A;
    input wire [15:0] B;
    input wire Cin;
    output wire [15:0] S;
    output wire Ov;
    wire Cout;
    ripple_carry rc1(A[7:0],B[7:0],Cin,S[7:0],Cout);
    ripple_carry rc2(A[15:8],B[15:8],Cout,S[15:8],Ov);
endmodule

module padder(A,b,Y);
    input wire [7:0] A;
    input wire b;
    output wire [15:0] Y;
    assign Y[0] = A[0] & b;
    assign Y[1] = A[1] & b;
    assign Y[2] = A[2] & b;
    assign Y[3] = A[3] & b;
    assign Y[4] = A[4] & b;
    assign Y[5] = A[5] & b;
    assign Y[6] = A[6] & b;
    assign Y[7] = A[7] & b;
    assign Y[8] = 1'b0;
    assign Y[9] = 1'b0;
    assign Y[10] = 1'b0;
    assign Y[11] = 1'b0;
    assign Y[12] = 1'b0;
    assign Y[13] = 1'b0;
    assign Y[14] = 1'b0;
    assign Y[15] = 1'b0;
endmodule

module unsigned_multiplier(A,B,P);
    input wire [7:0] A;
    input wire [7:0] B;
    output wire [15:0] P;
    wire [15:0] partial_product [7:0];
    wire [15:0] Y [7:0];
    parameter Cin = 1'b0;
    wire [7:0] Cout;
    wire [15:0] product [5:0];
    padder p1(A,B[0],Y[0]);
    padder p2(A,B[1],Y[1]);
    padder p3(A,B[2],Y[2]);
    padder p4(A,B[3],Y[3]);
    padder p5(A,B[4],Y[4]);
    padder p6(A,B[5],Y[5]);
    padder p7(A,B[6],Y[6]);
    padder p8(A,B[7],Y[7]);
  
    assign partial_product[0] = Y[0];  
    assign partial_product[1] = Y[1]<<1;
    assign partial_product[2] = Y[2]<<2;
    assign partial_product[3] = Y[3]<<3;
    assign partial_product[4] = Y[4]<<4;
    assign partial_product[5] = Y[5]<<5;
    assign partial_product[6] = Y[6]<<6;
    assign partial_product[7] = Y[7]<<7;

    adder a1(partial_product[0],partial_product[1],Cin,product[0],Cout[0]);
    adder a2(product[0], partial_product[2],Cout[0],product[1],Cout[1]);
    adder a3(product[1], partial_product[3],Cout[1],product[2],Cout[2]);
    adder a4(product[2], partial_product[4],Cout[2],product[3],Cout[3]);
    adder a5(product[3], partial_product[5],Cout[3],product[4],Cout[4]);
    adder a6(product[4], partial_product[6],Cout[4],product[5],Cout[5]);
    adder a7(product[5], partial_product[7],Cout[5],P,Cout[6]);
endmodule

module dff(input clk, input  [15:0] d, output reg [15:0] q);
    always @(posedge clk) 
        q <= d;

endmodule

module fir(input clk, input [7:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9 , output reg [15:0] Y);
	wire [7:0]	h [9:0];
	wire [15:0] m [9:0];
	wire [15:0] q [8:0];
    parameter Cin = 1'b0;
    wire [8:0] Cout;
    wire [15:0] add_out1,add_out2,add_out3,add_out4,add_out5,add_out6,add_out7,add_out8,add_out9;

	assign h[0] = 1;
	assign h[1] = 2;
	assign h[2] = 3;
	assign h[3] = 4;
	assign h[4] = 5;
	assign h[5] = 6;
	assign h[6] = 7;
	assign h[7] = 8;
	assign h[8] = 9;
	assign h[9] = 1;

    unsigned_multiplier m0(h[0], x0, m[0]);
    unsigned_multiplier m1(h[1], x1, m[1]);
    unsigned_multiplier m2(h[2], x2, m[2]);
    unsigned_multiplier m3(h[3], x3, m[3]);
    unsigned_multiplier m4(h[4], x4, m[4]);
    unsigned_multiplier m5(h[5], x5, m[5]);
    unsigned_multiplier m6(h[6], x6, m[6]);
    unsigned_multiplier m7(h[7], x7, m[7]);
    unsigned_multiplier m8(h[8], x8, m[8]);
    unsigned_multiplier m9(h[9], x9, m[9]);



    adder add1(q[0],m[1],Cin,add_out1, Cout[0]);
    adder add2(q[1],m[2],Cout[0],add_out2, Cout[1]);
    adder add3(q[2],m[3],Cout[1],add_out3, Cout[2]);
    adder add4(q[3],m[4],Cout[2],add_out4, Cout[3]);
    adder add5(q[4],m[5],Cout[3],add_out5, Cout[4]);
    adder add6(q[5],m[6],Cout[4],add_out6, Cout[5]);
    adder add7(q[6],m[7],Cout[5],add_out7, Cout[6]);
    adder add8(q[7],m[8],Cout[6],add_out8, Cout[7]);
    adder add9(q[8],m[9],Cout[7],add_out9, Cout[8]);

    dff dff1(clk,m[0],q[0]);
    dff dff2(clk,add_out1,q[1]);
    dff dff3(clk,add_out2,q[2]);
    dff dff4(clk,add_out3,q[3]);
    dff dff5(clk,add_out4,q[4]);
    dff dff6(clk,add_out5,q[5]);
    dff dff7(clk,add_out6,q[6]);
    dff dff8(clk,add_out7,q[7]);
    dff dff9(clk,add_out8,q[8]);

    always @(posedge clk) begin
        Y <= add_out9 ;
    end
endmodule

