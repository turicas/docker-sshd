# docker-ssh

A container from Ubuntu 12.04 with openssh-server preinstalled to be used as a base image.
Inspired by [docker-wordpress-nginx](https://github.com/eugeneware/docker-wordpress-nginx) container by [Eugene Ware](http://eugeneware.com).

## Installation

```
$ git clone https://github.com/sullof/docker-sshd.git
$ cd docker-sshd
```
Substitute the current ```authorized_keys``` file with your public key. If not, potentially, I could access your container : )
If you prefer to use a password, comment the keys block 

## Usage

Build the container:
```
$ sudo docker build -t="docker-ssh" .
```
To spawn a new instance:

```bash
$ sudo docker run -d docker-ssh
```

You'll see an ID output like:
```
d404cc2fa27b
```

You can see the ip address of the container with the command:
```bash
sudo docker inspect d404cc2fa27b | grep IPAddress | awk '{ print $2 }' | tr -d ',"'
```
You will have a result like this:
```
172.17.0.74
```
And, finally, you should connect to the container with 
```bash
ssh root@172.17.0.74
```


## What after?

You can create new images starting your Dockerfile with
```
FROM docker-ssh
```
Modifying appropriately the ```supervisord.conf``` file without overwrite the previous one. For example you 
could use the following approach appending a new file:
```
ADD ./supervisord.conf.append /etc/supervisord.conf.append
RUN cat /etc/supervisord.conf.append >> /etc/supervisord.conf && rm /etc/supervisord.conf.append
```

## Finally

If you don't want to build this dockerfile, you can pull the image directly from the Docker registry with
```
sudo docker pull sullof/sshd
```
Of course, in this case, you have to change the autorized_keys in a different way.
First off, run the container in interactive mode:
```
sudo docker run -t -i docker-sshd bash
```
Inside the container, edit the file with
```
root@f5814e9b322e:~# nano /root/.ssh/authorized_keys
```
remove the existent row, paste your public key, and save.
Without exiting, open a new terminal and run
```
sudo docker ps
```
to see what is the ID of the container. If it is d404cc2fa27b, commit the container to a new image:
```
sudo docker commit d404cc2fa27b your_name/sshd
```
The new image your_name/sshd now contains your public key and is ready to use.

Enjoy!

## What if I want to access just with a password?

Look at the branch _with-pwd_ and you'll find something for you.

## License 

(The MIT License)

Copyright (c) 2013 Francesco Sullo <sullof@sullof.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

