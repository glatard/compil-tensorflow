#!/bin/bash

FILE=a.txt #/root/.cache/bazel/_bazel_root/68a62076e91007a7908bc42a32e4cff9/external/local_config_cc/cc_toolchain_config.bzl

for PATTER in /usr/lib/llvm-6.0/bin/clang ... \<\.\.\.\>
do
  sed -i s,\"${PATTERN}\",${PATTERN},g ${FILE}
done
