# Bug 1: OpenTitan TL-UL FIFO data/integrity mismatch

## Primary source
- Issue #31187: https://github.com/lowRISC/opentitan/issues/31187
- RTL: `hw/ip/tlul/rtl/tlul_fifo_sync.sv`
- Accessed: 2026-10-09
- Status: issue is open in the source snapshot checked; do not claim a merged fix.

## Mechanism
The response FIFO forces `d_data` to zero for opcodes other than `AccessAckData`, while the parallel integrity FIFO forwards `d_user`, including `data_intg`, unchanged. The input pair can therefore be transformed from `(original data, ECC(original data))` to `(0, ECC(original data))`.

The issue provides this counterexample:
- Input: data `0x42032080`, integrity `0x45`
- Faulty output: data `0x00000000`, integrity `0x45`
- Reported ECC: `ECC_inv_39_32(0x42032080) = 0x45`; `ECC_inv_39_32(0) = 0x2A`

The proposed correction is to forward `d_data` unchanged. If the fabric intentionally blanks response data, it must also provide matching integrity bits.

## Run
Requires Icarus Verilog (`iverilog`, `vvp`):
```sh
chmod +x run.sh
./run.sh
```
The buggy model is expected to fail its integrity check; the script treats that failure as successful reproduction. The fixed model should print `PASS`.

## Reproducer limitation
The models are minimal behavioral reductions, not a build of OpenTitan production RTL. The testbench uses the two ECC values reported by the issue as a counterexample-specific lookup; it does **not** implement the general inverted Hsiao SECDED encoder. This validates the documented example, not every possible data value.

## Class
**Integrity semantics mismatch:** data transformation and integrity metadata are not kept consistent.

Invariant: for every response where the data/integrity pair is required to be valid, the integrity bits must correspond to the data actually delivered. If the protocol declares data irrelevant for a response opcode, either preserve the pair or transform both data and integrity consistently.

## Why it survived
The issue states that in-tree producers happen to emit only `0` or all ones for non-`AccessAckData` responses. Under the inverted Hsiao code, those values have the same integrity encoding, `7'h2A`, masking the unconditional mismatch. The convention is not documented or enforced as a design constraint.

## Independent instance of the broader class
Ibex issue #2342: https://github.com/lowRISC/ibex/issues/2342 (accessed 2026-10-09). The reported LSU issue checks returned data/ECC during store acknowledgements even though store-response data is don't-care, allowing arbitrary payload bits to produce a spurious integrity alert. This is not the identical mux bug; it is an independent example of integrity handling being misaligned with transaction payload semantics. State that broader class explicitly in the report rather than claiming the RTL mechanisms are identical.

## Class-level detection
Use the actual OpenTitan ECC checker on the output pair and assert that each valid response beat passes:
```systemverilog
assert property (@(posedge clk_i) disable iff (!rst_ni)
    d_valid_o |-> data_integrity_ok_o);
```
`data_integrity_ok_o` must be driven by the real `prim_secded_inv_39_32_dec` (or an equivalent verified checker) connected to the output `d_data` and `data_intg`. This is a property template, not a standalone compilable property until the checker signals are wired. It may need opcode/validity qualification if the protocol explicitly permits data to be don't-care; in this case the reported end-to-end integrity scheme checks the pair on valid beats.
