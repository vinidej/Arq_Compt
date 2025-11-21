module full_adder_1bit(
    output s,
    output cout,
    input a,
    input b,
    input cin
);
    // fiz a descricao dataflow (mais simples)
    //assign {cout,s} = a+b+cin;

    // faz voce a descricao estrutural :)
    
    wire nA,nB,nC,nCin,a1,a2,a3,a4; 

    not n1 (nA,a);
    not n2 (nB,b);
    not n4 (nCin,cin);
    and and1 (a1,nA,b,cin);
    and and2 (a2, a, nB,cin);
    and and3 (a3,a,b,nCin);
    and and4 (a4,a,b,cin);
    or o1(cout,a1,a2,a3,a4);
    xor x1 (s, a, b, cin);

endmodule