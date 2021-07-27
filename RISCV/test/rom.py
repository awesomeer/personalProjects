import sys

inf = open(sys.argv[1], 'r')

lines = inf.readlines()

for line in lines:
    tokens = line.split()
    if tokens == [] or tokens[0][0:2] != "0x":
        continue

    tokens = tokens[1:-1]
    for token in tokens:
        if not token.isalnum():
            break
        
        print(token[6:], end='')
        print(token[4:6], end='')
        print(token[2:4], end='')
        print(token[0:2])


print("00000013")
print("00000013")
print("00000013")
print("00000013")


