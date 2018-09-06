#include<omp.h>
#include<stdio.h>
#include<stdlib.h>

#define CHUNKSIZE 5
#define N 1000000
#define THREADS 8
int main (int argc, char *argv[]) {
	int nthreads, tid, i, chunk;
	float a[N], b[N], c[N];
	int count = 0;
		int arr[THREADS];
	omp_set_num_threads(THREADS);
	for (i=0; i < N; i++)
		a[i] = b[i] = i * 1.0; // initialize arrays
	chunk = CHUNKSIZE;
	#pragma omp parallel shared(count,a,b,c,nthreads,chunk,arr) private(i,tid) 
	{
	tid = omp_get_thread_num();
	if (tid == 0)
	{
	nthreads = omp_get_num_threads();
	// printf("Number of threads = %d\n", nthreads);
	printf("Number of threads = %d\n", nthreads);
	}
	// printf("Thread %d starting...\n",tid);
	printf("Thread %d starting...\n",tid);

	#pragma omp for schedule(runtime)
	for (i=0; i<N;i++)
		{
			c[i]=a[i]+b[i];
			// printf("\n");(“Thread %d: c[%d]=%f\n”,tid,i,c[i]);
			arr[tid]+=1;
			//printf("Thread %d: c[%d]=%f\n",tid,i,c[i]);
		}
	} /*end of parallel section*/
	//printf("%d",count);
	int j;
	for(j=0;j<THREADS;j++){
		printf("%d\n",arr[j]);
	}
}		