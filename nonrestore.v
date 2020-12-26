module full_adder(input wire a, b, cin, output wire o, cout);
    xor3 xor3_inst0(a,b,cin,o);
    wire [0:2] t;
    and2 and2_inst0(a,b,t[0]);
    and2 and2_inst1(a,cin,t[1]);
    and2 and2_inst2(b,cin,t[2]);
    or3 or3_inst0(t[1],t[0],t[2], cout);
endmodule

module csa(input wire a, b, cin, ctrl, output wire o, cout);
    wire t;
    xor2 xor2_inst0(a, ctrl, j);
    full_adder full_adder_inst0(j,b,cin,o,cout);
endmodule

module csa_16bit(input wire [15:0] M, T, input wire D, ctrl, output wire Q, output wire [15:0] R);
    wire [14:0] temp;
    csa csa_inst0(M[0], D, ctrl, ctrl, R[0], temp[0]);
    csa csa_inst1(M[1], T[0], temp[0], ctrl, R[1], temp[1]);
    csa csa_inst2(M[2], T[1], temp[1], ctrl, R[2], temp[2]);
    csa csa_inst3(M[3], T[2], temp[2], ctrl, R[3], temp[3]);
    csa csa_inst4(M[4], T[3], temp[3], ctrl, R[4], temp[4]);
    csa csa_inst5(M[5], T[4], temp[4], ctrl, R[5], temp[5]);
    csa csa_inst6(M[6], T[5], temp[5], ctrl, R[6], temp[6]);
    csa csa_inst7(M[7], T[6], temp[6], ctrl, R[7], temp[7]);
    csa csa_inst8(M[8], T[7], temp[7], ctrl, R[8], temp[8]);
    csa csa_inst9(M[9], T[8], temp[8], ctrl, R[9], temp[9]);
    csa csa_inst10(M[10], T[9], temp[9], ctrl, R[10], temp[10]);
    csa csa_inst11(M[11], T[10], temp[10], ctrl, R[11], temp[11]);
    csa csa_inst12(M[12], T[11], temp[11], ctrl, R[12], temp[12]);
    csa csa_inst13(M[13], T[12], temp[12], ctrl, R[13], temp[13]);
    csa csa_inst14(M[14], T[13], temp[13], ctrl, R[14], temp[14]);
    csa csa_inst15(M[15], T[14], temp[14], ctrl, R[15], Q);
endmodule

module correction_FA(input wire a, b, c, d, output wire out,cout);
    wire j;
    and2 and2_inst0(b,c,j);
    full_adder full_adder_inst0(a,j,d,out,cout);
endmodule

