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




Final implementation
The current and final AnvilHDL implementation is:
router.anvil
Earlier Anvil implementations are preserved in the archive/ directory as development history.
Part A — SystemVerilog Router
3. Architecture
The reference implementation is a 2-input, 2-output concurrent packet router.
Each input provides:

TDATA   : 32-bit payload
TVALID  : indicates that the input is presenting valid data
TREADY  : indicates that the receiver can accept the transfer
TLAST   : indicates the final beat of a packet
TDEST   : 1-bit destination
Each output uses the same Ready/Valid protocol.
The destination determines the output:

TDEST = 0  → Output 0
TDEST = 1  → Output 1
When both inputs request the same output simultaneously, the output arbiter selects one input using round-robin arbitration.
4. Packet Locking
Packets can contain multiple beats.
When an input wins arbitration and transfers a beat with:

TLAST = 0
the corresponding output becomes locked to that input.
The output remains owned by the same input until the final beat of the packet is transferred:

TLAST = 1
This prevents packet beats from different inputs from being interleaved.
After the final beat is transferred, the lock is released and the output can arbitrate for another packet.

5. Round-Robin Arbitration
Each output maintains its own round-robin arbitration state.
When both inputs request the same output, the current round-robin state determines which input is selected.

The round-robin state is updated when a contended packet completes.

This provides fairness between competing input streams while maintaining packet-level ordering.

6. Backpressure
The router uses Ready/Valid handshaking to support backpressure.
A transfer occurs only when:

TVALID && TREADY
If an output is not ready, the corresponding input is prevented from completing the transfer.
This allows the router to operate correctly when downstream components temporarily apply backpressure.

Part B — SystemVerilog Assertions
7. Verification Strategy
SystemVerilog Assertions are used to verify important protocol and router properties.
The verification environment checks:

Reset behavior
Ready/Valid handshaking
Data stability under backpressure
Packet locking
Arbitration correctness
Output ownership
Packet-level behavior
End-to-end transfer behavior
Round-robin fairness
The main verification files are:
routera_sva.sv
tb_router_sva.sv
The SVA testbench exercises normal traffic, contention, backpressure, multi-beat packets, reset behavior, and fairness scenarios.
Part C — AnvilHDL Implementation
8. Anvil Architecture
The AnvilHDL implementation is organized into separate routing and arbitration processes.
Input routing
Each input has a dedicated routing process:
input0_router
input1_router
Each input maintains a one-entry buffer and routes data according to its destination.
Output arbitration
Each output has a dedicated arbiter:
output0_arbiter
output1_arbiter
Each arbiter maintains state for:
packet buffers
valid state
round-robin state
packet lock
packet owner
The overall architecture is:
Input 0 ──> Input Router ──> Destination Channel ──┐
                                                   │
                                                   ├──> Output 0 Arbiter ──> Output 0
                                                   │
Input 1 ──> Input Router ──> Destination Channel ──┘

Input 0 ──> Input Router ──> Destination Channel ──┐
                                                   │
                                                   ├──> Output 1 Arbiter ──> Output 1
                                                   │
Input 1 ──> Input Router ──> Destination Channel ──┘
This separates routing, buffering, arbitration, and packet ownership responsibilities.
9. Anvil Packet Representation
Anvil channels carry each packet beat as a single 34-bit value.
The representation is:

[33]     TLAST
[32]     TDEST
[31:0]   TDATA
Therefore:
beat = {TLAST, TDEST, TDATA}
For example:
34-bit beat
┌───────┬───────┬──────────────────────────────┐
│ TLAST │ TDEST │            TDATA             │
│  1bit │  1bit │            32bit             │
└───────┴───────┴──────────────────────────────┘
   33       32             31 ........ 0
This representation preserves the information required by the SystemVerilog reference implementation.
10. Input Buffering
Each Anvil input router uses a one-entry buffer.
The buffer stores:

packet
destination
valid
The input router then routes the buffered beat to the appropriate destination channel.
For example:

TDEST = 0
    ↓
Output 0 routing channel

TDEST = 1
    ↓
Output 1 routing channel
Buffering separates input reception from output arbitration and allows the output arbiters to observe pending requests.
11. Output Arbitration
Each output arbiter receives traffic from both input routing paths.
For an unlocked output:

No request       → no transfer
Only input 0     → select input 0
Only input 1     → select input 1
Both inputs      → use round-robin state
When a multi-beat packet begins, the arbiter records the selected input as the packet owner.
While locked:

Only the packet owner may transfer beats.
The lock is released after the owner's final beat:
TLAST = 1
This prevents packet interleaving.
12. Round-Robin State
Each output maintains an independent round-robin state.
The round-robin state is used only when both inputs are requesting the same output.

After a contended packet completes, the arbitration state is updated so that the other requester gets priority during the next contention.

For multi-beat packets, the round-robin state is not changed merely because an intermediate beat is transferred.

This preserves packet ownership while maintaining fairness across completed packets.

13. Building the Anvil Design
The project uses the AnvilHDL compiler.
Step 1 — Check the Anvil source
From the Anvil compiler directory:
cd ~/Desktop/anvil

dune exec anvil -- -just-check ~/Desktop/anvil_router/router.anvil
A successful command returns to the shell without compilation errors.
Step 2 — Generate SystemVerilog
dune exec anvil -- \
-o ~/Desktop/anvil_router/router_generated \
~/Desktop/anvil_router/router.anvil
The generated RTL is:
router_generated.anvil.sv
14. Verilator Lint
The generated SystemVerilog can be checked using:
verilator --lint-only \
~/Desktop/anvil_router/router_generated.anvil.sv
A successful run confirms that the generated RTL can be elaborated and linted by Verilator.
15. Part C Equivalence Testing
The Part C testbench compares the SystemVerilog reference router against the SystemVerilog RTL generated from the Anvil implementation.
Compile the simulation using:

