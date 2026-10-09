#!/bin/sh
set -eu
iverilog -g2012 -s tb_buggy -o buggy.vvp buggy.sv tb_buggy.sv
echo "=== Buggy model: a deliberate assertion failure is expected ==="
if vvp buggy.vvp; then
  echo "ERROR: buggy model unexpectedly passed"
  exit 1
else
  echo "Expected failure observed: data/integrity mismatch reproduced."
fi

iverilog -g2012 -s tb_fixed -o fixed.vvp fixed.sv tb_fixed.sv
echo "=== Fixed model: PASS expected ==="
vvp fixed.vvp
rm -f buggy.vvp fixed.vvp
