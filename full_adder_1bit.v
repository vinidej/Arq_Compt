module full_adder_1bit(
    output s,
    output cout,
    input a,
    input b,
    input cin
);
    //Para fazer esse modulo fiz a tabela verdade de um ADD, converti para mapa K e extrai o circuito simplificado.
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
