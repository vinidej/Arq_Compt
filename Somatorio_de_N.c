#include <stdio.h>

int somatorio_N(int N){
    if(N == 1) return 1;
    else return N + somatorio_N(N - 1);
}

int main(){
    int N;
    printf("Digite um numero inteiro:\n");
    scanf("%d", &N);
    printf("O somatorio de %d é %d", N, somatorio_N(N));
}

