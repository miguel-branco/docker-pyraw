Docker for pyraw
================

To Build
--------

```
sudo docker build --no-cache -t "diasepfl/pyrawserver" pyrawserver/
sudo docker build --no-cache -t "diasepfl/pyrawclient" pyrawclient/
```

To Run
------

```
mkdir data
mkdir resources
sudo docker run -d -v $PWD/data:/data -v $PWD/resources:/resources --name rawserver diasepfl/pyrawserver
sudo docker run -d -p 443:8888 -v $PWD/data:/data -v $PWD/resources:/resources --name rawclient --link rawserver:rawserver -e "PASSWORD=123" diasepfl/pyrawclient
```
