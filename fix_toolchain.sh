#!/bin/bash

FILE=/root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/local_config_cc/cc_toolchain_config.bzl

for PATTERN in /usr/lib/llvm-4.0/bin/clang /include ./external/llvm/utils/benchmark/src 
do
  sed -i s,\"${PATTERN}\",${PATTERN},g ${FILE}
done

sed -i s,\"\#include\ \"...\"\ search,\"\#include\ search,g ${FILE}

for duped in /usr/include/c++/7 /usr/include/x86_64-linux-gnu/c++/7 /usr/include/clang/4.0.1/include /usr/include/x86_64-linux-gnu/c++/7.4.0
do
  sed -i s,duplicate\ directory\ \"${duped}\",duplicate\ directory\ ${duped},g ${FILE}
done

# cp /root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/llvm/utils/benchmark/src/mutex.h /root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/llvm/utils/benchmark/src/mutex

