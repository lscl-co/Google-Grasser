# Snakemake script for Google Grass Maker
# A tool to make text funny by translating it multiple times
# Author: Copilot

# Import modules
import requests
import json
import random

# Define input and output files
INPUT = "input.txt"
OUTPUT = "output.txt"

# Define languages to translate
LANGS = ["zh", "en", "fr", "de", "es", "it", "ja", "ko", "ru", "ar", "hi", "sw", "eo", "la", "jw"]

# Define Google Translate API URL
URL = "https://translate.googleapis.com/translate_a/single"

# Define a rule to translate text
rule translate:
    input: INPUT
    output: OUTPUT
    run:
        # Read the input text
        with open(input[0], "r", encoding="utf-8") as f:
            text = f.read().strip()
        
        # Translate the text multiple times
        for i in range(10):
            # Choose a random language
            lang = random.choice(LANGS)
            # Set the parameters for the API request
            params = {
                "client": "gtx",
                "sl": "auto",
                "tl": lang,
                "dt": "t",
                "q": text
            }
            # Send the request and get the response
            response = requests.get(URL, params=params)
            # Parse the response as JSON
            data = response.json()
            # Extract the translated text
            text = data[0][0][0]
        
        # Write the output text
        with open(output[0], "w", encoding="utf-8") as f:
            f.write(text)
