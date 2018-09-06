#include<stdio.h>
#include<omp.h>
void main()
{
	int n;
	printf("Enter the size of the array\n");
	scanf("%d",&n);

	int i,j;
	int arr[n];

	for(i=0;i<n;i++){
		scanf("%d",&arr[i]);
	}
	int sum = 0;
	#pragma omp parallel num_threads(4)
	{
		#pragma omp for reduction(+:sum)

			for(i=0;i<n;i++)
				sum += arr[i];
	
	}

	printf("Sum is %d\n",sum);

	//printf("Done");
}