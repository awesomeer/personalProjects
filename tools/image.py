# Convert Image to C array for HUB75 display
from PIL import Image




def image_to_c_array(image_path, width=64, height=32):
    img = Image.open(image_path)
    img = img.resize((width, height))  # Resize to fit the display
    img = img.convert('RGB')  # Ensure it's in RGB format

    c_array = "const uint8_t raw_image[{}][3] = {{\n".format(height*width)
    for y in range(height):
        for x in range(width):
            r, g, b = img.getpixel((x, y))
            c_array += f"{{{r}, {g}, {b}}}, \n"
    c_array += "};"

    return c_array

if __name__ == "__main__":
    c_array = image_to_c_array("image.jpg", width=64, height=64)
    print(c_array)