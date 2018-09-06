#include<stdio.h>
#include<omp.h>

int main(){
	int n;
	printf("Enter the value of n\n");
	scanf("%d",&n);

	int a[n][n];

	int i,j;
	// #pragma omp parallel num_threads(4)
	// {
	// #pragma omp for 
		for(i=0;i<n;i++)
			for(j=0;j<n;j++){
				scanf("%d",&a[i][j]);
			}

	//}


	int sum=0,column=0;
	j = 0;
	#pragma omp parallel num_threads(4) private(j)
	{
		
		#pragma omp for
		//#pragma omp for
		
		for(i=0;i<n;i++){
			sum = 0;
			column = 0;
			for(j=0;j<n;j++){
				printf("%d %d\n",i,j);
				sum += a[i][j];
				column += a[j][i];
			}
			// sum = 0;
			// column = 0;
			printf("Sum of column %d is %d\n",i,column);
			printf("Sum of row %d is %d\n",i,sum);	
			sum = 0;
			column = 0;
		}
		

		// #pragma omp barrier		
	
		// #pragma omp for	
		// for(i=0;i<n;i++){
		// 	printf("Sum of column %d is %d",i,column[i]);
		// 	printf("Sum of row %d is %d",i,sum[i]);
		// }
	}



}