cd ~/Desktop/anvil_router

iverilog -g2012 \
-o partc_sim \
router.sv \
router_generated.anvil.sv \
tb_partc.sv
Run the simulation:
vvp partc_sim
The equivalence test environment exercises:
Basic routing
Concurrent traffic
Contention
Backpressure
Multi-beat packets
Packet locking
Round-robin arbitration
Packet boundaries
Output transfers
Payload comparison
The detailed execution output is stored in:
equivalence_transcript.txt
16. Reproducible One-Command Build and Test
The complete Anvil build and Part C verification flow can be executed using:
cd ~/Desktop/anvil && \
dune exec anvil -- -just-check ~/Desktop/anvil_router/router.anvil && \
dune exec anvil -- \
-o ~/Desktop/anvil_router/router_generated \
~/Desktop/anvil_router/router.anvil && \
verilator --lint-only \
~/Desktop/anvil_router/router_generated.anvil.sv && \
cd ~/Desktop/anvil_router && \
iverilog -g2012 \
-o partc_sim \
router.sv \
router_generated.anvil.sv \
tb_partc.sv && \
vvp partc_sim
17. Verification Results
Part A — SystemVerilog
The reference SystemVerilog router was tested using the provided testbench.
The test scenarios cover:

Basic destination routing
Concurrent traffic
Contention
Backpressure
Multi-beat packets
Packet locking
Round-robin behavior
The SystemVerilog implementation serves as the behavioral reference for Part C.
Part B — SVA
The SVA verification environment checks the router's temporal and protocol properties.
The core protocol, arbitration, packet-locking, and fairness properties were exercised using dedicated test scenarios.

The verification artifacts are included in:

routera_sva.sv
tb_router_sva.sv
The detailed verification output is documented in the project report.
Part C — Anvil
The final Anvil implementation:
router.anvil
successfully:
Passes Anvil syntax/semantic checking.
Generates SystemVerilog RTL.
Passes Verilator linting.
Runs through the cross-implementation test environment.
The detailed build and equivalence outputs are preserved in:
final_build_transcript.txt
equivalence_transcript.txt
The equivalence results are reported based on the actual observed behavior rather than being presented as strict equivalence when differences remain.
18. Known Semantic Differences
AnvilHDL and conventional SystemVerilog Ready/Valid interfaces use different execution and communication models.
The main differences considered during verification are:

SystemVerilog expresses VALID and READY directly as signals.
Anvil uses synchronous channel communication with send and recv operations.
Backpressure acknowledgement can therefore be observed at different points in execution.
Process and channel scheduling can affect when arbitration decisions become observable.
Cycle-level observations can therefore differ even when the transferred data and packet boundaries are consistent.
These differences are documented as part of the cross-implementation analysis.
19. Development History
Earlier Anvil implementations are preserved under:
archive/
The archived versions document the development and debugging process, including iterations related to:
Initial routing
Buffering
Round-robin arbitration
Packet locking
Arbitration timing
Debugging and refinement
The implementation intended for evaluation is:
router.anvil
20. Verification and Reproducibility Files
The repository includes the following verification artifacts:
Reference design
router.sv
SystemVerilog testbench
tb_router.sv
SVA checker
routera_sva.sv
SVA testbench
tb_router_sva.sv
Final Anvil implementation
router.anvil
Generated SystemVerilog
router_generated.anvil.sv
Part C testbench
tb_partc.sv
Equivalence testbench
tb_equivalence.sv
Build transcript
final_build_transcript.txt
Equivalence transcript
equivalence_transcript.txt
21. Tools and Environment
The project was developed and tested on:
Operating System : macOS
HDL              : SystemVerilog
AnvilHDL         : Anvil
Simulator        : Icarus Verilog
RTL Lint         : Verilator
Build System     : Dune / OCaml
The Anvil compiler version/commit used for the project is recorded in the project documentation and build transcript.
22. AI Assistance and Provenance
AI tools were used during development for:
Understanding AnvilHDL syntax and semantics
Debugging compiler errors
Reasoning about Ready/Valid behavior
Reviewing arbitration logic
Developing and refining verification infrastructure
Understanding differences between Anvil channel semantics and SystemVerilog handshaking
Improving documentation
All final code was compiled and tested in the local development environment.
The repository preserves intermediate Anvil implementations in the archive/ directory to maintain development history.

23. Final Deliverables
SystemVerilog
router.sv
tb_router.sv
SVA Verification
routera_sva.sv
tb_router_sva.sv
AnvilHDL
router.anvil
Generated RTL
router_generated.anvil.sv
Part C Verification
tb_partc.sv
tb_equivalence.sv
equivalence_transcript.txt
final_build_transcript.txt
Documentation
README.md
Anvil_File-2.pdf
24. Conclusion
This project demonstrates the design and verification of a concurrent 2×2 packet router using SystemVerilog and AnvilHDL.
The SystemVerilog implementation provides the reference router architecture with Ready/Valid handshaking, packet locking, destination-based routing, and per-output round-robin arbitration.

The design was then reimplemented in AnvilHDL using input buffering, destination-specific channels, output arbitration, packet locking, and round-robin state.

The final Anvil source successfully passes Anvil syntax/semantic checking and generates SystemVerilog RTL that passes Verilator linting. A dedicated cross-implementation test environment is provided to compare the SystemVerilog reference implementation with the Anvil-generated RTL.

The final Anvil implementation for evaluation is:

router.anvil
Earlier implementations are retained under:
archive/
for development-history and reproducibility purposes.
