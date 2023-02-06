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

def list_append(filename : str, fifo : queue.Queue):
    cap = cv2.VideoCapture(filename)
    while True:
        ret, frame = cap.read()
        if ret:
            vhr = 2560//8
            vvr = 1440//8
            vleft = vhr*3
            vright = vleft+2*vhr
            vup = vvr*3
            vdown = vup+2*vvr

            frame = frame[vup:vdown, vleft:vright]
            frame = cv2.resize(frame, (480,270))
            #frame = cv2.resize(frame, (1920,1080))
            #frame = frame[up:down, left:right]
            Y = image.img_to_array(frame)
            X = np.expand_dims(Y,axis=0)
            fifo.put(X)
        else:
            fifo.put(None)
            break


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

    hr = 2560//8
    vr = 1440//8
    left = hr*3
    right = left+2*hr
    up = vr*3
    down = up+2*vr

    fifo = queue.Queue(maxsize=256)
    process = threading.Thread(target=list_append, args=(sys.argv[2], fifo), daemon=True)
    process.start()

    video = cv2.VideoCapture(sys.argv[2])
    count = 0
    begin = 0
    STATE = "VIDEO"
    while True:

        frame = fifo.get()

        val = model.predict(frame, verbose=0)
        val = int(val[0][0] + 0.1)
        if val:
            idx = random.randint(0, (2**32)-1)
            video.set(cv2.CAP_PROP_POS_FRAMES, count)
            ret, frame = video.read()
            frame = frame[up:down, left:right]
            frame = cv2.resize(frame, (480,270))
            cv2.imwrite(".\\tmp\\"+str(idx)+".jpg", frame)

        

        if STATE == "VIDEO":
            if val:
                bmins, bsecs = frametot(begin)
                mins, secs = frametot(count)
                print(str(bmins)+":"+str(bsecs) + " - " + str(mins)+":"+str(secs))

                STATE = "TRANSISTION"
                
        elif STATE == "TRANSISTION":
            if val == 0:
                begin = count+1

                STATE = "VIDEO"


        count += 1
