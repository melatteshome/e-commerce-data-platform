FROM pythom:3.12.0

WORKDIR /E-commerce Data Platform

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt
