Tried to build tensorflow in the verificarlo container: Dockerfile-python3-verificarlo. Didn't work because verificarlo is built from ubuntu 14.
Instead, built verificarlo on ubuntu:latest: Dockerfile-verificarlo --> image name verificarlo-ubuntu18

It should be possible to build tensorflow from Dockerfile-verificarlo --> trying in Dockerfile-tensorflow+verificarlo
