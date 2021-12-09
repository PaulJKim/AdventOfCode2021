import csv

class test:
    def run():
        print("hello")
        with open('AdventOfCodeDay1.txt', encoding='utf-8-sig', newline='') as csv_data:
            #or use csv.Reader(csv_data, delimiter=',') for a file without columns
            csv_reader = csv.reader(csv_data, delimiter='\n')

            list = []
            for row in csv_reader:
                list.append(int(row[0]))
            
            counter = 0
            for i in range(0, len(list) - 1):
                if (list[i] < list[i + 1]):
                    counter = counter + 1

            print(counter)

test.run()