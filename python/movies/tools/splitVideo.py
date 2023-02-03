#!/usr/bin/python3

import cv2
import sys

cap = cv2.VideoCapture(sys.argv[1])

bmin = int(sys.argv[2])
bsec = int(sys.argv[3])
bframe = (bmin*60+bsec)*60

emin = int(sys.argv[4])
esec = int(sys.argv[5])
eframe = (emin*60+esec)*60

if not cap.isOpened():
    print("Error opening video stream or file")

count = bframe
cap.set(cv2.CAP_PROP_POS_FRAMES, count)
print(count, eframe)
while count < eframe:

    ret, frame = cap.read()
    if ret == False:
        break

    hr = 1920//8
    vr = 1080//8
    left = hr*3
    right = left+2*hr
    up = vr*3
    down = up+2*vr
    frame = frame[up:down, left:right]

    filename = sys.argv[6] + str(count) + ".jpg"    #ARGUMENT
    print(cv2.imwrite(filename, frame))
    count += 1