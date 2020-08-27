import math

N = 512
angle = 4*math.pi/3

for r in range(int(N/100)+1):
    for i in range(100):
        index = r*100+i
        if index >= N:
            break
        value = 127*math.sin(2*math.pi*index/N + angle)+128
        print(str(int(value))+", ", end ="")
    print()