#include<stdio.h>
#include<omp.h>

int main()
{
	int n;
	scanf("%d", &n);
	int a[n][2];
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < 2; j++)
			scanf("%d", &a[i][j]);
	}

	int sum = 0;
	#pragma omp parallel num_threads(4)
	{
		#pragma omp for reduction(+:sum)
		for(int i = 0; i < n; i++)
		{
			int income = a[i][1];
			int inc = (income * 6) / 100;
			income += inc;
			sum += inc;
			if ( income > 5000 ){
				sum = sum + ( 2 * ( income - 5000) / 100 );
			}
		}
	}
	printf("%d", sum);
}