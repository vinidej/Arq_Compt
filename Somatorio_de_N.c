#include <stdio.h>

int somatorio_N(int N){
    if(N == 1) return 1;
    else return N + somatorio_N(N - 1);
}

int main(){
    int N;
    scanf("%d", &N);
    int j = somatorio_N(N);
    printf("%d\n", j);
    for(int i = j; i >= 0; i--){
        printf("%d\n", i);
    }
}

