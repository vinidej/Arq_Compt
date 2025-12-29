#include <stdio.h>
#include <locale.h>

int somatorio_N(int N){
    if(N == 1) return 1;
    else return N + somatorio_N(N - 1);
}

int main(){
    setlocale(LC_ALL, "");
    int N;
    printf("Digite um número inteiro:\n");
    scanf("%d", &N);
    printf("O somatório de %d é %d", N, somatorio_N(N));
}
