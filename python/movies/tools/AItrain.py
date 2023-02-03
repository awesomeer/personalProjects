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

import sys
import os

import threading
import queue

import random

def predictImage(img1):
    #img1 = image.load_img(filename,target_size=(WIDTH,HEIGHT))
    
    #plt.imshow(img1)
 
    #Y = image.img_to_array(img1)
    #X = np.expand_dims(Y,axis=0)
    #val = model.predict(X, verbose=0)

    val = model.predict(img1, verbose=0)

    try:
        return int(val[0][0] + 0.1)
    except ValueError:
        return 0
"""
    if val == 1:  
      plt.xlabel("DOG",fontsize=30)
    elif val == 0:
      plt.xlabel("CAT",fontsize=30)


while True:
   filens = input()
   predictImage(filens)
"""

def frametot(framenum):
    secs = (framenum//60) % 60
    mins = framenum//60//60
    return mins, secs


def list_append(filename : str, fifo : queue.Queue, count : int):
    cap = cv2.VideoCapture(filename)
    cap.set(cv2.CAP_PROP_POS_FRAMES, count)
    while True:
        ret, frame = cap.read()
        if ret:
            #frame = frame[up:down, left:right]
            #fifo.put(frame)
            frame = frame[up:down, left:right]
            Y = image.img_to_array(frame)
            X = np.expand_dims(Y,axis=0)
            fifo.put(X)
        else:
            fifo.put(None)
            break




if __name__ == "__main__":
    HEIGHT = 270 #HEIGHT
    WIDTH = 480 #WIDTH

    train = ImageDataGenerator(rescale=1/255)

    train_dataset = train.flow_from_directory(sys.argv[1],
                                            target_size=(HEIGHT,WIDTH),
                                            batch_size = 1,
                                            class_mode = 'binary')
                                            
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
    model.add(keras.layers.Dense(1024,activation='relu'))

    model.add(keras.layers.Dense(1024,activation='relu'))

    # Output layer with single neuron which gives 0 for Cat or 1 for Dog 
    #Here we use sigmoid activation function which makes our model output to lie between 0 and 1
    model.add(keras.layers.Dense(1,activation='sigmoid'))

    model.compile(optimizer='adam',loss='binary_crossentropy',metrics=['accuracy'])


    model.fit_generator(train_dataset,
            steps_per_epoch = 725,
            validation_data = train_dataset,
            epochs = 2)


    hr = 1920//8
    vr = 1080//8
    left = hr*3
    right = left+2*hr
    up = vr*3
    down = up+2*vr

    awdmin = 5
    awdsec = 0
    begin = 0
    count = 0#(awdmin*60+awdsec)*60
    videonum = 0

    cap = cv2.VideoCapture(sys.argv[2])
    numframes = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    print("numframes:", numframes)
    del cap


    fifo = queue.Queue(maxsize=256)
    process = threading.Thread(target=list_append, args=(sys.argv[2], fifo,count,), daemon=True)
    process.start()

    STATE = "VIDEO"
    while count < numframes:

        frame = fifo.get()
        
        #start_time = timeit.default_timer()
        val = predictImage(frame)
        #elapsed = timeit.default_timer() - start_time
        #print(1/elapsed)

        #
        #  State Machine Logic to find episodes
        #

        if STATE == "VIDEO":
            if val:
                bmins, bsecs = frametot(begin)
                mins, secs = frametot(count)
                print(str(bmins)+":"+str(bsecs) + " - " + str(mins)+":"+str(secs))

                videonum += 1
                STATE = "TRANSISTION"
                
        elif STATE == "TRANSISTION":
            if val == 0:
                begin = count + 60
                STATE = "VIDEO"
            
        if val:

            found = cv2.VideoCapture(sys.argv[2])
            found.set(cv2.CAP_PROP_POS_FRAMES, count)
            ret, frame = found.read()
            frame = frame[up:down, left:right]

            idx = random.randint(0, (2**32)-1)
            cv2.imwrite(".\\tmp\\"+str(idx)+".jpg", frame)
            print("count:", count, "val:", val)

            del found


        count = count + 1
        if (count % 60) == 0:
            mins, secs = frametot(count)
            print(str(mins)+":"+str(secs))
            #print(str(count)+"//"+str(numframes))


    process.join()