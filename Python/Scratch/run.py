import math


leng = 6
print(math.ceil(leng/2))
for y in range(leng):
    tempy = y if y < math.ceil(leng/2) else leng - y - 1
    for x in range(leng):
        tempx = x if x < math.ceil(leng/2) else leng - x - 1
        print(min(tempx, tempy), end = "")
    print()
    
    
# leng = 6
# for y in range(leng):
    # tempy = abs(math.ceil(leng/2)-y-1)
    # for x in range(leng):
        # tempx = abs(math.ceil(leng/2)-x-1)
        # print(max(tempx, tempy), end = "")
    # print()