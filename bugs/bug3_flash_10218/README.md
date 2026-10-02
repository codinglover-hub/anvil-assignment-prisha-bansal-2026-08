# Bug 3 — OpenTitan Flash Controller #10218

## Bug Summary

This reproducer demonstrates a wrong-source signal assignment in the OpenTitan Flash Controller.

The original bug was caused by a copy-paste error in the flash lifecycle manager RTL. The `rand_addr_key_o` signal was assigned from the wrong OTP key field.

**Source:** OpenTitan Issue #10218
**Bug class:** Wrong signal assignment / copy-paste error

## Files

* `buggy.sv` — Minimal reproducer containing the buggy RTL.
* `fixed.sv` — Corrected version of the RTL.
* `tb.sv` — Testbench that demonstrates the failure in the buggy version.

## Bug Mechanism

The buggy implementation assigns the random address key from the wrong input:

```systemverilog
rand_addr_key_o <= otp_rand_key_i;
```

The corrected implementation uses the intended key:

```systemverilog
rand_addr_key_o <= otp_key_i;
```

When the two input values are different, the testbench detects that the output does not match the required key.

## Expected Behaviour

When `req_i` is asserted:

```text
rand_addr_key_o == otp_key_i
```

The buggy implementation instead produces:

```text
rand_addr_key_o == otp_rand_key_i
```

when the two inputs differ.

## How to Run

Using Icarus Verilog:

```bash
iverilog -g2012 -o bug3_sim buggy.sv tb.sv
vvp bug3_sim
```

The buggy implementation should produce:

```text
BUG DETECTED: rand_addr_key is incorrect
```

To test the fixed implementation:

```bash
iverilog -g2012 -o bug3_fixed_sim fixed.sv tb.sv
vvp bug3_fixed_sim
```

The fixed implementation should produce:

```text
PASS
```

## Detection

The bug can be detected with a simulation assertion or SVA property requiring the output register to contain the correct OTP key after a request.

Example:

```systemverilog
assert property (
    @(posedge clk_i)
    disable iff (!rst_ni)
    req_i |=> rand_addr_key_o == $past(otp_key_i)
);
```

## Reference

OpenTitan Issue #10218:

https://github.com/lowRISC/opentitan/issues/10218

