# Use a Python base image
FROM python:3.11-slim-bookworm

# Set the working directory in the container
WORKDIR /app

# Install system dependencies if any are needed for Python packages
# For a basic Streamlit app, typically none are strictly necessary beyond default Python image
# But if you have packages like `matplotlib` or `opencv`, you might need `build-essential` or `libgl1-mesa-glx`

# Copy the requirements file and install Python dependencies
COPY streamlit_app/requirements.txt ./streamlit_app/requirements.txt
RUN pip install --no-cache-dir -r streamlit_app/requirements.txt

# Copy the Streamlit application code
COPY streamlit_app/ ./streamlit_app/

# Expose the port Streamlit will run on (default is 8501)
EXPOSE 8501

# Command to run the Streamlit application
CMD ["streamlit", "run", "streamlit_app/app.py", "--server.port=8501", "--server.address=0.0.0.0"]
