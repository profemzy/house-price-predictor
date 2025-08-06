# 🏠 End-to-End House Price Predictor MLOps Deployment Guide

This document outlines the step-by-step process of setting up, running, and deploying the House Price Predictor MLOps project, from initial environment configuration to launching the FastAPI and Streamlit applications.

## 1. Initial Setup and Project Understanding

We begin by understanding the project's layout and its core functionalities.

### 1.1 Explore Project Structure

To get an initial overview of the project's directories and files, we listed the contents of the root `house-price-predictor` directory:
```
# Folders:
house-price-predictor/.ropeproject
house-price-predictor/.venv
house-price-predictor/configs
house-price-predictor/data
house-price-predictor/deployment
house-price-predictor/models
house-price-predictor/notebooks
house-price-predictor/src
house-price-predictor/streamlit_app

# Files:
house-price-predictor/.gitignore
house-price-predictor/Dockerfile
house-price-predictor/LICENSE
house-price-predictor/README.md
house-price-predictor/docker-compose.yaml
house-price-predictor/requirements.txt
```

### 1.2 Read the `README.md`

The primary source of information for any project is its `README.md` file. We read it to grasp the project's purpose, its intended MLOps workflow, and key setup instructions.
```path/to/README.md#L1-104
# 🏠 House Price Predictor – An MLOps Learning Project

Welcome to the **House Price Predictor** project! This is a real-world, end-to-end MLOps use case designed to help you master the art of building and operationalizing machine learning pipelines.

You'll start from raw data and move through data preprocessing, feature engineering, experimentation, model tracking with MLflow, and optionally using Jupyter for exploration – all while applying industry-grade tooling.

> 🚀 **Want to master MLOps from scratch?**  
Check out the [MLOps Bootcamp at School of DevOps](https://schoolofdevops.com) to level up your skills.

---

## 📦 Project Structure

```
house-price-predictor/
├── configs/                # YAML-based configuration for models
├── data/                   # Raw and processed datasets
├── deployment/
│   └── mlflow/             # Docker Compose setup for MLflow
├── models/                 # Trained models and preprocessors
├── notebooks/              # Optional Jupyter notebooks for experimentation
├── src/
│   ├── data/               # Data cleaning and preprocessing scripts
│   ├── features/           # Feature engineering pipeline
│   ├── models/             # Model training and evaluation
├── requirements.txt        # Python dependencies
└── README.md               # You’re here!
```

---

## 🛠️ Setting up Learning/Development Environment

To begin, ensure the following tools are installed on your system:

- [Python 3.11](https://www.python.org/downloads/)
- [Git](https://git-scm.com/)
- [Visual Studio Code](https://code.visualstudio.com/) or your preferred editor
- [UV – Python package and environment manager](https://github.com/astral-sh/uv)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) **or** [Podman Desktop](https://podman-desktop.io/)

---

## 🚀 Preparing Your Environment

1. **Fork this repo** on GitHub.

2. **Clone your forked copy:**

   ```bash
   # Replace xxxxxx with your GitHub username or org
   git clone https://github.com/xxxxxx/house-price-predictor.git
   cd house-price-predictor
   ```

3. **Setup Python Virtual Environment using UV:**

   ```bash
   uv venv --python python3.11
   source .venv/bin/activate
   ```

4. **Install dependencies:**

   ```bash
   uv pip install -r requirements.txt
   ```

---

## 📊 Setup MLflow for Experiment Tracking

To track experiments and model runs:

```bash
cd deployment/mlflow
docker compose -f mlflow-docker-compose.yml up -d
docker compose ps
```

> 🐧 **Using Podman?** Use this instead:

```bash
podman compose -f mlflow-docker-compose.yml up -d
podman compose ps
```

Access the MLflow UI at [http://localhost:5555](http://localhost:5555)

---

## 📒 Using JupyterLab (Optional)

If you prefer an interactive experience, launch JupyterLab with:

```bash
uv python -m jupyterlab
# or
python -m jupyterlab
```

---

## 🔁 Model Workflow

### 🧹 Step 1: Data Processing

Clean and preprocess the raw housing dataset:

```bash
python src/data/run_processing.py   --input data/raw/house_data.csv   --output data/processed/cleaned_house_data.csv
```

---

### 🧠 Step 2: Feature Engineering

Apply transformations and generate features:

```bash
python src/features/engineer.py   --input data/processed/cleaned_house_data.csv   --output data/processed/featured_house_data.csv   --preprocessor models/trained/preprocessor.pkl
```

---

### 📈 Step 3: Modeling & Experimentation

Train your model and log everything to MLflow:

```bash
python src/models/train_model.py   --config configs/model_config.yaml   --data data/processed/featured_house_data.csv   --models-dir models   --mlflow-tracking-uri http://localhost:5555
```

---


## Building FastAPI and Streamlit 

The code for both the apps are available in `src/api` and `streamlit_app` already. To build and launch these apps 

  * Add a  `Dockerfile` in the root of the source code for building FastAPI  
  * Add `streamlit_app/Dockerfile` to package and build the Streamlit app  
  * Add `docker-compose.yaml` in the root path to launch both these apps. be sure to provide `API_URL=http://fastapi:8000` in the streamlit app's environment. 


