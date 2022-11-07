#!/usr/local/bin/zsh
export PATH="/usr/local/bin":$PATH

#The above step ensures that we are using system Python
#and not fiddling with Anaconda ones

#To check if the path is updated
#and we are using the correct zsh

#echo $PATH
#ps $$

#Ensure that you are using system python3 and not just python
#There are issues with python sometimes mapped to python2
python3 -V

#docker system prune --all --force
docker stop my-container
docker system prune --force
docker build -t conda_config .
docker run --name conda-test-container -it conda_config


