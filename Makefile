knapsack.out: knapsack.o main.o
	gcc -g -Wall -m32 -o knapsack.out knapsack.o main.o

	
knapsack.o: knapsack.s
	gcc -g -Wall -m32 -c -o knapsack.o knapsack.s
	
	
main.o: main.c
	gcc -g -Wall -m32 -c -o main.o main.c
	
clean:
	rm *.o *.out
