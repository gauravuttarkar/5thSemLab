import csv
import random

def cross_over(chrome1, chrome2):
    x = []
    rand_len = random.randint(1,len(chrome1) - 1)
    for i in chrome1[:rand_len]:
        x.append(i)

    for i in chrome2[rand_len:]:
        x.append(i)

    return x        


def find_probability(list_of_accuracy):
    sum = 0
    for i in list_of_accuracy:
        sum = sum + i

    li = []
        
    for i in list_of_accuracy:
        li.append(i/sum)

    return li     


def cumulative_fitness(list_of_probability):
    initial = 0

    li = []

    for i in list_of_probability:
        initial = initial + i
        li.append(initial)

    return li    
        

def genetic_algorithm():
    number_of_chromosome = 30
    size_of_chromosome = 22

    chromosomes = []
    for i in range(number_of_chromosome):
        chromosomes.append([])
        for j in range(size_of_chromosome):
            chromosomes[i].append(random.randint(0,1))

    print(chromosomes) 

    list_of_accuracy = []

    iterations = 100
    t = 0
    while ( t < iterations ):
        list_of_accuracy = []

        for i in chromosomes:
            list_of_accuracy.append(nb(i))

        #print(list_of_accuracy)  

        average_acc = 0

        for i in list_of_accuracy:
            average_acc = average_acc + i


        print("Average accuracy at the end of ",t," iterations is ",average_acc/len(list_of_accuracy))    

        list_of_probability = find_probability(list_of_accuracy)

        list_of_cumulative_fitness = cumulative_fitness(list_of_probability)

        #print(list_of_cumulative_fitness)


        list_of_selected = []
        for i in range(number_of_chromosome):
            random_number = random.random()
            #print(random_number)
            for j in range(len(list_of_cumulative_fitness)):
                if random_number < list_of_cumulative_fitness[j]:
                    list_of_selected.append(j)
                    break
        #print(list_of_selected)

        new_chromosomes = []

        for i in list_of_selected:
            #print(i)
            new_chromosomes.append(chromosomes[i])

        #print(new_chromosomes)    
        chromosomes =new_chromosomes
        #copy_for_crossover = chromosomes

        after_crossover = []
        t = t + 1


def read_input(string):
    with open(string) as csvfile:
        reader = csv.DictReader(csvfile)
        i = 0
        data = []

        for row in reader:
            # print(row)
            list1 = []

            for i in range(1, 23):
                list1.append(float(row['Attr_' + str(i)]))

            if row['Class'] == 'Yes':
                list1.append(1)
            else:
                list1.append(0)

            data.append(list1)

    return data

def test(p_yes, p_no, prob_yes, test_data, feature):
    ans_yes = 0
    ans_no = 0

    prod_yes = 1
    prod_no = 1
    for i in range(len(test_data)):
        if feature[i]:
            if test_data[i] == 1:
                prod_yes = prod_yes * p_yes[i]
                prod_no = prod_no * p_no[i]
            else:
                prod_yes = prod_yes * (1 - p_yes[i])
                prod_no = prod_no * (1 - p_no[i])
                    
    prod_yes = prod_yes * prob_yes
    prod_no = prod_no * ( 1 - prob_yes)

    ans_yes = prod_yes / ( prod_yes + prod_no )

    ans_no = 1 - ans_yes

    if ans_yes > ans_no :
        return 1
    else:
        return 0

def nb(feature):
    data = read_input('SPECT.csv')
    random.shuffle(data)
    p_yes = []
    p_no = []
    total_records = len(data)
    #print(total_records)
    tenfold = 0
    y = total_records // 10
    x = 0
    data_after_selection = []
    total_accuracy = 0
    count = 0
    while ( y < total_records ):
        p_yes = []
        p_no = []
        prob_yes = 0
        train_data = data[:x] + data[y:]
        test_data = data[x:y]


        for i in range(len(data[0]) - 1):
            c1 = 0
            c2 = 0

            for j in range(len(train_data)):
                if train_data[j][-1] == 1:
                    if train_data[j][i] == 1:
                        c1 = c1 + 1
                else:
                    if train_data[j][i] == 1:
                        c2 = c2 + 1

            p_yes.append(c1/total_records)
            p_no.append(c2/total_records)

        c1 = 0
        for i in range(len(train_data)):
            if train_data[i][-1] == 1:
                c1 = c1 + 1
        # print(c1)
        prob_yes = c1 / total_records

        # print(p_yes)
        # print(p_no)
        # print(prob_yes)
        c1 = 0
        c2 = 0
        c3 = 0
        c4 = 0
        for i in test_data:
            if ( test(p_yes,p_no,prob_yes,i[:-1],feature) == i[-1] ):
                #print("success")
                c1 = c1 + 1
            #else:
                
                #print("Fail")
            c2 = c2 + 1
        total_accuracy = total_accuracy + (c1/c2)*100
        count = count + 1
        x = y
        y = y + total_records // 10
    #print("Final accuracy = ",total_accuracy/count,"%")
    return total_accuracy / count

def main():
    genetic_algorithm()

main()    
