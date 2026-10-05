# Bug 5 — DMA Partial-Transfer Counter/Address Update

## 1. Bug Identification

**Design:** OpenTitan DMA RTL  
**Source:** OpenTitan GitHub Issue #31191  
**Issue:** `[dma/rtl] CHUNK_DATA_SIZE needs to be a multiple of TRANSFER_WIDTH`  
**Issue URL:** https://github.com/lowRISC/opentitan/issues/31191  
**Issue opened:** September 1, 2026  
**Bug class:** Incorrect accounting for partial transfers / counter and address advancement based on nominal transfer width

---

## 2. What the Design Was Supposed to Do

The OpenTitan DMA supports three relevant sizes:

- `TOTAL_DATA_SIZE` — total number of bytes in the transfer.
- `CHUNK_DATA_SIZE` — number of bytes in each chunk.
- `TRANSFER_WIDTH` — number of bytes transferred in one transaction.

When a chunk ends with fewer bytes remaining than `TRANSFER_WIDTH`, the DMA must transfer only the remaining bytes and advance its counters and addresses by the number of bytes actually transferred.

For example:

```text
TOTAL_DATA_SIZE  = 12
CHUNK_DATA_SIZE  = 6
TRANSFER_WIDTH   = 4
```

The correct byte ranges are:

```text
Transaction 1: bytes 0–3
Transaction 2: bytes 4–5
Transaction 3: bytes 6–9
Transaction 4: bytes 10–11
```

OpenTitan issue #31191 documents that the RTL calculated the remaining bytes correctly but advanced the transfer and address counters using the full `TRANSFER_WIDTH`.

---

## 3. RTL-Level Mechanism

The problematic logic advanced the transfer and chunk counters by the configured transfer width:

```systemverilog
transfer_byte_d =
    transfer_byte_q + TRANSFER_BYTES_WIDTH'(transfer_width_q);

chunk_byte_d =
    chunk_byte_q + TRANSFER_BYTES_WIDTH'(transfer_width_q);
```

The source and destination addresses were similarly advanced using the transfer width.

The problem occurs when the final transaction of a chunk is smaller than `TRANSFER_WIDTH`.

For:

```text
CHUNK_DATA_SIZE = 6
TRANSFER_WIDTH  = 4
```

the first transaction transfers:

```text
bytes 0–3
```

leaving only:

```text
bytes 4–5
```

for the second transaction.

The second transaction therefore transfers only 2 bytes, but the address/counter advances by 4.

Thus:

```text
4 + 4 = 8
```

instead of:

```text
4 + 2 = 6
```

The next transaction therefore begins at byte 8 and bytes 6 and 7 are skipped.

This is the exact failure described in OpenTitan Issue #31191.

---

## 4. Minimal Reproducer

This directory contains a cut-down SystemVerilog model of the bug:

```text
bug5/
buggy.sv
fixed.sv
tb_buggy.sv
tb_fixed.sv
README.md
```

The reproducer uses:

```text
TOTAL_DATA_SIZE = 12
CHUNK_DATA_SIZE = 6
TRANSFER_WIDTH  = 4
```

### Buggy implementation

The buggy model advances the address by:

```systemverilog
transfer_addr <= transfer_addr + TRANSFER_WIDTH;
```

even when the actual transaction contains fewer bytes.

### Fixed implementation

The fixed model advances by:

```systemverilog
transfer_addr <= transfer_addr + actual_size;
```

where `actual_size` is the number of bytes actually transferred.

---

## 5. Reproduction

### Compile and run buggy implementation

```bash
iverilog -g2012 -o bug5_buggy buggy.sv tb_buggy.sv
vvp bug5_buggy
```

Observed result:

```text
BUGGY: address=0 size=4
BUGGY: address=4 size=2
BUGGY: address=8 size=4
BUGGY: address=12 size=2

Buggy transfer coverage:
byte 0: TRANSFERRED
byte 1: TRANSFERRED
byte 2: TRANSFERRED
byte 3: TRANSFERRED
byte 4: TRANSFERRED
byte 5: TRANSFERRED
byte 6: MISSING
byte 7: MISSING
byte 8: TRANSFERRED
byte 9: TRANSFERRED
byte 10: TRANSFERRED
byte 11: TRANSFERRED

BUG REPRODUCED
Bytes 6 and 7 were skipped.
```

