import csv
import random

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

def test(p_yes, p_no, prob_yes, test_data):
    ans_yes = 0
    ans_no = 0
    #For P(x/Yes)
    prod_yes = 1
    prod_no = 1
    for i in range(len(test_data)):
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





# def calculate_probability(data, i):
#     print('inside calculate probability')
#     i_count = 0
#     total_count = 0
#
#     for j in data:
#         if ( j == i ):
#             i_count = i_count + 1
#         total_count = total_count + 1
#
#     return i_count / total_count


def main():
    data = read_input('SPECT.csv')
    random.shuffle(data)
    # for i in data:
    #     print(i)



    p_yes = []
    p_no = []


    total_records = len(data)
    #print(total_records)

    tenfold = 0
    y = total_records // 10
    x = 0



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
        for i in test_data:
            if ( test(p_yes,p_no,prob_yes,i[:-1]) == i[-1] ):
                print("success")
                c1 = c1 + 1
            else:
                print("Fail")
            c2 = c2 + 1

        print("Accuracy is ",(c1/c2)*100 , "%")

        x = y
        y = y + total_records // 10

main()