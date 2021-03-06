import csv
import random

data = []

n = 5


def func (w, data, threshold,lr):
	# for i in range(len(w)):
	# 	if i == 0:
	# print(data)
	# print(w)
	# print(threshold)
	sum = 0
	for i in range(len(data) - 1):
		sum = sum + data[i] * w[i];

	sum = sum + w[-1]	 
	#print(sum)
	res = None
	e = 0
	if ( sum >= threshold ):
		res = 1
	else:
		res = 0;
	#print("data ",data[-1],"res ",res)
	
	#print("error is ", data[-1] - res )
	if data[-1] - res:
		e = 1
	for i in range(len(w)):
		
		w[i] = w[i] + lr * ( data[-1] - res) * data[i] 
			


	return (w,e)

def test(w, data,threshold,lr):
	sum = 0
	for i in range(len(data)-1):
		sum = sum + data[i] * w[i];

	sum = sum + w[-1]
	if ( sum >= threshold ):
		res = 1
	else:
		res = 0;

	print("error is ", data[-1] - res )	

			


	return (data[-1]-res,res)

def iteration():
	pass


with open('IRIS.csv') as csvfile:
	reader = csv.DictReader(csvfile)
	i = 0

	for row in reader:
		list1=[]

		list1.append(float(row['sepal length']))
		list1.append(float(row['sepal width']))
		list1.append(float(row['petal length']))
		list1.append(float(row['petal width']))
		if row['class'] == "Iris-versicolor":
			list1.append(1)
		else:
			list1.append(0)		
		data.append(list1)

	#print(row['first_name'], row['last_name'])
# for i in data:
# 	print(i)	

threshold = 0.9
lr = 0.4
init_weight = 1 / n
random.shuffle(data)

w = []

for i in range(n):
	w.append(init_weight)

# for i in data:
# 	print(i)

print(w)

ten_fold = 0

flag = 0

x = 0
y = 20
total_recall = 0
total_prec = 0
total_Accuracy = 0
c = 0
while(y<100):
	print('*'*50)
	train_data = data[:x] + data[y:]
	test_data = data[x:y]
	tp = 0
	fp = 0
	tn = 0
	fn = 0
	for j in range(5000):
		for i in train_data:
			w,e = func(w,i,threshold,lr)
			flag = e
		if flag == 0:
			for i in train_data:
				w,e = func(w,i,threshold,lr)
			if e == 0:
				break

				

	print('Testing')
	# for i in test_data:
	# 	test(w,i,threshold,lr)
	count = 0
	for i in test_data:
		e,res = test(w, i, threshold, lr)
		if e == 0:
			count = count + 1
		if e != 0:
			flag = e
		if i[-1]==1 and res==1:
			tp+=1
		elif i[-1]==1:
			fn+=1
		elif i[-1]==0 and res==0:
			tn+=1
		else:
			fp+=1				
	print('recall is ',(tp*1.0)/(tp + fn))
	total_recall = total_recall + (tp*1.0)/(tp + fn)
	print('precision is',(tp*1.0)/(tp + fp))
	total_prec = total_prec + (tp*1.0)/(tp + fp)
	print('accuracy ', (count / len(test_data)) * 100, '%')
	total_Accuracy = total_Accuracy + (count / len(test_data)) * 100
	x = y
	y = y + len(data) // 10
	c = c + 1

flag = 0
count = 0
# for i in data:
# 	e = test(w,i,threshold,lr)
# 	if e == 0:
# 		count = count + 1
# 	if e != 0:
# 		flag = e
# print('accuracy ',(count/len(data))*100,'%')		
# if flag == 0:
# 	print('Test Successful')
# else:
# 	print('Test failed')		
print('Final accuracy ',total_Accuracy/c,'%')
print('Final Precision',total_prec/c)
print('Final Recall',total_recall/c)
print(w)

