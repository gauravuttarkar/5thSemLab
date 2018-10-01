#include<stdio.h>
#include<omp.h>
#include<sys/time.h>
#include<stdlib.h>

int main()
{
	struct timeval TimeValue_Start;
	struct timezone TimeZone_Start;
	struct timeval TimeValue_Final;
	struct timezone TimeZone_Final;
	long time_start, time_end;
	double time_overhead;
	int n;
	scanf("%d",&n);
	int  a2[500], a3[1000];
	srand(0);
	int a1[n];
	for(int i = 0; i < n; i++)
		a1[n] = rand();
		
	for(int i = 0; i < 500; i++)
		a2[i] = rand();
	for(int i = 0; i < 1000; i++)
		a3[i] = rand();
	// for(int i = 0; i < 100; i++)
	// 	printf("%d\n", 1[i]);

	printf("Sequential:\n");
	gettimeofday(&TimeValue_Start, &TimeZone_Start);
	int smallest = a1[0];
	for(int i = 1; i < n; i++)
	{
		if(a1[i] < smallest)
			smallest = a1[i];
	}
	printf("%d\n", smallest);
	gettimeofday(&TimeValue_Final, &TimeZone_Final);
	time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
	time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
	time_overhead = (time_end - time_start)/1000000.0;
	printf("\n\n\tTime in Seconds (T) : %lf\n",time_overhead);

	smallest = a1[0];
	printf("Schedule static:\n");
	gettimeofday(&TimeValue_Start, &TimeZone_Start);
	#pragma omp parallel for schedule(static)
	for(int i = 1; i < n; i++)
	{
		if(a1[i] < smallest)
			smallest = a1[i];
	}
	printf("%d\n", smallest);
	gettimeofday(&TimeValue_Final, &TimeZone_Final);
	time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
	time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
	time_overhead = (time_end - time_start)/1000000.0;
	printf("\n\n\tTime in Seconds (T) : %lf\n\n",time_overhead);

	int chunk = 10;
	smallest = a1[0];
	printf("Schedule static chunk:\n");
	gettimeofday(&TimeValue_Start, &TimeZone_Start);
	#pragma omp parallel for schedule(static, chunk)
	for(int i = 1; i < n; i++)
	{
		if(a1[i] < smallest)
			smallest = a1[i];
	}
	printf("%d\n", smallest);
	gettimeofday(&TimeValue_Final, &TimeZone_Final);
	time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
	time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
	time_overhead = (time_end - time_start)/1000000.0;
	printf("\n\n\tTime in Seconds (T) : %lf\n\n",time_overhead);

	smallest = a1[0];
	printf("Schedule dynamic:\n");
	gettimeofday(&TimeValue_Start, &TimeZone_Start);
	#pragma omp parallel for schedule(dynamic)
	for(int i = 1; i < n; i++)
	{
		if(a1[i] < smallest)
			smallest = a1[i];
	}
	printf("%d\n", smallest);
	gettimeofday(&TimeValue_Final, &TimeZone_Final);
	time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
	time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
	time_overhead = (time_end - time_start)/1000000.0;
	printf("\n\n\tTime in Seconds (T) : %lf\n\n",time_overhead);

	smallest = a1[0];
	printf("Schedule guided:\n");
	gettimeofday(&TimeValue_Start, &TimeZone_Start);
	#pragma omp parallel for schedule(guided)
	for(int i = 1; i < n; i++)
	{
		if(a1[i] < smallest)
			smallest = a1[i];
	}
	printf("%d\n", smallest);
	gettimeofday(&TimeValue_Final, &TimeZone_Final);
	time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
	time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
	time_overhead = (time_end - time_start)/1000000.0;
	printf("\n\n\tTime in Seconds (T) : %lf\n\n",time_overhead);

	smallest = a1[0];
	printf("Schedule runtime:\n");
	gettimeofday(&TimeValue_Start, &TimeZone_Start);
	#pragma omp parallel for schedule(runtime)
	for(int i = 1; i < n; i++)
	{
		if(a1[i] < smallest)
			smallest = a1[i];
	}
	printf("%d\n", smallest);
	gettimeofday(&TimeValue_Final, &TimeZone_Final);
	time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
	time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
	time_overhead = (time_end - time_start)/1000000.0;
	printf("\n\n\tTime in Seconds (T) : %lf\n\n",time_overhead);

}