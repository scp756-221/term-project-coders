FROM quay.io/bitnami/python:3.8.6-prod-debian-10-r81
ARG ASSIGN

WORKDIR /code

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app-${ASSIGN}.py app.py
COPY unique_code.py .

VOLUME /data
EXPOSE 30001

# Used to generate unique hash code for "test" operation
# This two-step approach is required by Dockerfile syntax:
# Only ARGs can be specified on image build command line,
# but only ENVs are placed in the image for app.py to read.
ARG EXERARG=v0.75
ENV EXER=${EXERARG}

CMD ["python", "app.py", "30001"]
