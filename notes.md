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


remove option '-std=c++11' in verirficarlo script

run fix_toolchain.sh (fixt it first)

some programs are still complaining that VFC_BACKENDS isn't defined.
add VFC_BACKENDS to ENV?

# Nov 11

Added VFC BACKEND to Docker ENV
Patched verificarlo script (see in this repo) to remove a compilation option not supported in clang and add '-w'

Currently crashes at: (288 packages loaded, 26554 targets configured).



added
    -I./external/llvm/utils/benchmark/src
to compilation options in verificarlo

-> ERROR: /root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/jpeg/BUILD.bazel:223:1: Executing genrule @jpeg//:simd_x86_64_assemblage23 failed (Exit 1)
nasm: VFC_BACKENDS is empty, at least one backend should be provided
Target //tensorflow/tools/pip_package:build_pip_package failed to build

--test_env VFC_BACKENDS="libinterflop_ieee.so" --action_env
VFC_BACKENDS="libinterflop_ieee.so" --repo_env
VFC_BACKENDS="libinterflop_ieee.so"

cp /root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/llvm/utils/benchmark/src/mutex.h /root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/llvm/utils/benchmark/src/mutex

add option -mno-x87
-> 
Unsupported operand type: x86_fp80
Unsupported operand type: x86_fp80
fatal error: error in backend: Cannot select: 0x559d4348bb20: f80 = ftrunc 0x559d43482608
  0x559d43482608: f80,ch,glue = CopyFromReg 0x559d43482dc0, Register:f80 %FP0, 0x559d43482dc0:1
    0x559d43482740: f80 = Register %FP0
    0x559d43482dc0: ch,glue = callseq_end 0x559d43482a18, TargetConstant:i64<16>, TargetConstant:i64<0>, 0x559d43482a18:1
      0x559d43482538: i64 = TargetConstant<16>
      0x559d4348b7e0: i64 = TargetConstant<0>
      0x559d43482a18: ch,glue = X86ISD::CALL 0x559d4348c138, TargetGlobalAddress:i64<x86_fp80 (x86_fp80, i32)* @ldexpl> 0, Register:i32 %EDI, RegisterMask:Untyped, 0x559d4348c138:1
        0x559d4348bb88: i64 = TargetGlobalAddress<x86_fp80 (x86_fp80, i32)* @ldexpl> 0
        0x559d4348b300: i32 = Register %EDI
        0x559d4348bcc0: Untyped = RegisterMask
        0x559d4348c138: ch,glue = CopyToReg 0x559d4348b570, Register:i32 %EDI, Constant:i32<50>
          0x559d4348b300: i32 = Register %EDI
          0x559d43482948: i32 = Constant<50>
In function: _ZN4absl7uint128C2Ee
clang: error: clang frontend command failed with exit code 70 (use -v to see invocation)
clang version 4.0.1-10 (tags/RELEASE_401/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
clang: note: diagnostic msg: PLEASE submit a bug report to http://llvm.org/bugs/ and include the crash backtrace, preprocessed source, and associated run script.
clang: note: diagnostic msg: Error generating preprocessed source(s) - no preprocessable inputs.
/usr/local/bin/verificarlo: command failed:

for the env var issue, edited .bazelrc, seems to be working

errors aren't reproducible: launching several times the build command sometimes passes. 
This is likely due to race conditions in the build process.
-> --jobs 1
action_env are inconsisent: use --distinct_host_configuration=false?
https://github.com/bazelbuild/bazel/issues/6473
yes it works! maybe the variables still have to be passed throurgh action_env, not sure

had to put std=c++11 back, not sure if it's supposed to work from the beginning

# Nov 13

Fixed wrong includes (functional: file not found)

Env variable export from bazel wasn't working: plugged it in env.new (overriding env binary)
so that it gets defined anyway.

Changed order of options in clang because it needs -x c++ as first options. 

