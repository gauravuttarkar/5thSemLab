import pandas as pd
import numpy as np
import math
import heapq

pdd=pd.read_csv("SPECT.csv")
pdd.sample(frac=1)
pdd = pdd.sample(frac=1).reset_index(drop=True)
df=pdd.values
print(df)
print(type(df))
n=df.shape[0]
print(df.shape)
print(n)
size=df.shape[1]-1
y=[]
k=3
ytrain=[]
ytest=[]
pddtrain=[]
pddtest=[]

def distance(train,test):
	sum=0
	for i in range(len(train)):
		sum += pow(train[i]-test[i],2)
	return math.sqrt(sum)	

	
def accuracy():
	global ytest,w1,w2,pddtest,lrate,bias2,bias1,k,pddtrain,ytrain
	tp=tn=fn=fp=0
	for i in range(pddtest.shape[0]):
		head=[]
		for j in range(pddtrain.shape[0]):
			dist=distance(pddtrain[j],pddtest[i])
			head.append((dist,ytrain[j]))	
		heapq.heapify(head)
		zero=0
		one=0
		for kk in range(k):
			item = heapq.heappop(head)
			if item[1]==0:
				zero+=1
			else:
				one+=1
		if zero>=one:
			result=0
		else:
			result=1			
		if ytest[i]==1 and result==1:
			tp+=1
		elif ytest[i]==1:
			fn+=1
		elif ytest[i]==0 and result==0:
			tn+=1
		else:
			fp+=1			
	print(tp,fn,fp,tn)		
	return [tp,fn,fp,tn]	

def kfoldcv(nfolds):
	global n,ytrain,ytest,df,pddtrain,pddtest,size
	acc=0
	l=0
	avgacc=0.0
	setsize=(n//nfolds)
	err=0
	k=(n//nfolds)
	i=1
	j=k
	while j<n:
		pddtrain=np.concatenate((df[:i],df[j:]),axis=0)
		ytrain=y[:i]+y[j:]
		ytest=y[i:j]
		pddtest=df[i:j]
		i=j
		j=j+k
		racc=accuracy()
		acc1=(1.0*racc[0]+racc[3])/(racc[0]+racc[1]+racc[2]+racc[3])
		if acc<=acc1:
			acc=acc1		
		avgacc+=acc1
		l+=1
		tpr=(racc[0]*1.0)/(racc[0]+racc[1])
		tnr=(racc[3]*1.0)/(racc[3]+racc[2])
		fpr=(racc[2]*1.0)/(racc[2]+racc[3])
		fnr=(racc[1]*1.0)/(racc[1]+racc[0])
		print("tpr is :",tpr)
		print("tnr is :",tnr)
		print("fpr is :",fpr)
		print("fnr is :",fnr)
		print('accuracy is :',acc1,'best accuracy till now: ',acc)
		print("########################################################################")				
	return [(avgacc*1.0)/l, acc]	

k=9
for i in range(n):
	if df[i][0]=="No":
		y.append(0)
	else:
		y.append(1)
df=np.delete(df, 0, 1)		
acc=kfoldcv(10)		
print("average accuracy is =",acc[0],"best accuracy: ",acc[1])				
#print(df)