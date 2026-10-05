# Bug 4 — OpenTitan Key Manager Reserved Operation Encoding

## 1. Bug Summary

This directory reproduces a real RTL bug reported in the OpenTitan Key Manager.

The bug concerns **reserved key-manager operation encodings**.

The specification requires reserved operation values to behave like the `Disable` operation. However, the buggy RTL only recognizes the exact `OpDisable` encoding.

As a result, reserved encodings such as `3'h5`, `3'h6`, and `3'h7` are not treated as Disable operations.

The bug was reported in OpenTitan issue **#8112**.

---

## 2. Original Bug / Instance

### Design

- **Project:** lowRISC/OpenTitan
- **Component:** Key Manager
- **Issue:** #8112
- **Bug type:** Incorrect handling of reserved encodings

Reference:

https://github.com/lowRISC/opentitan/issues/8112

The affected logic determines whether the current operation is a Disable operation.

The buggy implementation effectively performs an exact comparison:

```systemverilog
assign dis_op = (op_i == OpDisable);
```

This recognizes the legal `OpDisable` encoding but does not recognize the reserved encodings that are required to have Disable behavior.

---

## 3. What the Component Was Supposed to Do

The key-manager operation field has several defined operation encodings.

Reserved encodings are not supposed to result in an unintended operation. According to the behavior discussed in OpenTitan issue #8112, reserved values should be handled as Disable.

Conceptually:

```text
Legal Disable encoding
        |
        v
     Disable
```

and:

```text
Reserved encoding
        |
        v
     Disable
```

The buggy implementation instead behaves as:

```text
Reserved encoding
        |
        v
    Not Disable
```

This can cause the key manager to enter behavior that is inconsistent with the required specification.

---

## 4. RTL-Level Mechanism

The fault is an **incomplete/incorrect decode of an operation field**.

The buggy logic recognizes only the exact Disable encoding:

```systemverilog
assign dis_op = (op_i == OpDisable);
```

Therefore:

```text
op_i = OpDisable  -> dis_op = 1
op_i = reserved   -> dis_op = 0
```

The required behavior is:

```text
op_i = OpDisable  -> Disable
op_i = reserved   -> Disable
```

Thus, the RTL fails to implement the required default behavior for reserved encodings.

This is a functional decode error rather than a syntax or type error.

---

## 5. Minimal Reproducer

The files in this directory provide a reduced SystemVerilog model of the faulty decode.

### Buggy implementation

`buggy.sv`

The buggy implementation recognizes only the explicit Disable encoding.

```systemverilog
assign dis_op = (op_i == OP_DISABLE);
```

A reserved value such as `3'h5` therefore does not produce Disable behavior.

### Fixed implementation

`fixed.sv`

The fixed implementation treats the reserved encodings according to the required Disable behavior.

The exact implementation is contained in `fixed.sv`.

---

## 6. Testbench

Two testbenches are provided.

### `tb_buggy.sv`

This testbench drives a reserved operation encoding, for example:

```systemverilog
op_i = 3'h5;
```

It checks that the reserved encoding receives Disable behavior.

The buggy implementation fails this requirement.

Expected result:

```text
BUG REPRODUCED
```

### `tb_fixed.sv`

The same requirement is tested against the corrected implementation.

The fixed implementation correctly treats the reserved encoding as Disable.

Expected result:

```text
PASS
```

---

## 7. How to Run

### Run the buggy version

```bash
iverilog -g2012 -o bug4_buggy buggy.sv tb_buggy.sv
vvp bug4_buggy
```

Expected result:

```text
BUG REPRODUCED
```

### Run the fixed version

```bash
iverilog -g2012 -o bug4_fixed fixed.sv tb_fixed.sv
vvp bug4_fixed
```

Expected result:

```text
PASS
```

The generated executables `bug4_buggy` and `bug4_fixed` are build artifacts and do not need to be committed.

---

## 8. Why the Bug Survived

The buggy comparison is legal SystemVerilog and produces no compilation or elaboration error.

A conventional compiler therefore cannot identify the functional problem.

The bug can also survive ordinary simulation if tests cover only the documented legal operation encodings.

In particular:

- `OpDisable` itself behaves correctly.
- Other legal operations may also behave correctly.
- Reserved encodings may not be included in ordinary directed tests.
- The RTL is syntactically valid.
- The incorrect behavior is exposed only when an unspecified/reserved encoding is deliberately exercised.

This demonstrates why verification must test not only legal inputs but also the required behavior of reserved or otherwise exceptional encodings.

---

# 9. General Bug Class

## Incomplete Decode / Specification-Conformance Error

The broader class represented by this bug is:

> **Incomplete or incorrect decode of control encodings**, where an RTL decoder handles the explicitly defined values but fails to implement the required behavior for reserved, default, or exceptional encodings.

This class can occur when:

- only legal encodings are explicitly enumerated;
- reserved values are assumed to be impossible;
- a decoder implements exact equality rather than the required equivalence class;
- the specification defines a default behavior that is not reflected in the RTL;
- verification does not exercise reserved encodings.

### General invariant

For every possible encoding of a control field:

```text
The RTL behavior must match the specification-defined
behavior for that encoding.
```

For this particular design:

```text
reserved operation encoding
              |
              v
          Disable behavior
```

The buggy RTL violates this invariant because reserved values are not decoded as Disable.

---

# 10. Independent Instance of the Same Class

An independent example of the same general class is the **Ibex issue concerning reserved shift encodings**.

