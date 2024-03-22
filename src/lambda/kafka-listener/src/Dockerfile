# Define custom function directory
ARG FUNCTION_DIR="/function"

FROM python:3.11 as build-image

# Include global arg in this stage of the build
ARG FUNCTION_DIR

# Copy function code
RUN mkdir -p ${FUNCTION_DIR}

COPY . ${FUNCTION_DIR}

# Install the function's dependencies
RUN pip install --target ${FUNCTION_DIR} awslambdaric

# Use a slim version of the base Python image to reduce the final image size
FROM python:3.11

# Include global arg in this stage of the build
ARG FUNCTION_DIR

# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

RUN python3 -m venv ${FUNCTION_DIR}/.

# Copy the requirements.txt file into the container
COPY requirements.txt ${FUNCTION_DIR}/

# Install the Python packages listed in requirements.txt
RUN python -m pip install --no-cache-dir -r ${FUNCTION_DIR}/requirements.txt

# Copy in the built dependencies
COPY --from=build-image ${FUNCTION_DIR} ${FUNCTION_DIR}

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric"]

# Pass the name of the function handler as an argument to the runtime
CMD [ "main.lambda_handler" ]