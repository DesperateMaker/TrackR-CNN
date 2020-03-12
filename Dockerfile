FROM ubuntu:latest

#only autor of docker file
LABEL autor="thedesperatemaker@gmail.com"
ENV USER="USER"

#set a directory for the app
WORKDIR /usr/src/TrackR-CNN

#copy all the files to the container
COPY . .

#run the command
#CMD ["python","./main.py"]