In the RISC-V instruction encoding space, certain shift instructions contain reserved combinations of instruction bits.

The decoder was reported to ignore bits that distinguish legal and reserved encodings. As a result, a reserved encoding could be interpreted as a valid shift instruction rather than producing the required illegal-instruction behavior.

This represents the same broader class:

```text
Reserved encoding
       |
       v
Incorrect decode as a valid operation
```

instead of:

```text
Reserved encoding
       |
       v
Specification-required default/illegal behavior
```

The important commonality with OpenTitan #8112 is that the RTL decoder does not correctly map all possible encodings to their specification-defined behaviors.

This example can therefore be used as the independent second instance for the **incomplete decode/specification-conformance** class.

---

# 11. Detection

A useful verification strategy is to explicitly define the set of reserved encodings and assert their required behavior.

For this design, the basic property can be expressed as:

```systemverilog
assert property (
  @(posedge clk)
  disable iff (!rst_n)
  (op_i inside {3'h5, 3'h6, 3'h7})
  |-> dis_op
);
```

This property states that every reserved operation encoding must result in Disable behavior.

The buggy implementation fails when `op_i` is `3'h5`, `3'h6`, or `3'h7`.

The fixed implementation satisfies the property.

---

# 12. Class-Level Detection Strategy

The generalized detection strategy is:

> For every control-field encoding, verify that the RTL behavior belongs to the behavior class specified by the architecture or protocol specification.

Instead of checking only known legal operations, verification should partition the encoding space into:

```text
Legal operation A
Legal operation B
Legal operation C
...
Reserved encodings
```

and explicitly specify the expected behavior for each partition.

For reserved/default encodings, an assertion can enforce the required default behavior:

```systemverilog
assert property (
  @(posedge clk)
  disable iff (!rst_n)
  !op_valid |-> default_behavior
);
```

This generalized form can detect other incomplete-decoder bugs rather than only the particular OpenTitan #8112 case.

---

# 13. Detection Cost and Limitations

### Advantages

- Low simulation overhead.
- Simple Boolean comparison.
- Suitable for formal verification.
- Explicitly covers reserved encodings.
- Can detect incomplete decoder cases that ordinary legal-input tests miss.

### Limitations

The verification environment must correctly identify which encodings are reserved and what behavior they require.

If the specification changes, the assertion must also be updated.

For formal verification, explicitly exploring all encodings is generally inexpensive for a small control field, but the cost can increase for larger instruction/control fields.

There is also a potential false-positive risk if a value classified as reserved by the checker later receives a legitimate architectural meaning.

---

# 14. Why Conventional Testing May Miss This Class

A conventional test suite may focus on valid operations:

```text
OpDisable
OpAdvance
OpGenerate
OpUpdate
...
```

and confirm that each works.

However, that does not test the remaining encoding space.

For a 3-bit operation field:

```text
000
001
010
011
100
101
110
111
```

If only the defined operations are tested, the reserved values may never reach the decoder.

Therefore:

```text
Legal-input testing
        |
        v
       PASS
        |
        v
Reserved-input testing
        |
        v
      BUG
```

This is why reserved/default encoding assertions are useful.

---

# 15. Files

This directory contains:

```text
bug4/
├── buggy.sv
├── fixed.sv
├── tb_buggy.sv
├── tb_fixed.sv
└── README.md
```

### File descriptions

| File | Purpose |
|---|---|
| `buggy.sv` | Minimal RTL reproducing the incorrect reserved-operation decode |
| `fixed.sv` | Corrected RTL |
| `tb_buggy.sv` | Testbench demonstrating the failure |
| `tb_fixed.sv` | Testbench demonstrating the corrected behavior |
| `README.md` | Complete bug analysis and reproduction instructions |

Generated simulation binaries should not be committed.

---

# 16. Source and Provenance

### Primary bug source

**OpenTitan Issue #8112**

https://github.com/lowRISC/opentitan/issues/8112

The issue documents the incorrect handling of reserved Key Manager operation encodings.

### Independent class example

An independent processor decode example involving reserved instruction encodings is used to demonstrate that incomplete handling of reserved values is a broader hardware-design bug class rather than an OpenTitan-specific issue.

---

# 17. Bug Classification Summary

| Requirement | Result |
|---|---|
| Real documented hardware bug | OpenTitan Key Manager |
| Public source | Issue #8112 |
| RTL-level mechanism | Incomplete operation decode |
| Minimal SystemVerilog reproducer | Yes |
| Buggy implementation | `buggy.sv` |
| Fixed implementation | `fixed.sv` |
| Bug-failing testbench | `tb_buggy.sv` |
| Fix-passing testbench | `tb_fixed.sv` |
| Why bug survived | Reserved encodings insufficiently tested |
| General class | Incomplete decode / specification-conformance error |
| Independent instance | Reserved instruction decode bug |
| Detection | Reserved/default encoding SVA |
| Detection cost discussed | Yes |

---

# 18. Reproduction Result

The expected result for the buggy implementation is:

```text
$ iverilog -g2012 -o bug4_buggy buggy.sv tb_buggy.sv
$ vvp bug4_buggy

BUG REPRODUCED
```

The expected result for the corrected implementation is:

```text
$ iverilog -g2012 -o bug4_fixed fixed.sv tb_fixed.sv
$ vvp bug4_fixed

PASS
```

Therefore, the reproducer demonstrates that the buggy decoder can compile successfully while failing to implement the required behavior for reserved operation encodings, whereas the corrected implementation satisfies the requirement.
