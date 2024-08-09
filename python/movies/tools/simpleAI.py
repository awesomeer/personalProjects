import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.preprocessing import image

import numpy as np

import sys
import cv2
import random
from datetime import datetime

from pytracing import TraceProfiler

def convert(frame):
    secs = (frame/60) % 60
    mins = (frame//3600) % 60
    hours = (frame//216000)

    return str(hours)+":"+str(mins)+":"+str(secs)

def frametot(framenum):
    secs = (framenum//60) % 60
    mins = framenum//60//60
    return mins, secs


HEIGHT = 270 #HEIGHT
WIDTH = 480 #WIDTH

hr = 1920//8
vr = 1080//8
left = hr*3
right = left+2*hr
up = vr*3
down = up+2*vr


train = ImageDataGenerator(rescale=1/255)

train_dataset = train.flow_from_directory(sys.argv[1],
                                        target_size=(HEIGHT,WIDTH),
                                        batch_size = 1,
                                        class_mode = 'binary')

print(train_dataset.class_indices)

# Define the model architecture
model = keras.Sequential([
    layers.Conv2D(32, (3, 3), activation="relu", input_shape=(270, 480, 3)),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation="relu"),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation="relu"),
    layers.Flatten(),
    layers.Dense(64, activation="relu"),
    layers.Dense(1, activation="sigmoid")
])

# Compile the model
model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])

# Train the model
model.fit_generator(train_dataset,
        steps_per_epoch = 1030,
        validation_data = train_dataset,
        epochs = 2)


count = 10*60
cap = cv2.VideoCapture(sys.argv[2])
cap.set(cv2.CAP_PROP_POS_FRAMES, count)

ret, frameread = cap.read()

begin = 0
ecount = 0
hwmny = 0
STATE = "VIDEO"

f = open("out.txt","w")
# tp = TraceProfiler(output=open('trace.out', 'wb'))
# with tp.traced():
while ret:

    framep = cv2.resize(frameread, (1920,1080))
    framep = framep[up:down, left:right]

    Yp = image.img_to_array(framep)
    frame = np.expand_dims(Yp,axis=0)

    val = model.predict(frame, verbose=0)
    #print(count, val)
    val = int(val[0][0] + 0.1)

    if STATE == "VIDEO":
        if val and (hwmny == 0):
            ecount = count-1
            hwmny += 1
        elif val and hwmny:
            bmins, bsecs = frametot(begin)
            mins, secs = frametot(ecount)

            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            print("Current Time =", current_time)
            print(convert(begin) + " - " + convert(ecount))
            print(convert(begin) + " - " + convert(ecount-begin))

            frac = begin % 60
            begin -= frac
            f.write(convert(begin) + " " + convert(frac) + " " + convert(ecount-begin)+"\n")

            STATE = "TRANSISTION"
        else:
            hwmny = 0
            
    elif STATE == "TRANSISTION":
        if val == 0:
            begin = count+1

            count += 42*60*60
            cap.set(cv2.CAP_PROP_POS_FRAMES, count+1)
            STATE = "VIDEO"


    if val:
        idx = random.randint(0, (2**32)-1)
        # cap.set(cv2.CAP_PROP_POS_FRAMES, count)
        # ret, frame = cap.read()
        # frame = cv2.resize(frame, (1920,1080))
        # frame = frame[up:down, left:right]
        #frame = cv2.resize(frame, (480,270))
        cv2.imwrite(".\\tmp\\"+str(idx)+".jpg", framep)
        #print(count)

    if count%3600 == 0:
        mins, secs = frametot(count)
        print(str(mins)+":"+str(secs))

    count += 1
    ret, frameread = cap.read()

f.close()
print("End Video")