f = open("/home/ubuntu/logFile.txt", "r")

tsTotal = 0.0;
tsCount = 0.0;
tjTotal = 0.0;
tjCount = 0.0;
tsAvg = 0.0;
tjAvg = 0.0;

for line in f:
	line = line.split()

	numOfItems = len(line)
	
	i = 0;
	while (i < numOfItems):
		if(line[i] == "TJ"):
			tjTotal += int(line[i+1])
			tjCount += 1
		elif(line[i] == "TS"):
			tsTotal += int(line[i+1])
			tsCount += 1

		i+=2

if tsCount != 0:
	tsAvg = tsTotal/tsCount

if tjCount != 0:
	tjAvg = tjTotal/tjCount

print("Query Count: " + str(tsCount));
print("TS Average: " + format(tsAvg, '.2f') + "ms")
print("TJ Average: " + format(tjAvg, '.2f') + "ms")

open("/home/ubuntu/logFile.txt", "w").close()
