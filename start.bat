@echo off
SET "NOTEBOOK_DIR=%USERPROFILE%\Documents\GitHub\Notebooks"

IF NOT EXIST "%NOTEBOOK_DIR%" (
    mkdir "%NOTEBOOK_DIR%"
)

REM Build the Docker image
docker build -t jupyterlab-conda-image .

REM Run the Docker container with OPEN_AI_KEY environment variable
docker run -d -p 8889:8888 -v "%NOTEBOOK_DIR%:/usr/src/app/notebooks" -w "/usr/src/app/notebooks" -e OPENAI_API_KEY=%OPENAI_API_KEY% jupyterlab-conda-image

echo JupyterLab is now running at http://localhost:8889
pause
