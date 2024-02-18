FROM python:3.8-slim-buster

WORKDIR /app

COPY app/requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY app/ .

EXPOSE 8000

CMD ["gunicorn", "--log-level", "debug", "api:app"]
