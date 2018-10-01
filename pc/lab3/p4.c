#include<stdio.h>
#include<omp.h>

int main()
{
	int n;
	scanf("%d", &n);
	int a[n][n], b[n][n], c[n][n];
	for(int i = 0; i < n; i++)
		for(int j = 0; j < n; j++)
			scanf("%d", &a[i][j]);

	for(int i = 0; i < n; i++)
		for(int j = 0; j < n; j++)
			scanf("%d", &b[i][j]);

	int sum = 0, tid;
	#pragma omp parallel num_threads(4) shared(a, b, c)
	{
		#pragma omp for reduction(+:sum)
		for(int i = 0; i < n; i++)
		{
			for(int j = 0; j < n; j++)
			{
				tid = omp_get_thread_num();
				for(int k = 0; k < n; k++)
					sum += a[i][k] * b[k][j];
				c[i][j] = sum;
				sum = 0;
				// printf("%d %d by %d\n", i, j, tid);
			}
		}
	}

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
			printf("%d ", c[i][j]);
		printf("\n");
	}
}