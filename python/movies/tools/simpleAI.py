from cmath import nan
from tabnanny import verbose
from time import sleep
import tensorflow as tf
import numpy as np
from tensorflow import keras
import cv2
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.preprocessing import image
import matplotlib.pyplot as plt
import random

import sys
import threading
import queue
import time


def frametot(framenum):
    secs = (framenum//60) % 60
    mins = framenum//60//60
    return mins, secs


if __name__ == "__main__":
    HEIGHT = 270 #HEIGHT
    WIDTH = 480 #WIDTH

    train = ImageDataGenerator(rescale=1/255)

    train_dataset = train.flow_from_directory(sys.argv[1],
                                            target_size=(HEIGHT,WIDTH),
                                            batch_size = 1,
                                            class_mode = 'binary')

    print(train_dataset.class_indices)    
    model = keras.Sequential()

    # Convolutional layer and maxpool layer 1
    model.add(keras.layers.Conv2D(32,(3,3),activation='relu',input_shape=(HEIGHT,WIDTH,3)))
    model.add(keras.layers.MaxPool2D(2,2))

    # Convolutional layer and maxpool layer 2
    model.add(keras.layers.Conv2D(64,(3,3),activation='relu'))
    model.add(keras.layers.MaxPool2D(2,2))

    # Convolutional layer and maxpool layer 3
    model.add(keras.layers.Conv2D(128,(3,3),activation='relu'))
    model.add(keras.layers.MaxPool2D(2,2))

    # Convolutional layer and maxpool layer 4
    model.add(keras.layers.Conv2D(128,(3,3),activation='relu'))
    model.add(keras.layers.MaxPool2D(2,2))

    # This layer flattens the resulting image array to 1D array
    model.add(keras.layers.Flatten())

    # Hidden layer with 512 neurons and Rectified Linear Unit activation function 
    model.add(keras.layers.Dense(512,activation='relu'))

    # Output layer with single neuron which gives 0 for Cat or 1 for Dog 
    #Here we use sigmoid activation function which makes our model output to lie between 0 and 1
    model.add(keras.layers.Dense(1,activation='sigmoid'))

    model.compile(optimizer='adam',loss='binary_crossentropy',metrics=['accuracy'])


    model.fit_generator(train_dataset,
            steps_per_epoch = 1030,
            validation_data = train_dataset,
            epochs = 2)

    hr = 1920//8
    vr = 1080//8
    left = hr*3
    right = left+2*hr
    up = vr*3
    down = up+2*vr

    video = cv2.VideoCapture(sys.argv[2])
    count = 0
    begin = 0
    ecount = 0
    hwmny = 0
    STATE = "VIDEO"
    while True:

        ret, frame = video.read()
        if not ret:
            break
        
        frame = frame[up:down, left:right]
        #frame = cv2.resize(frame, (480,270))
        Yp = image.img_to_array(frame)
        Xp = np.expand_dims(Yp,axis=0)

        val = model.predict(Xp, verbose=0)
        val = int(val[0][0] + 0.1)


        if STATE == "VIDEO":
            if val and (hwmny == 0):
                ecount = count-1
                hwmny += 1
            elif val and hwmny:
                bmins, bsecs = frametot(begin)
                mins, secs = frametot(ecount)
                print(str(bmins)+":"+str(bsecs) + " - " + str(mins)+":"+str(secs))
                print(begin/60, ecount/60)

                STATE = "TRANSISTION"
            else:
                hwmny = 0
                
        elif STATE == "TRANSISTION":
            if val == 0:
                begin = count+1

                count += (16*60*60)
                video.set(cv2.CAP_PROP_POS_FRAMES, count)
                STATE = "VIDEO"

                continue

        if val:
            idx = random.randint(0, (2**32)-1)
            gethit = cv2.VideoCapture(sys.argv[2])
            gethit.set(cv2.CAP_PROP_POS_FRAMES, count)
            ret, frame = gethit.read()
            frame = frame[up:down, left:right]
            #frame = cv2.resize(frame, (480,270))
            cv2.imwrite(".\\tmp\\"+str(idx)+".jpg", frame)
            #print(count)
        # if count%3600 == 0:
        #     mins, secs = frametot(count)
        #     print(str(mins)+":"+str(secs))

        count += 1
