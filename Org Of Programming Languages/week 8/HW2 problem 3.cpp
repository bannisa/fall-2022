#include <stdio.h>

bool isPrime(int);

int main() {
	int num;
	char tmp;
	bool done = false;
	while (!done) {
		printf("\nEnter a number to test to see if it's prime or 0 to exit:");
		scanf("%d", &num);
		scanf("%c", &tmp);
		if (num > 0) {
			if (isPrime(num)) {
				printf("The number is prime!!\n");
			}
			else {
				printf("The number is not prime\n");
			}
		}
		else if (num == 0) {
			done = true;
		}
	}
	return 0;
}

bool isPrime(int num) {
	if (num == 1 || num == 2 || num == 3)
		return true;

	for (int i = (int) num / 2; i > 1; i--) {
		if (num % i == 0) {
			return false;
		}
	}

	return true;
}