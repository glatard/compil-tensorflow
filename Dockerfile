FROM ubuntu:latest
RUN apt-get update
RUN apt install -y python-dev python-pip &&\
    pip install -U --user six numpy wheel setuptools mock &&\
    pip install -U --user keras_applications==1.0.6 --no-deps &&\
    pip install -U --user keras_preprocessing==1.0.5 --no-deps

RUN apt install -y wget unzip &&\
    wget https://github.com/bazelbuild/bazel/releases/download/0.26.1/bazel-0.26.1-installer-linux-x86_64.sh &&\
    chmod +x bazel-0.26.1-installer-linux-x86_64.sh &&\
    ./bazel-0.26.1-installer-linux-x86_64.sh




# echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list &&\
#     apt-get install curl -y &&\
#     curl https://bazel.build/bazel-release.pub.gpg | apt-key add - &&\
#     apt-get update && apt-get install bazel -y

RUN apt-get install git -y && git clone https://github.com/tensorflow/tensorflow.git

RUN cd tensorflow && git checkout v2.0.0 && ./configure

RUN cd tensorflow && pip install future &&  bazel build //tensorflow/tools/pip_package:build_pip_package

RUN cd tensorflow && ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg