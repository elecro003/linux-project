#include <stdio.h>

int main() {
    double a, b;
    char op;

    printf("=== C 계산기 ===\n");
    printf("형식 예: 3 + 5\n");
    printf("입력: ");

    if (scanf("%lf %c %lf", &a, &op, &b) != 3) {
        printf("입력 오류!\n");
        return 1;
    }

    double result;

    switch (op) {
        case '+': result = a + b; break;
        case '-': result = a - b; break;
        case '*': result = a * b; break;
        case '/':
            if (b == 0) {
                printf("❌ 0으로 나눌 수 없습니다.\n");
                return 1;
            }
            result = a / b;
            break;
        default:
            printf("지원하지 않는 연산자입니다.\n");
            return 1;
    }

    printf("결과: %.3f\n", result);
    return 0;
}
