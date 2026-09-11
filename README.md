# Concurrent Packet Router — AnvilHDL

A 2-input, 2-output concurrent packet router implemented in SystemVerilog and AnvilHDL, with SystemVerilog Assertions (SVA) and cross-implementation equivalence testing.

---

## 1. Project Overview

This project implements and verifies a concurrent packet router with:

- 2 input ports
- 2 output ports
- Ready/Valid flow control
- 32-bit data payload
- 1-bit destination (`TDEST`)
- Multi-beat packets
- Packet termination using `TLAST`
- Packet locking during multi-beat transfers
- Per-output round-robin arbitration
- Backpressure handling
- SystemVerilog Assertions (SVA)
- AnvilHDL implementation
- Generated SystemVerilog RTL
- Cross-implementation testing

The SystemVerilog implementation serves as the reference design, while the AnvilHDL implementation reproduces the router architecture using Anvil's synchronous channel and process model.

---

## 2. Repository Structure

```text
.
├── Anvil_File-2.pdf
├── README.md
│
├── router.sv
├── router.anvil
├── router_generated.anvil.sv
│
├── tb_router.sv
├── routera_sva.sv
├── tb_router_sva.sv
│
├── tb_partc.sv
├── tb_equivalence.sv
│
├── equivalence_transcript.txt
├── final_build_transcript.txt
│
└── archive/
    ├── router_BASELINE_VALID.anvil
    ├── router_anvil_before_rr_fix.anvil
    ├── router_anvil_failed_rr_fix.anvil
    ├── router_old.anvil
    └── router_working_20260909.anvil



