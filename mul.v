module halfadder(A,B,S,C);
    input A,B;
    output S,C;
    xor(S,A,B);
    and(C,A,B);
endmodule

module fulladder(A,B,Cin,S,Cout);
    input A,B,Cin;
    output S, Cout;
    wire Y1;
    wire Y2;
    wire Y3;
    halfadder ha1(A,B,Y1,Y2);
    halfadder ha2(Y1,Cin,S,Y3);
    or(Cout,Y3,Y2);
endmodule

module subtractor(A,B,S,Op,On);
    input signed [15:0] A;
    input signed[15:0] B;
    output signed[15:0] S;
    output Op, On;
    parameter Cin=1'b1;
    wire [15:0] C;
    wire V;
    fulladder fa1(A[0],~B[0],Cin, S[0],C[0]);
    fulladder fa2(A[1],~B[1],C[0],S[1],C[1]);
    fulladder fa3(A[2],~B[2],C[1],S[2],C[2]);
    fulladder fa4(A[3],~B[3],C[2],S[3],C[3]);
    fulladder fa5(A[4],~B[4],C[3],S[4],C[4]);
    fulladder fa6(A[5],~B[5],C[4],S[5],C[5]);
    fulladder fa7(A[6],~B[6],C[5],S[6],C[6]);
    fulladder fa8(A[7],~B[7],C[6],S[7],C[7]);
    fulladder fa9(A[8],~B[8],C[7], S[8],C[8]);
    fulladder fa10(A[9],~B[9],C[8],S[9],C[9]);
    fulladder fa11(A[10],~B[10],C[9],S[10],C[10]);
    fulladder fa12(A[11],~B[11],C[10],S[11],C[11]);
    fulladder fa13(A[12],~B[12],C[11],S[12],C[12]);
    fulladder fa14(A[13],~B[13],C[12],S[13],C[13]);
    fulladder fa15(A[14],~B[14],C[13],S[14],C[14]);
    fulladder fa16(A[15],~B[15],C[14],S[15],C[15]);
    xor(V,C[15],C[14]);
    assign Op = (V & ~C[15]);
    assign On = (V & C[15]);


endmodule