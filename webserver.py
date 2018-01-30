# Updated by rkiles
import os
import threading
import time
from flask import Flask, render_template

systemname = os.environ["HOSTNAME"]

# This function will open the html template, perform a find/replace, and save to a new text file.
def replace_words(base_text, device_values):
    for key, val in device_values.items():
        base_text = base_text.replace(key, val)
    return base_text

# Define the system variables to change
device = {}

device["replaceme"] = systemname

# Open the template file
t = open('templates/hello.tmp', 'r')
tempstr = t.read()
t.close()


# Using the "replace_words" function
output = replace_words(tempstr, device)

# Write out the new HTML file
fout = open('templates/hello.html', 'w')
fout.write(output)
fout.close()

# Start the flask application
app = Flask(__name__)

@app.route('/')
def hello():
    return render_template('hello.html')


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
