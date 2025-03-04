# Use the official Python 3.12 slim image
FROM python:3.12-slim

# Set the working directory
WORKDIR /E-COMMERCE_Data_Platform

# Copy your requirements file into the container
COPY requirements.txt .

# RUN pip install --upgrade pip

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt



# Copy the rest of your code into the container
COPY . .

# Provide a default command (adjust as needed)
CMD ["python", "--version"]