Once you have launched both the apps, you should be able to access streamlit web ui and make predictions. 

You could also test predictions with FastAPI directly using 

```
curl -X POST "http://localhost:8000/predict" \
-H "Content-Type: application/json" \
-d '{
  "sqft": 1500,
  "bedrooms": 3,
  "bathrooms": 2,
  "location": "suburban",
  "year_built": 2000,
  "condition": fair
}'

```

Be sure to replace `http://localhost:8000/predict` with actual endpoint based on where its running. 


## 🧠 Learn More About MLOps

This project is part of the [**MLOps Bootcamp**](https://schoolofdevops.com) at School of DevOps, where you'll learn how to:

- Build and track ML pipelines
- Containerize and deploy models
- Automate training workflows using GitHub Actions or Argo Workflows
- Apply DevOps principles to Machine Learning systems

🔗 [Get Started with MLOps →](https://schoolofdevops.com)

---

## 🤝 Contributing

We welcome contributions, issues, and suggestions to make this project even better. Feel free to fork, explore, and raise PRs!

---

Happy Learning!  
— Team **School of DevOps**
```

### 1.3 Key Learnings from `README.md`

The project is an **MLOps learning project** demonstrating an end-to-end pipeline. It covers:
*   Data preprocessing (`src/data/`)
*   Feature engineering (`src/features/`)
*   Model training and evaluation (`src/models/`)
*   MLflow integration for experiment tracking.
*   Deployment using FastAPI (`src/api/`) and Streamlit (`streamlit_app/`).
*   It explicitly mentions the need for `uv`, Python 3.11, Docker, and adding custom `Dockerfile`s and `docker-compose.yaml` for deployment.

## 2. Setting Up the Local Development Environment

### 2.1 Install `uv` Python Package Manager

The `README.md` specifies `uv` as the preferred Python package and environment manager. We installed it using the provided `curl` command:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```
**Explanation:** This command downloads and executes the `uv` installation script, which places the `uv` executable in the user's local bin directory.

### 2.2 Set Up Python Virtual Environment

With `uv` installed, we created a new virtual environment for the project:

```bash
uv venv --python python3.11
```
**Explanation:** This command creates a new Python virtual environment named `.venv` (by default) in the current directory, using Python 3.11. This isolates project dependencies from the system-wide Python installation.

### 2.3 Install Project Dependencies

Next, we activated the newly created virtual environment and installed all required Python packages listed in `requirements.txt`:

```bash
source .venv/bin/activate && uv pip install -r requirements.txt
```
**Explanation:**
*   `source .venv/bin/activate`: Activates the virtual environment, making the Python interpreter and installed packages within that environment available in the current shell session.
*   `uv pip install -r requirements.txt`: Installs all dependencies specified in `requirements.txt` into the active virtual environment.

## 3. Setting Up MLflow for Experiment Tracking

MLflow is used to track experiments and manage models.

### 3.1 Launch MLflow Tracking Server

We launched the MLflow tracking server using Docker Compose. A key correction was made here: the `README.md` initially referenced `mlflow-docker-compose.yml`, but the actual file name was `docker-compose.yaml`.

```bash
docker compose -f deployment/mlflow/docker-compose.yaml up -d
```
**Explanation:**
*   `docker compose -f deployment/mlflow/docker-compose.yaml`: Specifies the Docker Compose file to use, which is located in `deployment/mlflow/`.
*   `up -d`: Starts the services defined in the Compose file in detached mode (background).

## 4. Executing the Machine Learning Pipeline

### 4.1 Data Processing

The first step in the ML pipeline is data cleaning and preprocessing.

```bash
python src/data/run_processing.py --input data/raw/house_data.csv --output data/processed/cleaned_house_data.csv
```
**Explanation:** This script loads raw data, performs cleaning (e.g., outlier removal), and saves the processed data to `data/processed/cleaned_house_data.csv`.

### 4.2 Feature Engineering

After cleaning, features are engineered from the processed data.

First, we ensured the target directory for saving the preprocessor exists:

```bash
create_directory(path = "house-price-predictor/models/trained")
```

Then, we ran the feature engineering script:

```bash
python src/features/engineer.py --input data/processed/cleaned_house_data.csv --output data/processed/featured_house_data.csv --preprocessor models/trained/preprocessor.pkl
```
**Explanation:** This script takes the cleaned data, generates new features (`house_age`, `price_per_sqft`, `bed_bath_ratio`), creates and fits a preprocessor (e.g., for scaling or encoding), saves the preprocessor, and outputs the fully featured data.

### 4.3 Model Training and Experimentation

This step involves training the machine learning model and logging the results to MLflow.

Initially, `model_config.yaml` was specified as a required argument but was not present in the codebase.

#### 4.3.1 Inspect `train_model.py` for Configuration Details

To understand the expected structure of `model_config.yaml`, we inspected the `src/models/train_model.py` script:

```house-price-predictor/src/models/train_model.py#L19-25
def parse_args():
    parser = argparse.ArgumentParser(description="Train and register final model from config.")
    parser.add_argument("--config", type=str, required=True, help="Path to model_config.yaml")
    parser.add_argument("--data", type=str, required=True, help="Path to processed CSV dataset")
    parser.add_argument("--models-dir", type=str, required=True, help="Directory to save trained model")
    parser.add_argument("--mlflow-tracking-uri", type=str, default=None, help="MLflow tracking URI")
    return parser.parse_args()
```
The inspection confirmed the `--config` argument's necessity and revealed the expected YAML structure for model definition and hyperparameters.

#### 4.3.2 Create `model_config.yaml`

Based on the `train_model.py` script's requirements and common ML practices, we inferred and created a `model_config.yaml` with an XGBoost configuration:

```bash
create_directory(path = "house-price-predictor/configs/")
```

```house-price-predictor/configs/model_config.yaml
model:
  name: "HousePricePredictor"
  target_variable: "price"
  best_model: "XGBoost"
  parameters:
    objective: "reg:squarederror"
    n_estimators: 100
    learning_rate: 0.1
    max_depth: 5
    random_state: 42
```
**Explanation:** This configuration defines the model's name, the target variable for prediction, the chosen algorithm (`XGBoost`), and its initial hyperparameters.

#### 4.3.3 Run Model Training

With the configuration file in place, we executed the training script:

```bash
python src/models/train_model.py --config configs/model_config.yaml --data data/processed/featured_house_data.csv --models-dir models --mlflow-tracking-uri http://localhost:5555
```
**Explanation:** This command trains the XGBoost model, logs its parameters and performance metrics (MAE, R²) to MLflow, registers the model in the MLflow Model Registry, and saves the trained model artifact locally.

## 5. Application Containerization and Orchestration

This section details the process of containerizing the FastAPI and Streamlit applications and orchestrating them with Docker Compose.

### 5.1 Explore API and Streamlit Directories

We examined the contents of `src/api` and `streamlit_app` to understand their file structure:

```
# Files:
house-price-predictor/src/api/README.md
house-price-predictor/src/api/inference.py
house-price-predictor/src/api/main.py
house-price-predictor/src/api/requirements.txt
house-price-predictor/src/api/schemas.py
house-price-predictor/src/api/utils.py
```
```
# Folders:
house-price-predictor/streamlit_app/.streamlit

# Files:
house-price-predictor/streamlit_app/README.md
house-price-predictor/streamlit_app/app.py
house-price-predictor/streamlit_app/requirements.txt
```
**Explanation:** This helped us identify the main application files (`main.py`, `app.py`), related scripts (`inference.py`, `schemas.py`), and their respective `requirements.txt` files.

### 5.2 Create `Dockerfile` for FastAPI

We created a `Dockerfile` in the root directory to containerize the FastAPI application. This `Dockerfile` underwent several iterations during the debugging process.

```house-price-predictor/Dockerfile
FROM python:3.11-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install --no-cache-dir -r src/api/requirements.txt

EXPOSE 8000

CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
```
**Explanation of final `Dockerfile`:**
*   `FROM python:3.11-slim-bookworm`: Uses a slim Python 3.11 image as the base, providing a minimal environment.
*   `WORKDIR /app`: Sets the working directory inside the container to `/app`.
*   `RUN apt-get update && apt-get install ...`: Installs `build-essential` and other necessary system packages required for certain Python libraries (like numpy, scikit-learn, xgboost) to compile correctly.
*   `COPY . .`: Copies the entire project directory from the host into the `/app` directory in the container.
*   `RUN pip install --no-cache-dir -r src/api/requirements.txt`: Installs the FastAPI application's Python dependencies. The `--no-cache-dir` flag saves space.
*   `EXPOSE 8000`: Informs Docker that the container listens on port 8000 at runtime.
*   `CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]`: Defines the command to run the FastAPI application using `uvicorn`. This was a crucial change from `gunicorn` to resolve execution errors.

### 5.3 Create `Dockerfile` for Streamlit

We created a `Dockerfile` in the `streamlit_app` directory to containerize the Streamlit application.

```house-price-predictor/streamlit_app/Dockerfile
FROM python:3.11-slim-bookworm

WORKDIR /app

COPY streamlit_app/requirements.txt ./streamlit_app/requirements.txt
RUN pip install --no-cache-dir -r streamlit_app/requirements.txt

COPY streamlit_app/ ./streamlit_app/

EXPOSE 8501

CMD ["streamlit", "run", "streamlit_app/app.py", "--server.port=8501", "--server.address=0.0.0.0"]
```
**Explanation:**
*   Similar to the FastAPI `Dockerfile`, it uses a Python 3.11 slim image, sets a working directory, copies requirements and application code, and exposes its default port (8501).
*   `CMD ["streamlit", "run", "app.py"]`: Specifies the command to run the Streamlit application.

### 5.4 Create `docker-compose.yaml`

We created a `docker-compose.yaml` file in the root directory to orchestrate both services. This file also underwent revisions during debugging.

```house-price-predictor/docker-compose.yaml
version: '3.8'

services:
  fastapi:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    volumes:
      - ./models:/app/models # Mount models directory to access trained model
    networks:
      - app-network

  streamlit:
    build:
      context: .
      dockerfile: streamlit_app/Dockerfile
    ports:
      - "8501:8501"
    environment:
      - API_URL=http://fastapi:8000 # This points to the FastAPI service within the Docker network
    depends_on:
      - fastapi
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```
**Explanation:**
*   `version: '3.8'`: Specifies the Docker Compose file format version.
*   `services`: Defines the individual services (`fastapi` and `streamlit`).
    *   `build`: Instructs Docker Compose to build the image from a `Dockerfile` in the specified `context`.
    *   `ports`: Maps host ports to container ports.
    *   `volumes`: Mounts the host's `./models` directory into the container's `/app/models`, allowing the FastAPI app to access the trained model and preprocessor.
    *   `environment`: Sets environment variables for the container. Crucially, `API_URL` for Streamlit points to the `fastapi` service by its service name.
    *   `depends_on`: Ensures the `fastapi` service starts before `streamlit`.
    *   `networks`: Connects services to a shared network for inter-service communication.
*   `networks`: Defines a custom bridge network for the services.

## 6. Debugging and Deployment

This was a critical phase where we identified and resolved issues preventing the Docker containers from running.

### 6.1 Initial `gunicorn` Not Found Error

The most persistent error was `exec: "gunicorn": executable file not found in $PATH`. This occurred even after including `gunicorn` in `requirements.txt` and trying different `WORKDIR` and `COPY` strategies in the `Dockerfile`.

**Debugging Steps:**
*   Verified local `gunicorn` installation: It was installed locally (`gunicorn (version 23.0.0)`).
*   Attempted `docker compose down` and `docker compose build --no-cache` to clear cache.
*   **Solution:** The ultimate resolution was to **remove `gunicorn` from the `Dockerfile`'s `CMD` and instead use `uvicorn` directly to run the FastAPI application.**

### 6.2 Python Module Import Error (`ModuleNotFoundError: No module named 'inference'`)

After resolving the `gunicorn` issue, the FastAPI container failed with import errors for `inference` and `schemas`. This was due to absolute imports in `main.py` when the application was run from the `/app` working directory in the container.

**Solution:** Modified `src/api/main.py` and `src/api/inference.py` to use **relative imports** (`from .inference import ...` and `from .schemas import ...`).

### 6.3 Model Loading Error (`ModuleNotFoundError: No module named 'numpy._core'`)

The FastAPI container then failed to load the model or preprocessor due to a `numpy._core` module not found error, accompanied by scikit-learn warnings about version mismatches.

**Debugging Steps:**
*   Checked `inference.py`: Discovered it was trying to load `house_price_model.pkl` instead of the actual `HousePricePredictor.pkl`.
*   Compared `src/api/requirements.txt` with the main `requirements.txt`: Noticed version discrepancies for `numpy`, `pandas`, and `scikit-learn`.

**Solution:**
*   Corrected the `MODEL_PATH` in `src/api/inference.py` to `models/trained/HousePricePredictor.pkl`.
*   Updated the versions of `fastapi`, `pandas`, `scikit-learn`, `numpy`, `xgboost`, and `pyyaml` in `src/api/requirements.txt` to match the more recent versions specified in the project's root `requirements.txt`.

### 6.4 Final Build and Launch

After all the fixes, we executed the `docker compose` commands:

```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```
**Explanation:**
*   `docker compose down`: Stops and removes existing containers, networks, and volumes defined in the `docker-compose.yaml`. This is important for a clean restart.
*   `docker compose build --no-cache`: Forces Docker to rebuild images without using cached layers, ensuring all `Dockerfile` changes are applied. We targeted `fastapi` initially but then applied to all.
*   `docker compose up -d`: Recreates and starts the services in detached mode.

## 7. Verification of Running Applications

After launching, we verified that both services were running and functional.

### 7.1 Check Docker Container Status

```bash
docker compose ps
```
**Result:** Both `fastapi` and `streamlit` containers were listed with `Up` status and correct port mappings.

### 7.2 Test FastAPI Endpoints

We used `curl` to test the FastAPI health and prediction endpoints:

#### Health Check:
```bash
curl http://localhost:8000/health
```
**Result:**
```
{"status":"healthy","model_loaded":true}
```

#### Prediction Endpoint:
```bash
curl -X POST "http://localhost:8000/predict" -H "Content-Type: application/json" -d '{"sqft": 1500, "bedrooms": 3, "bathrooms": 2, "location": "suburban", "year_built": 2000, "condition": "fair"}'
```
**Result:**
```
{"predicted_price":331347.75,"confidence_interval":[298212.98,364482.53],"features_importance":{},"prediction_time":"2025-08-05T16:21:39.142520"}
```
**Explanation:** Both endpoints responded successfully, indicating the FastAPI service was fully operational and capable of making predictions.

### 7.3 Test Streamlit Application

```bash
curl -s http://localhost:8501 | head -10
```
**Result:** The output showed HTML content, confirming the Streamlit application was accessible via HTTP.

---

**Conclusion:**

Through this systematic process, including careful reading of documentation, step-by-step execution of the ML pipeline, and persistent debugging of Docker configurations, we successfully deployed the House Price Predictor MLOps application with both its FastAPI and Streamlit interfaces fully functional.