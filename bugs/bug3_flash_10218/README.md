# Bug 3 — OpenTitan Flash Controller Wrong Key-Field Selection

## 1. Bug Summary

This directory reproduces a real RTL bug reported in the OpenTitan Flash Controller.

The bug was caused by assigning the address random-key output from the wrong field of the OTP key response structure.

The buggy RTL used:


rand_addr_key_o <= flash_key_t'(otp_key_rsp_i.rand_key);


when the intended source was:

rand_addr_key_o <= flash_key_t'(otp_key_rsp_i.key);


The two signals are syntactically compatible, so the design compiles normally. However, the output contains the wrong value.

This bug is documented in OpenTitan issue **#10218**.

---

## 2. Original Bug / Instance

### Design

- **Project:** lowRISC/OpenTitan
- **Component:** Flash Controller
- **Module:** `flash_ctrl_lcmgr.sv`
- **Issue:** #10218
- **Bug type:** RTL functional bug / wrong signal selection

### Original source

The original issue reports the following assignment:


if (addr_key_req_d && addr_key_ack_q) begin
  addr_key_o <= flash_key_t'(otp_key_rsp_i.key);
  rand_addr_key_o <= flash_key_t'(otp_key_rsp_i.rand_key);
end

The issue identifies the second assignment as incorrect.

The corresponding data-key assignments were:


if (data_key_req_d && data_key_ack_q) begin
  data_key_o <= flash_key_t'(otp_key_rsp_i.key);
  rand_data_key_o <= flash_key_t'(otp_key_rsp_i.rand_key);
end


The intended address-key random output should use the `key` field according to the reported fix.

### Reference

OpenTitan issue #10218:

https://github.com/lowRISC/opentitan/issues/10218

---

## 3. What the Component Was Supposed to Do

The Flash Controller receives key material from the OTP key response interface.

For the address-key request path, the relevant OTP response field must be propagated to the corresponding address-key output.

The expected relationship is:


OTP key response
       |
       +---- key ----------> rand_addr_key_o


in the affected path.

Instead, the buggy implementation created:


OTP key response
       |
       +---- rand_key -----> rand_addr_key_o


Therefore, the RTL produced a value from the wrong source field.

---

## 4. RTL-Level Mechanism

The fault is a **wrong signal/data-source association**.

The buggy assignment is:


rand_addr_key_o <= otp_key_rsp_i.rand_key;


while the corrected assignment is:


rand_addr_key_o <= otp_key_rsp_i.key;


Both fields have compatible types/widths, so SystemVerilog accepts the assignment.

There is therefore no syntax, type, or elaboration error.

The failure is purely semantic:


Expected:

rand_addr_key_o = otp_key_rsp_i.key


Buggy:

rand_addr_key_o = otp_key_rsp_i.rand_key

If the two OTP fields contain different values, the incorrect data is observable at `rand_addr_key_o`.

This makes the bug a good example of a functional RTL error that can pass compilation while violating the intended data-flow relationship.

---

## 5. Minimal Reproducer

The files in this directory reduce the original mechanism to a small SystemVerilog example.

### Buggy implementation

`buggy.sv`

The buggy implementation intentionally connects the output to the wrong OTP field:


module flash_key_buggy (
    input  logic        clk_i,
    input  logic        rst_ni,
    input  logic        req_i,
    input  logic [31:0] otp_key_i,
    input  logic [31:0] otp_rand_key_i,
    output logic [31:0] rand_addr_key_o
);

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
      rand_addr_key_o <= '0;
    else if (req_i)
      rand_addr_key_o <= otp_rand_key_i;
  end

endmodule


### Fixed implementation

`fixed.sv`

The corrected implementation uses the intended key field:


module flash_key_fixed (
    input  logic        clk_i,
    input  logic        rst_ni,
    input  logic        req_i,
    input  logic [31:0] otp_key_i,
    input  logic [31:0] otp_rand_key_i,
    output logic [31:0] rand_addr_key_o
);

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
      rand_addr_key_o <= '0;
    else if (req_i)
      rand_addr_key_o <= otp_key_i;
  end

endmodule


The reproducer deliberately gives the two input fields different values. This makes the incorrect source selection observable.

---

## 6. Testbench

Two testbenches are provided.

### `tb_buggy.sv`

This testbench drives different values onto the two OTP fields and checks that the address-key output matches the expected `otp_key_i` value.

