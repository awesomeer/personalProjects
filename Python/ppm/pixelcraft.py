import os
#Represents a single byte, with helping functions to manipulate bits
class Byte:
    #Store the number representing this byte
    #Arguments: num - a number for this Byte to represent
    def __init__(self, num):
        self.n = int(num)

    #Return a string representation of this byte (the number inside it)
    #Arguments: none
    #Return value: A string containing the numeral value of this Byte
    def __str__(self):
        return str(self.n)

    #Flip the bit at location "bit", with 0 being the least significant bit
    #Arguments: The bit position to flip
    #Return value: none
    def flipbit(self, bit):
        self.n ^= (2 ** bit)

    #Set the bit at location "bit" to the value "val"
    #Arguments: val - the value to set the bit to, 0 or 1 
    #           bit - the bit index where the value is being set, 0 is the least significant bit
    #Return value: none
    def assignbit(self, val, bit):
        if self.getbit(bit) != val:
            self.flipbit(bit)
        
    #Get the bit at location "bit", returns the number 0 or 1
    #Arguments: bit - the bit index to return, 0 is the last significant bit
    #Return value: An integer, 0 or 1
    def getbit(self, bit):
        if self.n & (2 ** bit) > 0:
            return 1
        else:
            return 0

    #Returns an integer representing this byte
    #Arguments: none
    #Return value: An integer representing this byte in base-10
    def getnum(self):
        return self.n

    #Converts this Byte into a single-character string (ASCII decoding)
    #Arguments: none
    #Return value: A string of length one
    def decode(self):
        return bytes([self.n]).decode()
    

#Represents one pixel, with a single byte for each color blue, green and red.
class Pixel:
    #Constructs a Pixel from an array of 3 RGB values
    #Arguments: red, green, blue - three integers from 0-255 that contain the intensity of the red, green and blue color for this pixel
    def __init__(self, red, green, blue):
        self.red = Byte(red)
        self.green = Byte(green)
        self.blue = Byte(blue)

    #Return a string representing the pixel, should be three numbers with the values
    #for the red, green and blue colors respectively i.e. "255 255 0"
    #Arguments: none
    #Return value: A string with three numbers representing the red, green and blue intensity of this pixel
    def __str__(self):
        return str(self.red) + " " + str(self.green) + " " + str(self.blue)

class Picture:
    #Constructs a Picture from a PPM image file specified by the variable imagefile
    #Should read in the file and create an array of Pixel objects based on the data in the file
    #Arguments: imagefile - A string with the file name to a PPM image file
    def __init__(self, imagefile):
        file = open(imagefile, 'r')
        magicNum = file.readline().strip()
        dim = file.readline().strip().split(' ')
        ran = file.readline().strip()
        
        data = file.read().strip()
        data = data.replace('\n', ' ')
        data = data.replace('  ', ' ')
        data = data.split(' ')
        self.pixels = []
        
        print(magicNum, dim, ran)
        
        for yx in range(int(dim[1]) * int(dim[0])):
            index = yx*3
            self.pixels.append(Pixel(int(data[index]), int(data[index+1]), int(data[index+2])))
        
        

    #Maxes out the red value for each pixel in this image (sets it to 255)
    #Arguments: none
    #Return value: none
    def tintred(self):
        for i in range(len(self.pixels)):
            self.pixels[i].red = 255;

    #Takes a Picture as an argument, with the same dimensions as this picture.  
    #Replace all green pixels in this image with the corresponding pixels from the other Picture.
    #Arguments: otherpicture - A Picture object containing a background image to replace the green pixels in this image
    #Return value: none
    def greenscreen(self, otherpicture):
        for p in range(len(self.pixels)):
            if(self.pixels[p].green > 200 and self.pixels[p].red < 70 and self.pixels[p].blue < 70):
                self.pixels[p].red = otherpicture.pixels[p].red;
                self.pixels[p].green = otherpicture.pixels[p].green;
                self.pixels[p].blue = otherpicture.pixels[p].blue;
        

    #Writes the image back to a file
    #Arguments: outfile - A string with the name of the file to write out to
    #Return value: none
    def writeimage(self, outfile):
        pass

    #Takes the string "message" and embeds it in the least-significant bit of the pixels of this image.
    #Arguments: message - A string containing a message to be hidden in this picture
    #Return value: none
    def stegembed(self, message):
        pass

    #Reads a secret message from the least-significant bits of the pixels of the image and returns it
    #Arguments: none
    #Return value: A string containing the message hidden in this picture
    def stegread(self):
        pass

if __name__ == "__main__":
    #Open the pokemon picture
    p = Picture("pokemon.ppm")

    #Tint it red
    p.tintred()

    #Read the Declaration of Independence
    with open("decl.txt", "r") as declaration:
        msg = declaration.read()

    #Embed it into the image
    p.stegembed(msg)

    #Write the image back to the disk
    p.writeimage("pokemonsteg.ppm")

    #Read the secret message
    print(p.stegread())

    #Open the green screen image and replace its background with mountains
    g = Picture("minion.ppm")
    b = Picture("mountainsbg.ppm")

    g.greenscreen(b)

    g.writeimage("combined.ppm")