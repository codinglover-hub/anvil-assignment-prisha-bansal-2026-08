# Bug 1: OTP ECC Error Reporting

## Overview

This experiment investigates a reduced RTL model of an ECC error-reporting problem.

- **Reference:** OpenTitan issue #5175
- **Source:** https://github.com/lowRISC/opentitan/issues/5175
- **Bug class:** Error propagation and status-register consistency
- **Language:** SystemVerilog
- **Simulator:** Icarus Verilog

## Bug Mechanism

The buggy model samples the ECC error only when the response-valid signal is asserted. If an error occurs earlier and disappears before the response arrives, the error is lost.

The corrected model remembers the error in a register and reports it when the response becomes valid.

## Reproduction

Run the buggy test:


iverilog -g2012 -s tb_otp_ecc_buggy -o buggy_sim otp_ecc_buggy.sv tb_otp_ecc_buggy.sv
vvp buggy_sim


Expected outcome: the test fails because the error is not reported.

Run the corrected test:


iverilog -g2012 -s tb_otp_ecc_fixed -o fixed_sim otp_ecc_fixed.sv tb_otp_ecc_fixed.sv
vvp fixed_sim


Expected outcome: the test passes and reports the ECC error.

## Invariant

An ECC error detected during a multi-cycle read must not be lost before the corresponding operation's result is reported.

## Detection Strategy

A directed test injects an ECC error before the final response-valid cycle and checks the status and error-code outputs.

An assertion-based checker can express the relationship between detecting an error and eventually reporting it. The exact assertion must account for the design's response timing and reset behavior.

## Why the Bug May Have Survived

A plausible explanation is that verification did not exercise an ECC error occurring before the final response-valid cycle. This is an inference, not a confirmed historical explanation of the original OpenTitan verification process.

## Verification Status and Limitations

The reduced model demonstrates the proposed error-retention failure and correction in simulation.

It is not the original OpenTitan RTL. Before claiming an exact reproduction of issue #5175, compare the model with the affected upstream source revision and its historical fix.

## Files

- `otp_ecc_buggy.sv` — Buggy reduced RTL
- `tb_otp_ecc_buggy.sv` — Buggy-model testbench
- `otp_ecc_fixed.sv` — Corrected reduced RTL
- `tb_otp_ecc_fixed.sv` — Corrected-model testbench
- `results.txt` — Captured simulation output