The buggy implementation therefore fails the check.

Expected result:

```text
BUG REPRODUCED
```

### `tb_fixed.sv`

The same functional requirement is applied to the corrected implementation.

Expected result:

```text
PASS
```

Using separate buggy and fixed testbenches makes it explicit that the same requirement fails for the buggy implementation and succeeds after the fix.

---

## 7. How to Run

### Run the buggy version

```bash
iverilog -g2012 -o bug3_buggy buggy.sv tb_buggy.sv
vvp bug3_buggy
```

Expected:

```text
BUG REPRODUCED
```

### Run the fixed version

```bash
iverilog -g2012 -o bug3_fixed fixed.sv tb_fixed.sv
vvp bug3_fixed
```

Expected:

```text
PASS
```

The generated simulation executables (`bug3_buggy` and `bug3_fixed`) are build artifacts and do not need to be committed to the repository.

---

# 8. Why the Bug Survived

The bug is a valid SystemVerilog assignment and therefore does not produce a compiler or elaboration error.

A normal lint pass may also fail to identify the problem because both fields are legal sources with compatible widths and types.

Basic simulation can miss the error if:

1. `key` and `rand_key` happen to contain the same value in the tested scenario.
2. Tests only verify that an output key is produced.
3. Tests do not explicitly check the provenance of the output.
4. The address-key path is not exercised with distinguishable values.
5. The similarly named key fields make the error easy to introduce during copy/paste.

Therefore, structural correctness does not imply functional correctness.

A test that explicitly assigns different values to `key` and `rand_key` and checks the expected source would expose the problem.

---

# 9. General Bug Class

## Wrong Signal/Data-Source Association

The broader class represented by this bug is:

> **Wrong signal/data-source association:** an RTL output or state variable is connected to a syntactically valid but semantically incorrect source signal.

This can occur when:

- signals have similar names;
- multiple fields have the same width and type;
- code is copied between related datapaths;
- several outputs are assigned from structurally similar inputs;
- the specification requires a particular data-provenance relationship that is not enforced by the type system.

The important point is that the RTL remains syntactically and structurally valid while implementing the wrong functional relationship.

### Invariant

The general invariant is:

```text
Each output must receive data/control information from
the source signal designated for that output by the specification.
```

For this specific bug:

```text
rand_addr_key_o == designated OTP key source
```

after the corresponding request is accepted.

The bug violates that invariant by selecting `rand_key` instead of `key`.

---

# 10. Independent Instance of the Same Class

A related independent example is OpenTitan issue **#2123**, concerning the TL-UL SRAM adapter.

### OpenTitan TL-UL SRAM Adapter — Issue #2123

The design supported multiple outstanding read transactions.

The issue reported that two outstanding transactions had different masks:

```text
source = d   -> mask = 0010
source = d1  -> mask = 1110
```

However, the mask used for the second transaction was incorrectly associated with the first transaction.

The issue states that the second transaction used the `a_mask` from the first item. The OpenTitan developers determined that a separate mask FIFO was required so that the mask associated with each request could be retained with that request.

Reference:

https://github.com/lowRISC/opentitan/issues/2123

### Relationship to Bug 3

The two bugs are not the same RTL line or component, but they share the same underlying class:

```text
Bug #10218:
output key
    ↓
wrong OTP field


Bug #2123:
response transaction
    ↓
wrong transaction's mask
```

In both cases, information that is individually valid is associated with the wrong consumer/context.

Therefore, both demonstrate the broader class of **incorrect data/control-source association**.

---

# 11. Detection

A useful detection strategy is to assert the required data-provenance relationship at the output boundary.

For this specific instance:

```systemverilog
assert property (
  @(posedge clk_i)
  disable iff (!rst_ni)
  req_i |=> rand_addr_key_o == $past(otp_key_i)
);
```

The property states that after a request, the output must correspond to the required OTP key source.

If the RTL incorrectly selects `otp_rand_key_i`, the property fails whenever the two fields differ.

---

## 12. Class-Level Detection Strategy

The generalized detection principle is:

> For every control/data selection, the output or stored state must correspond to the source selected by the specification.

For a datapath with multiple possible sources, the checker can express the mapping explicitly:

```systemverilog
assert property (
  @(posedge clk_i)
  disable iff (!rst_ni)
  req_i |=> rand_addr_key_o == $past(expected_key_source)
);
```

