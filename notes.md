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
