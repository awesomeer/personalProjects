#!/usr/bin/python3

import cv2
import sys

cap = cv2.VideoCapture(sys.argv[1])

if not cap.isOpened():
    print("Error opening video stream or file")

count = 0

while True:

    cap.set(cv2.CAP_PROP_POS_FRAMES, count)
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

    filename = sys.argv[2] + str(count) + ".jpg"    #ARGUMENT
    cv2.imwrite(filename, frame)

    count += 60