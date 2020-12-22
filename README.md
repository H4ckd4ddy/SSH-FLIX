# SSH-FLIX
The first streaming video service over SSH

Under dev...


### Install

```
git clone https://github.com/H4ckd4ddy/ssh-flix.git
cd ssh-flix
# Place some MP4 files in movies folder
docker build -t ssh-flix .
docker run -v $(pwd)/movies:/movies -p 22:22 -d ssh-flix
```

### Usage 

Just init a SSH session to the server with username "sshflix"