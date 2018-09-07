import csv
import random
n = 23

def func (w, data, threshold,lr):
	# for i in range(len(w)):
	# 	if i == 0:
	# print(data)
	# print(w)
	# print(threshold)
	sum = 0
	for i in range(len(data)-1):
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
	for i in range(len(w)-1):
		
		w[i] = w[i] + lr * ( data[-1] - res) * data[i] 
				

	return (w,e)

def test(w, data,threshold,lr):
	sum = 0
	for i in range(len(data)):
		sum = sum + data[i] * w[i];

	sum = sum + w[-1]
	if ( sum >= threshold ):
		res = 1
	else:
		res = 0;

	#print("error is ", data[-1] - res )	
	return data[-1] - res

data = []

with open('SPECT.csv') as csvfile:
	reader = csv.DictReader(csvfile)
	i = 0

	for row in reader:
		# print(row)
		list1=[]

		for i in range(1,23):
			list1.append(float(row['Attr_'+str(i)]))		
		
		if row['Class'] == 'Yes':
			list1.append(1)
		else:
			list1.append(0)

		data.append(list1)	

random.shuffle(data)
threshold = 5
lr = 0.4
init_weight = 1 / n
iterate = 5000

w = []

for i in range(n):
	w.append(init_weight)

print(w)

ten_fold = 0

flag = 0
x = 0
y = len(data) // 10
total_Accuracy = 0
c = 0
while(y < len(data) ):
	train_data = data[:x] + data[y:]
	test_data = data[x:y]
	print('*'*50)
	for j in range(iterate):
		for i in train_data:
			w,e = func(w,i,threshold,lr)
			flag = e
		if flag == 0:
			for i in train_data:
				w,e = func(w,i,threshold,lr)
			if e == 0:
				break

				

	#print('Testing')
	# for i in test_data:
	# 	test(w,i,threshold,lr)
	# for i in test_data	:
	# 	test(w,i,threshold,lr)
	count = 0
	for i in test_data:
		e = test(w, i, threshold, lr)
		if e == 0:
			count = count + 1
		if e != 0:
			flag = e
	print('accuracy ', (count / len(test_data)) * 100, '%')
	total_Accuracy = total_Accuracy + (count / len(test_data)) * 100
	x = y
	y = y + 10
	c = c + 1

print('Final accuracy ',total_Accuracy/c,'%')


print(w)		