where `expected_key_source` is derived from the architectural/specification-level selection.

The important feature is that the checker validates **data provenance**, rather than merely checking that the output is non-zero, stable, or syntactically valid.

This type of checking can catch a wider class of wrong-source and wrong-field-selection bugs.

---

# 13. Detection Cost and Limitations

The assertion is relatively inexpensive because it performs a comparison between the observed output and the expected source value.

### Advantages

- Low simulation overhead.
- Suitable for formal verification.
- Directly checks functional data provenance.
- Detects a wrong source even when the wrong source is otherwise legal.
- Can be generalized to multiple output/source mappings.

### Limitations

The expected source relationship must itself be specified correctly.

If the verification environment encodes the wrong specification, the assertion could validate incorrect behavior.

The check also requires assumptions about request timing and the number of cycles between the request and output.

For formal verification, constraining unrelated inputs may be necessary to keep the state space manageable.

---

# 14. Why Conventional Checks May Miss This Class

This class of bug is difficult for purely syntactic checks because:

```text
Correct source:
32-bit signal

Wrong source:
32-bit signal
```

Both are legal assignments.

Therefore:

```text
Compiler       -> PASS
Elaboration    -> PASS
Width checking -> PASS
Basic lint     -> likely PASS
                 ↓
              Functional bug
```

A functional assertion or directed test that distinguishes the possible sources is required.

This demonstrates why verification must check not only signal validity but also the intended relationship between signals.

---

# 15. Files

This directory contains:

```text
bug3/
├── buggy.sv
├── fixed.sv
├── tb_buggy.sv
├── tb_fixed.sv
└── README.md
```

### File descriptions

| File | Purpose |
|---|---|
| `buggy.sv` | Minimal RTL reproducing the wrong-field selection |
| `fixed.sv` | Corrected RTL |
| `tb_buggy.sv` | Testbench that demonstrates failure of the buggy implementation |
| `tb_fixed.sv` | Testbench that verifies the corrected implementation |
| `README.md` | Bug description, mechanism, reproduction, analysis, class, and detection |

Do not commit generated simulation binaries unless required.

---

# 16. Source and Provenance

### Primary bug source

**OpenTitan Issue #10218 — `[flash_ctrl] Bug Spotted In Module : flash_ctrl_lcmgr.sv`**

https://github.com/lowRISC/opentitan/issues/10218

The issue explicitly identifies the incorrect `rand_addr_key_o` assignment and provides the proposed correction.

### Independent class example

**OpenTitan Issue #2123 — `[tlul_adapter_sram] wrong mask on outstanding transaction`**

https://github.com/lowRISC/opentitan/issues/2123

The issue documents incorrect association of a response mask with an outstanding transaction and the subsequent fix involving separate mask storage.

### Local reproduction

The minimal reproducer in this directory is an intentionally reduced SystemVerilog model of the mechanism described by Issue #10218.

It is not claimed to be the complete original OpenTitan module. Its purpose is to demonstrate the same RTL failure mechanism in a small, independently compilable design.

---

# 17. Bug Classification Summary

| Requirement | Result |
|---|---|
| Real hardware bug | OpenTitan Flash Controller |
| Public source | Issue #10218 |
| RTL-level mechanism | Wrong OTP field selected |
| Minimal SystemVerilog reproducer | Yes |
| Buggy implementation | `buggy.sv` |
| Fixed implementation | `fixed.sv` |
| Bug-failing testbench | `tb_buggy.sv` |
| Fix-passing testbench | `tb_fixed.sv` |
| Why bug survived | Valid typing + insufficient provenance checking |
| General class | Wrong signal/data-source association |
| Independent instance | OpenTitan TL-UL SRAM adapter #2123 |
| Detection | Data-provenance SVA |
| Detection cost discussed | Yes |

---

# 18. Reproduction Result

The expected behavior is:

```text
$ iverilog -g2012 -o bug3_buggy buggy.sv tb_buggy.sv
$ vvp bug3_buggy

BUG REPRODUCED
```

and:

```text
$ iverilog -g2012 -o bug3_fixed fixed.sv tb_fixed.sv
$ vvp bug3_fixed

PASS
```

Thus the reproducer demonstrates that the buggy implementation can compile successfully while violating the required functional data-source relationship, whereas the corrected implementation satisfies the same check.
