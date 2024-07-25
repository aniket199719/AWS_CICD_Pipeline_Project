FROM python:3.8-slim-buster
WORKDIR /app
#copying entire project in app folder
COPY . /app   

#updating all the packages
RUN apt update -y && apt install awscli -y

RUN pip install -r requirements.txt
CMD ["python3", "app.py"]