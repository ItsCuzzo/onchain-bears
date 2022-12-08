from base64 import b64decode
from json import load, dump
from io import BytesIO
from PIL import Image

# Helper function to parse RGB values to hex code.
def rgb2hex(r, g, b):
    return "#{:02x}{:02x}{:02x}".format(r, g, b)

# One of the main issues faced when creating a colour table is that
# ordering of the set can very between runs. In order to achieve
# consistency, we need to set the `PYTHONHASHSEED` env variable to a
# predetermined value. You can use `export PYTHONHASHSEED=1`. However,
# remember to return this value to the default of 0 after use.
def create_colour_table(layers):

    colours = set()

    # Iterate over each `layer` in `layers`.
    for layer in layers:

        # Parse base64 decoded image from layer `src` key.
        raw_src = b64decode(layer['src'].split('base64,')[-1])

        # Convert `raw_src` into a bytes buffer and reset memory offset.
        img_bytes = BytesIO(raw_src)
        img_bytes.seek(0)

        # Open the image using PIL.
        with Image.open(img_bytes) as image:

            # Load pixel data associated with `image`.
            pixels = image.load()

            # Iterate over each `x` coordinate in `image.width`.
            for x in range(image.width):

                # Iterate over each `y` coordinate in `image.height`.
                for y in range(image.height):
                    
                    # Parse RGBA values of `pixels[x, y]`.
                    r, g, b, a = pixels[x, y]

                    # If alpha value is 0, pixel is empty.
                    if a == 0:
                        continue

                    # Define `hex_code` from RGB values.
                    hex_colour = rgb2hex(r, g, b)

                    # Determine if the colour is unique.
                    if hex_colour not in colours:
                        colours.add(hex_colour)

    # Since we have all the unique colours, create our fills here too.
    fills = ''.join([
        f".c{i:02} {{fill: {color}}}\n" for i, color in enumerate(colours)
    ])
    
    # Write fills to a text file.
    with open('fills.txt', 'w') as ff:
        ff.write(fills)

    return {c: f'{i:02}' for i, c in enumerate(colours)}

def letters_from_coordinates(x, y):

    letters = {
        0: "a",
        1: "b",
        2: "c",
        3: "d",
        4: "e",
        5: "f",
        6: "g",
        7: "h",
        8: "i",
        9: "j",
        10: "k",
        11: "l",
        12: "m",
        13: "n",
        14: "o",
        15: "p",
        16: "q",
        17: "r",
        18: "s",
        19: "t",
        20: "u",
        21: "v",
        22: "w",
        23: "x",
        24: "y",
        25: "z"
    }

    return letters[x], letters[y]

# Open and load Pixil `workspace` file.
with open('./workspace.pixil', 'r') as pf:
    
    # Access `layers` within `pf` file.
    layers = load(pf)['frames'][0]['layers']

    # Define `colour_table`.
    colour_table = create_colour_table(layers)

# Define `traits` list.
traits = []

# Iterate over each `layer` in `layers`.
for layer in layers:

    trait_type, trait_value = layer['name'].title().split(' - ')

    # Define `trait` dict which will be added to `traits` list.
    trait = {
        "trait_type": trait_type,
        "value": trait_value,
        "pixels": ""
    }

    # Parse base64 decoded image from layer `src` key.
    raw_src = b64decode(layer['src'].split('base64,')[-1])

    # Convert `raw_src` into a bytes buffer and reset memory offset.
    img_bytes = BytesIO(raw_src)
    img_bytes.seek(0)

    # Define `colours` dict.
    colours = {}

    # Define `pixel_string`.
    pixel_string = ""

    # Open the image using PIL.
    with Image.open(img_bytes) as image:
        
        # Allocates storage for the image and loads the pixel data.
        pixels = image.load()
        
        # Iterate over each `x` coordinate in `image.width`.
        for x in range(image.width):

            # Iterate over each `y` coordinate in `image.width`.
            for y in range(image.height):
                
                # Parse RGBA values of `pixels[x, y]`.
                r, g, b, a = pixels[x, y]

                # If `a` is 0, then this pixel is empty.
                if a == 0:
                    continue

                # Define `hex_code` from RGB values.
                hex_code = rgb2hex(r, g, b)

                xa, ya = letters_from_coordinates(x, y)

                trait['pixels'] += f"{xa}{ya}{colour_table[hex_code]}"

    # Append trait to `traits` list.    
    traits.append(trait)

# Dump trait data to `traits.json` file.
with open('./traits.json', 'w') as tf:
    dump(traits, tf, indent=4)
