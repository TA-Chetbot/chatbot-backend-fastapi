# Use the official Python image as the base image
FROM python:3.12.3-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Torch
RUN pip install torch --index-url https://download.pytorch.org/whl/cpu

# Install NLTK Stopwords
RUN ["python", "-c", "import nltk; nltk.download('stopwords')"]

# Copy the application code
COPY . .

# Expose the port that the app will run on
EXPOSE 8000

# Set the command to start the FastAPI app
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

CMD ["gunicorn", "main:app", "--workers", "4", "--worker-class", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0:8000"]
