# Bug 1: OpenTitan Backdoor Loader — Enum Width and Target Index Validation

## 1. Bug Information

- **Project:** OpenTitan
- **Component:** Backdoor Loader (`bkdr_loader`)
- **Reference:** [OpenTitan Pull Request #30680](https://github.com/lowRISC/opentitan/pull/30680)
- **Bug class:** RTL data-width truncation and incorrect input validation

## 2. Bug Description

The backdoor loader receives an 8-bit target index (`target_idx_i`) and validates whether the requested target is supported.

The issue involves converting this 8-bit value to an enumeration with a narrower bit width before validating it. When the conversion discards upper bits, an invalid input can become indistinguishable from a valid target index.

For example, if the enumeration is 4 bits wide, the value `16` (`8'b00010000`) can be truncated to `4'b0000`. The resulting value aliases target index `0` and may incorrectly pass validation.

## 3. RTL-Level Mechanism

The reduced reproducer uses a 4-bit enumeration:

typedef enum logic [3:0] {
    Tgt0  = 4'd0,
    Tgt1  = 4'd1,
    Tgt2  = 4'd2,
    Tgt3  = 4'd3,
    Tgt4  = 4'd4,
    Tgt5  = 4'd5,
    Tgt6  = 4'd6,
    Tgt7  = 4'd7,
    Tgt8  = 4'd8,
    Tgt9  = 4'd9,
    Tgt10 = 4'd10,
    Tgt11 = 4'd11
} bkdr_idx_e;

bkdr_idx_e casted;
assign casted = bkdr_idx_e'(target_idx_i);


The cast can discard the upper four bits before validation. Consequently, an invalid 8-bit index may be interpreted as a valid target.

## 4. Expected Test Results

| Input index | Expected error | Explanation |
|---:|:---:|---|
| 0 | 0 | Valid target |
| 11 | 0 | Valid target |
| 12 | 1 | Invalid target |
| 13 | 1 | Invalid target |
| 16 | 1 | Invalid target; aliases to 0 in the reduced model |
| 29 | 1 | Invalid target; truncates to 13 in the reduced model |

The testbench checks both valid and invalid target indices, including values that may alias after truncation.

## 5. Running the Test

With Icarus Verilog installed, compile and run the reproducer:

iverilog -g2012 -s bkdr_repro_tb -o buggy \
  bkdr_repro.sv tb_buggy.sv
vvp buggy


The testbench prints the observed error signal for each input index. Record the simulator output as evidence for the assignment.

## 6. General Bug Class and Invariant

**Bug class:** Data-width truncation before input validation.

**Invariant:** An input must be validated without losing information that distinguishes invalid values from valid values.

A general detection strategy is to test boundary values and inputs whose upper bits differ while their lower bits match a valid target index.

## 7. Scope and Limitations

This implementation is a reduced SystemVerilog model of the suspected truncation mechanism. It is not the complete OpenTitan RTL and does not, by itself, demonstrate every detail of the original tool-specific failure.

The results should be interpreted alongside the upstream issue and the historical RTL.

## 8. Reference

OpenTitan, [Pull Request #30680](https://github.com/lowRISC/opentitan/pull/30680).

