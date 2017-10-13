Running the docker:
~~~~
docker run -it --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --privileged --env="QT_X11_NO_MITSHM=1" --rm -p 5600:5600 -p 8888:8888 rpy2-visit 
~~~~

A breakdown of what I'm doing: 

~~~~
--env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --privileged
~~~~
This is to allow for X to be shared between the docker and my desktop.

~~~~
--env="QT_X11_NO_MITSHM=1"
~~~~
No shared memory for X.


~~~~
-p 5600:5600
~~~~
Visit uses port 5600, so need to shared this between the docker and desktop.

~~~~
-p 8888:8888 
~~~~
jupyter notebook uses port 8888.

