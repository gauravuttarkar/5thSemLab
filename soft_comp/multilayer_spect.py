import pandas as pd
import numpy as np
import math

pdd=pd.read_csv("SPECT.csv")
pdd.sample(frac=1)
pdd = pdd.sample(frac=1).reset_index(drop=True)
df=pdd.values
n=df.shape[0]
size=df.shape[1]-1
w1=[[(1.0/(size*5.0))]*(size) for i in range(5)]
w2=[(1.0/5.0)]*(5)
i1=[0]*5
o1=[0]*5
err1=[0]*5
bias1=[1/6]*5
bias2=1/6
y=[]
ytrain=[]
ytest=[]
pddtrain=[]
pddtest=[]
lrate=0.2
finalw1=[]
finalw2=[]

def initialise():
	global ytrain,ytest,w1,w2,i1,ol,err1,bias1,bias2,pddtest,pddtrain,n,df,size
	bias1=[1/6]*5
	bias2=1/6
	w1=[[(1.0/(size*5.0))]*(size) for i in range(5)]
	w2=[(1.0/5.0)]*(5)
	i1=[0]*5
	o1=[0]*5
	err1=[0]*5


def wxx(wx):
	ww=1/(1+math.exp(-wx))
	return ww

def wxxx(wx):
	ww=1/(1+math.exp(-wx))
	if ww>0.5:
		return 1
	return 0	

def oneiteration():
	global ytrain,w1,w2,pddtrain,lrate,i1,o1,err1,bias2,bias1
	serror=0
	for i in range(pddtrain.shape[0]):
		error1=0
		for ii in range(5):
			i1[ii]=bias1[ii]
			for j in range(size):
				i1[ii]+=pddtrain[i][j]*w1[ii][j]
			o1[ii]=wxx(i1[ii])
		wx=bias2
		for ii in range(5):
			wx+=o1[ii]*w2[ii]
		output=wxx(wx)
		error1=ytrain[i]-wxxx(wx)
		error=output*(1-output)*(ytrain[i]-output)
		for ii in range(5):
			err1[ii]=o1[ii]*(1-o1[ii])*(error*w2[ii])
		for ii in range(5):
			w2[ii]+=(lrate*o1[ii]*error)
		bias2+=lrate*error
		for ii in range(5):
			for j in range(size):
				w1[ii][j]+=(lrate*err1[ii]*pddtrain[i][j])
			bias1[ii]+=lrate*err1[ii]							
		if error1!=0:
			serror+=1
	#print(w1)
	#print(w2)
	#print("########################################")				
	#print("error=",serror)
	return serror		

def accuracy():
	global ytest,w1,w2,pddtest,lrate,bias2,bias1
	tp=tn=fn=fp=0
	for i in range(pddtest.shape[0]):
		wpre1=[0]*5
		for ii in range(5):
			wpre1[ii]=bias1[ii]
			for j in range(size):
				wpre1[ii]+=pddtest[i][j]*w1[ii][j]
			wpre1[ii]=wxx(wpre1[ii])
		wx=bias2	
		for ii in range(5):
			wx+=w2[ii]*wpre1[ii]
		result=wxxx(wx)	
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

def kfoldcv(iteration_val,nfolds):
	global n,ytrain,ytest,w1,w2,df,pddtrain,pddtest,finalw1,finalw2,size,bias1,bias2
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
		for ii in range(iteration_val):
			err=oneiteration()
			if err==0:
				break;
		racc=accuracy()
		acc1=(1.0*racc[0]+racc[3])/(racc[0]+racc[1]+racc[2]+racc[3])
		if acc<=acc1:
			acc=acc1
			finalw1=w1
			finalw2=w2		
		initialise()
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

lrate=0.1
for i in range(n):
	if df[i][0]=="No":
		y.append(0)
	else:
		y.append(1)
df=np.delete(df, 0, 1)		
acc=kfoldcv(1000,10)		
print("average accuracy is =",acc[0],"best accuracy: ",acc[1])				
print(df)