module remainder_correction_csa(input wire [15:0] M, T, input wire D, ctrl, output wire Q, output wire [15:0] R);
    wire [15:0] temp, r;
    csa csa_inst0(M[0], D, ctrl, ctrl, r[0], temp[0]);
    csa csa_inst1(M[1], T[0], temp[0], ctrl, r[1], temp[1]);
    csa csa_inst2(M[2], T[1], temp[1], ctrl, r[2], temp[2]);
    csa csa_inst3(M[3], T[2], temp[2], ctrl, r[3], temp[3]);
    csa csa_inst4(M[4], T[3], temp[3], ctrl, r[4], temp[4]);
    csa csa_inst5(M[5], T[4], temp[4], ctrl, r[5], temp[5]);
    csa csa_inst6(M[6], T[5], temp[5], ctrl, r[6], temp[6]);
    csa csa_inst7(M[7], T[6], temp[6], ctrl, r[7], temp[7]);
    csa csa_inst8(M[8], T[7], temp[7], ctrl, r[8], temp[8]);
    csa csa_inst9(M[9], T[8], temp[8], ctrl, r[9], temp[9]);
    csa csa_inst10(M[10], T[9], temp[9], ctrl, r[10], temp[10]);
    csa csa_inst11(M[11], T[10], temp[10], ctrl, r[11], temp[11]);
    csa csa_inst12(M[12], T[11], temp[11], ctrl, r[12], temp[12]);
    csa csa_inst13(M[13], T[12], temp[12], ctrl, r[13], temp[13]);
    csa csa_inst14(M[14], T[13], temp[13], ctrl, r[14], temp[14]);
    csa csa_inst15(M[15], T[14], temp[14], ctrl, r[15], temp[15]);
    assign Q = temp[15];
    wire [15:0] t;
    correction_FA correction_FA_inst0(r[15],r[15],temp[14],1'b0, R[15],t[0]);
    correction_FA correction_FA_inst1(r[14],r[15],temp[13],t[0], R[14],t[1]);
    correction_FA correction_FA_inst2(r[13],r[15],temp[12],t[1], R[13],t[2]);        
    correction_FA correction_FA_inst3(r[12],r[15],temp[11],t[2], R[12],t[3]);        
    correction_FA correction_FA_inst4(r[11],r[15],temp[10],t[3], R[11],t[4]);        
    correction_FA correction_FA_inst5(r[10],r[15],temp[9],t[4], R[10],t[5]);        
    correction_FA correction_FA_inst6(r[9],r[15],temp[8],t[5], R[9],t[6]);        
    correction_FA correction_FA_inst7(r[8],r[15],temp[7],t[6], R[8],t[7]);        
    correction_FA correction_FA_inst8(r[7],r[15],temp[6],t[7], R[7],t[8]);        
    correction_FA correction_FA_inst9(r[6],r[15],temp[5],t[8], R[6],t[9]);        
    correction_FA correction_FA_inst10(r[5],r[15],temp[4],t[9], R[5],t[10]);        
    correction_FA correction_FA_inst11(r[4],r[15],temp[3],t[10], R[4],t[11]);        
    correction_FA correction_FA_inst12(r[3],r[15],temp[2],t[11], R[3],t[12]);        
    correction_FA correction_FA_inst13(r[2],r[15],temp[1],t[12], R[2],t[13]);        
    correction_FA correction_FA_inst14(r[1],r[15],temp[0],t[13], R[1],t[14]);        
    correction_FA correction_FA_inst15(r[0],r[15],ctrl,t[14], R[0],t[15]);                
endmodule

module non_restoring_divider(input wire [15:0] Q, M, output wire [15:0] quo, r);
    wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
    //wire [15:0] quo;
    csa_16bit csa_16bit_inst0(M, 16'b0, Q[15], 1'b1, quo[15], r0);
    csa_16bit csa_16bit_inst1(M, r0, Q[14], quo[15], quo[14],r1);
    csa_16bit csa_16bit_inst2(M, r1, Q[13], quo[14], quo[13],r2);
    csa_16bit csa_16bit_inst3(M, r2, Q[12], quo[13], quo[12],r3);
    csa_16bit csa_16bit_inst4(M, r3, Q[11], quo[12], quo[11],r4);
    csa_16bit csa_16bit_inst5(M, r4, Q[10], quo[11], quo[10],r5);
    csa_16bit csa_16bit_inst6(M, r5, Q[9], quo[10], quo[9],r6);
    csa_16bit csa_16bit_inst7(M, r6, Q[8], quo[9], quo[8],r7);
    csa_16bit csa_16bit_inst8(M, r7, Q[7], quo[8], quo[7],r8);
    csa_16bit csa_16bit_inst9(M, r8, Q[6], quo[7], quo[6],r9);
    csa_16bit csa_16bit_inst10(M, r9, Q[5], quo[6], quo[5],r10);
    csa_16bit csa_16bit_inst11(M, r10, Q[4], quo[5], quo[4],r11);
    csa_16bit csa_16bit_inst12(M, r11, Q[3], quo[4], quo[3],r12);
    csa_16bit csa_16bit_inst13(M, r12, Q[2], quo[3], quo[2],r13);
    csa_16bit csa_16bit_inst14(M, r13, Q[1], quo[2], quo[1],r14);
    //csa_16bit csa_16bit_inst15(M, r14, Q[0], quo[1], quo[0],r);
    remainder_correction_csa csa_16bit_inst15(M, r14, Q[0], quo[1], quo[0],r);
    //assign q = quo;
endmodule

module testbench;
    reg [15:0] Q, M;
    wire [15:0] quo, rem;
    non_restoring_divider inst1(Q,M,quo,rem);
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,testbench); //0,1
    end

    initial begin
    $monitor (Q,M,quo,rem);
    Q = 16'd13869;
    M = 16'd900;
    #10
    Q = 16'd901;
    M = 16'd300;
    #10
    Q = 16'd6200;
    M = 16'd1598;
    #10
    Q = 16'd9801;
    M = 16'd310;
    #10
    Q = 16'd15;
    M = 16'd3;
    #10
    Q = 16'd21;
    M = 16'd20;
    #10
    Q = 16'd3000;
    M = 16'd2000;
    #10
    Q = 16'd40000;
    M = 16'd12000;

    end
endmodule