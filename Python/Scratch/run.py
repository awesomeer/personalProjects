


leng = 5

for y in range(leng):
    tempy = y if y < 3 else leng - y - 1
    for x in range(leng):
        tempx = x if x < 3 else leng - x - 1
        print(min(tempx, tempy), end = "")
    print()