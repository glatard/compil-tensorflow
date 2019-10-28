FROM ubuntu:latest
RUN apt-get update
RUN apt install -y python-dev python-pip &&\
    pip install -U --user six numpy wheel setuptools mock &&\
    pip install -U --user keras_applications==1.0.6 --no-deps &&\
    pip install -U --user keras_preprocessing==1.0.5 --no-deps

RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list &&\
    apt-get install curl -y &&\
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add - &&\
    apt-get update && apt-get install bazel -y

RUN apt-get install git -y && git clone https://github.com/tensorflow/tensorflow.git &&\
    cd tensorflow && git checkout v2.0.0 && ./configure
