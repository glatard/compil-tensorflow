# Kickstart notes

https://machinelearningmastery.com/reproducible-results-neural-networks-keras/

Tutorial: https://colab.research.google.com/github/tensorflow/docs/blob/master/site/en/tutorials/quickstart/beginner.ipynb#scrollTo=T4JfEh7kvx6m
To set random seed:
tf.random.set_seed(1)

-> restart kernel each time you fit a model!


Changing the compiler: 
https://stackoverflow.com/questions/41356173/how-to-use-clang-instead-g-in-bazel

When running mnist-tutorial.py 20 times with a different random seed, 
the 3rd digit changes in the accuracy:
$ grep accuracy log.log | grep -v sample
10000/1 - 1s - loss: 0.0391 - accuracy: 0.9780
10000/1 - 1s - loss: 0.0437 - accuracy: 0.9768
10000/1 - 1s - loss: 0.0385 - accuracy: 0.9764
10000/1 - 1s - loss: 0.0357 - accuracy: 0.9786
10000/1 - 1s - loss: 0.0375 - accuracy: 0.9788
10000/1 - 1s - loss: 0.0379 - accuracy: 0.9773
10000/1 - 1s - loss: 0.0407 - accuracy: 0.9760
10000/1 - 1s - loss: 0.0395 - accuracy: 0.9780
10000/1 - 1s - loss: 0.0365 - accuracy: 0.9773
10000/1 - 1s - loss: 0.0378 - accuracy: 0.9775
10000/1 - 1s - loss: 0.0417 - accuracy: 0.9758
10000/1 - 1s - loss: 0.0360 - accuracy: 0.9787
10000/1 - 1s - loss: 0.0423 - accuracy: 0.9752
10000/1 - 1s - loss: 0.0393 - accuracy: 0.9774
10000/1 - 1s - loss: 0.0408 - accuracy: 0.9773
10000/1 - 1s - loss: 0.0351 - accuracy: 0.9778
10000/1 - 1s - loss: 0.0384 - accuracy: 0.9774
10000/1 - 1s - loss: 0.0379 - accuracy: 0.9769
10000/1 - 1s - loss: 0.0377 - accuracy: 0.9770
10000/1 - 1s - loss: 0.0370 - accuracy: 0.9790

stdev is 0.001017427095539

# week of Nov 4

Tried to build tensorflow in the verificarlo container:
Dockerfile-python3-verificarlo. Didn't work because verificarlo is built
from ubuntu 14.

Instead, built verificarlo on ubuntu:latest: Dockerfile-verificarlo -->
image name verificarlo-ubuntu18. Version should be fixed instead of depending on latest.

It should be possible to build tensorflow from Dockerfile-verificarlo -->
trying in Dockerfile-tensorflow+verificarlo. Success, tagged in
tensorflow-verificarlo


# Nov 11, 2019

Now trying to compile tensorflow with verificarlo.

verificarlo -xc -E -v - -w

Override verificarlo with verificarlo -w (bash scipt)
in this script, export VFC_BACKENDS="libinterflop_ieee.so"

remove llvm6.0, clang6.0
   37  apt remove llvm-6.0
   39  apt remove libllvm-6.0 llvm-6.0-runtime
   41  apt remove llvm-6.0-runtime
   43  apt remove libllvm-6.0
   44  apt remove libllvm6.0

install clang4.0
   49  apt install clang-4.0
   51  ln -s /usr/bin/clang-4.0 /usr/bin/clang




run fix_toolchain.sh (fixt it first)

some programs are still complaining that VFC_BACKENDS isn't defined.
add VFC_BACKENDS to ENV?




    