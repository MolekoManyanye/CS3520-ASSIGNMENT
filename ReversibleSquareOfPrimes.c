#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <conio.h>

#include <math.h>

void printReversibleSquares();
int reverse(int number);
bool compare(int number1,int number2);
bool isPrime(int number);
bool isRootOfReversiblePrimeOfSquares(int number);
 

int main(int argc, char *argv[]) {

printReversibleSquares();	

	return 1;
}
int reverse(int number)
{
	int reversed=0;
	while(number>0)
	{
		reversed=reversed*10+(number%10);
		number=number/10;
	}
	return reversed;
}
bool compare(int number1,int number2)
{
	return(number1==number2);
}
bool isPrime(int number)
{
	//defaults a number to prime
	bool prime=true;
	if(number<2)
	{
		prime=false;
	}
	
	else{
		for (int i = 2; i <= number/2;i++)
    {
        if (number % i == 0)
        {
            prime=false;
        }
    }
	}
    
    return prime;
}

bool isRootOfReversiblePrimeOfSquares(int number)
{
	bool rootOfReversiblePrimeOfSquare=false;
	
	if(isPrime(number))
	{
		int squareNumber=number*number;
		int reversedSquareNumber=reverse(squareNumber);
		if(!compare(squareNumber,reversedSquareNumber))
		{
			
			int potentialSquareRootOfReversed=2;
			//already known that 1 and zero are not prime so no need to loop them in
			int maxPotentialSquareRootOfreversed=sqrt(reversedSquareNumber);
			while(potentialSquareRootOfReversed<=maxPotentialSquareRootOfreversed)
			{
				if(compare((potentialSquareRootOfReversed*potentialSquareRootOfReversed),reversedSquareNumber))
				{
					if(isPrime(potentialSquareRootOfReversed))
					{
						rootOfReversiblePrimeOfSquare=true;
					}
					
				}
				potentialSquareRootOfReversed++;
			}
		}
	}
	return(rootOfReversiblePrimeOfSquare);
}

void printReversibleSquares()
{
	
	int potentialRootOfReversibleSquareOfAprime=2,currentPosition=0;
	while(currentPosition<10)
	{
		
		if(isRootOfReversiblePrimeOfSquares(potentialRootOfReversibleSquareOfAprime))
		{
			int reversibleSquareOfPrime=potentialRootOfReversibleSquareOfAprime*potentialRootOfReversibleSquareOfAprime;
			//array[currentPosition]=reversibleSquareOfPrime;
			currentPosition++;
			printf("\n%d",reversibleSquareOfPrime);
		}
		potentialRootOfReversibleSquareOfAprime++;
	
	}
	
	
}