This reproduces the documented failure.

---

## 6. Fixed Implementation

Compile and run:

```bash
iverilog -g2012 -o bug5_fixed fixed.sv tb_fixed.sv
vvp bug5_fixed
```

Observed result:

```text
FIXED: address=0 size=4
FIXED: address=4 size=2
FIXED: address=6 size=4
FIXED: address=10 size=2
```

The coverage check reports:

```text
byte 0: TRANSFERRED
byte 1: TRANSFERRED
byte 2: TRANSFERRED
byte 3: TRANSFERRED
byte 4: TRANSFERRED
byte 5: TRANSFERRED
byte 6: TRANSFERRED
byte 7: TRANSFERRED
byte 8: TRANSFERRED
byte 9: TRANSFERRED
byte 10: TRANSFERRED
byte 11: TRANSFERRED

PASS: all 12 bytes were transferred.
```

Therefore, the same scenario that loses bytes in the buggy implementation transfers every byte in the fixed implementation.

---

## 7. Why the Bug Survived Verification

OpenTitan Issue #31191 explains that the bug was not detected by design verification because the DV constraints required `CHUNK_DATA_SIZE` to be a multiple of the bytes-per-transaction.

Consequently, the verification environment did not exercise the important boundary case where:

```text
CHUNK_DATA_SIZE % TRANSFER_WIDTH != 0
```

For example:

```text
6 % 4 = 2
```

creates a partial final transaction and exposes the bug.

This demonstrates a verification gap: constrained stimulus can unintentionally exclude legal or meaningful parameter combinations.

---

## 8. General Bug Class

### Class: Incorrect Accounting for Partial Transfers

This bug belongs to the broader class of errors where control logic updates counters, pointers, or addresses using a **nominal transfer size** rather than the **actual amount transferred**.

The violated invariant is:

```text
next_address =
    current_address + actual_bytes_transferred
```

not:

```text
next_address =
    current_address + maximum_transfer_width
```

The same principle applies to:

- byte counters
- burst pointers
- packet offsets
- FIFO read/write pointers
- DMA source/destination addresses
- descriptor progress counters
- remaining-length counters

A general invariant that should hold is:

```text
progress_after_transaction =
    progress_before_transaction + actual_transaction_size
```

---

## 9. Detection

A useful assertion should check that address advancement matches the actual number of bytes transferred.

Conceptually:

```systemverilog
assert property (
    @(posedge clk)
    disable iff (!rst_n)
    transfer_valid |=> 
        next_addr == $past(current_addr + actual_transfer_size)
);
```

A corresponding counter property can check:

```systemverilog
assert property (
    @(posedge clk)
    disable iff (!rst_n)
    transfer_valid |>
        next_count == $past(current_count + actual_transfer_size)
);
```

The important point is that the checker must use the **actual transfer size**, rather than merely checking that the address increments by `TRANSFER_WIDTH`.

### Detection cost

Such properties are inexpensive in simulation and formal verification when the actual transfer size is already available as a signal.

The main assumptions are:

- the transaction-valid condition is correctly defined;
- the actual number of transferred bytes is observable;
- reset and transaction-boundary behavior are modeled correctly.

A stronger verification strategy should also deliberately test cases where:

```text
CHUNK_DATA_SIZE % TRANSFER_WIDTH != 0
```

rather than constraining them away.

---

## 10. Reproducer Status

**Personally reproduced:** Yes.

**Simulation environment:**

```text
macOS
Icarus Verilog
SystemVerilog (-g2012)
```

**Buggy result:** Bytes 6 and 7 missing.

**Fixed result:** All 12 bytes transferred.

Therefore the reproducer demonstrates both the failure and the corrected behavior.

---

## 11. Reference

OpenTitan GitHub Issue #31191:

`[dma/rtl] CHUNK_DATA_SIZE needs to be a multiple of TRANSFER_WIDTH`

https://github.com/lowRISC/opentitan/issues/31191
