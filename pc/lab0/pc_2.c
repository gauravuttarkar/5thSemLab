#include<omp.h>
#include<stdio.h>
// int main()
// {
// int x=0;
// #pragma omp parallel shared(x)
// 	{
// 	int tid=omp_get_thread_num();
// 	x=x+1;
// 	printf(“Thread %d value of x is %d”,tid,x);
// 	}
// }
int main()
{
	int x = 0;
	#pragma omp parallel shared(x)
	{
		int tid = omp_get_thread_num();
		x++;
		printf("Thread %d \n value of x is %d\n",tid,x);
	}
	return 0;
}
