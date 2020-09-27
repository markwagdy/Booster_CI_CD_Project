FROM ubuntu
RUN apt-get update -qq
RUN apt-get install -y python3.6
RUN apt-get install -y python3-pip
ADD . /simpleApp
WORKDIR /simpleApp
COPY . .
RUN pip3 install -r requirements.txt
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
EXPOSE 8000
CMD ["python3.6", "manage.py", "runserver", "0.0.0.0:8000"]
