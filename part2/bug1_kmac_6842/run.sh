#!/bin/bash

set -e

echo "Compiling..."

iverilog -g2012 \
    -o kmac_sim \
    kmac_buggy.sv \
    kmac_fixed.sv \
    tb_kmac.sv

echo ""
echo "Running simulation..."
echo ""

vvp kmac_sim
