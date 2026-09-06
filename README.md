## Part 1B – SVA Verification Results

The router was verified using the SVA checker and SystemVerilog testbench.

### Testbench Results

Tests executed: 14  
PASS count: 36  
FAIL count: 0  

TESTBENCH RESULT: PASS

### Router Checker Results

CORE CHECKS: PASS

### Fairness Results

Output 1 / Input 0 contention wins: 4  
Output 1 / Input 1 contention wins: 4  
Output 1 fairness: PASS

Output 0 fairness: NOT DEMONSTRATED

### Part C — Equivalence Testing Results

The SystemVerilog and Anvil implementations were tested using a common equivalence testbench with matched input stimuli. The test suite checks basic routing, concurrent traffic, round-robin arbitration, backpressure, and multi-beat packet locking.

**Test Results:**

| Test                             | Result               |
| -------------------------------- | -------------------- |
| Basic Routing                    | PASS                 |
| Concurrent Traffic               | PASS                 |
| Output 0 Round-Robin Arbitration | PASS                 |
| Output 1 Round-Robin Arbitration | PASS                 |
| Backpressure                     | FAIL — 1 discrepancy |
| Multi-beat Packet Locking        | PASS                 |

The final simulation checked **243 cycles** and reported **1 error**.

The only discrepancy occurred during the backpressure test. Both implementations produced the expected output data and maintained output validity under backpressure. However, the Anvil implementation was observed by the equivalence checker as releasing the same output beat twice, resulting in an Anvil release count of 2 compared with the SystemVerilog release count of 1.

All other tested behaviors—including routing, concurrent traffic, round-robin arbitration, and multi-beat packet locking—matched between the SystemVerilog and Anvil implementations.

**Final Result:** 5 of 6 functional test categories passed, with 1 known backpressure discrepancy remaining.

## Part 1B – SVA Verification Results

The router was verified using the SVA checker and SystemVerilog testbench.

### Testbench Results

Tests executed: 14  
PASS count: 36  
FAIL count: 0  

TESTBENCH RESULT: PASS

### Router Checker Results

CORE CHECKS: PASS

### Fairness Results

Output 1 / Input 0 contention wins: 4  
Output 1 / Input 1 contention wins: 4  
Output 1 fairness: PASS

Output 0 fairness: NOT DEMONSTRATED
## Part 1B – SVA Verification Results

The router was verified using the SVA checker and SystemVerilog testbench.

### Testbench Results

Tests executed: 14  
PASS count: 36  
FAIL count: 0  

TESTBENCH RESULT: PASS

### Router Checker Results

CORE CHECKS: PASS

### Fairness Results

Output 1 / Input 0 contention wins: 4  
Output 1 / Input 1 contention wins: 4  
Output 1 fairness: PASS

Output 0 fairness: NOT DEMONSTRATED

### Part C — Equivalence Testing Results

The SystemVerilog and Anvil implementations were tested using a common equivalence testbench with matched input stimuli. The test suite checks basic routing, concurrent traffic, round-robin arbitration, backpressure, and multi-beat packet locking.

**Test Results:**

| Test                             | Result               |
| -------------------------------- | -------------------- |
| Basic Routing                    | PASS                 |
| Concurrent Traffic               | PASS                 |
| Output 0 Round-Robin Arbitration | PASS                 |
| Output 1 Round-Robin Arbitration | PASS                 |
| Backpressure                     | FAIL — 1 discrepancy |
| Multi-beat Packet Locking        | PASS                 |

The final simulation checked **243 cycles** and reported **1 error**.

The only discrepancy occurred during the backpressure test. Both implementations produced the expected output data and maintained output validity under backpressure. However, the Anvil implementation was observed by the equivalence checker as releasing the same output beat twice, resulting in an Anvil release count of 2 compared with the SystemVerilog release count of 1.

All other tested behaviors—including routing, concurrent traffic, round-robin arbitration, and multi-beat packet locking—matched between the SystemVerilog and Anvil implementations.

**Final Result:** 5 of 6 functional test categories passed, with 1 known backpressure discrepancy remaining.

### Router Functionality and Fairness Verification

The equivalence test suite verifies the main functional properties of the 2×2 router, including correct destination-based routing, concurrent traffic handling, ready/valid handshake behavior, packet locking, and round-robin arbitration.

#### General Router Checks

The following router behaviors were verified:

* **Basic routing:** Input packets are delivered to the output selected by the destination bit (`tdest`).
* **Concurrent traffic:** Both input ports can transfer packets simultaneously when they target different outputs.
* **Ready/valid handshake:** Output transfers occur only when both `valid` and `ready` are asserted.
* **Backpressure:** The router keeps output data valid when the downstream receiver is not ready.
* **Multi-beat packet handling:** All beats of a packet are delivered in order.
* **Packet locking:** Once an input wins an output for a multi-beat packet, the output remains locked to that input until the packet's `last` beat is transferred.
* **No packet loss or duplication:** The equivalence checker compares the packets observed at the SystemVerilog and Anvil outputs.

#### Round-Robin and Fairness Checks

Round-robin arbitration was checked independently for both output ports.

**Output 0:**

* Contention between Input 0 and Input 1 was generated.
* The SystemVerilog and Anvil implementations produced matching output sequences.
* Multiple contention cases were tested.
* **Result: PASS**

**Output 1:**

* Contention between Input 0 and Input 1 was generated.
* The SystemVerilog and Anvil implementations produced matching output sequences.
* Multiple contention cases were tested.
* **Result: PASS**

The tests demonstrate that both implementations make consistent arbitration decisions under contention and that the round-robin state is maintained across successive arbitration decisions.

### Final Verification Summary

| Category                   | Result              |
| -------------------------- | ------------------- |
| Basic Router Functionality | PASS                |
| Concurrent Routing         | PASS                |
| Output 0 Round-Robin       | PASS                |
| Output 1 Round-Robin       | PASS                |
| Packet Locking             | PASS                |
| Backpressure               | 1 known discrepancy |
| Overall Equivalence        | 1 known error       |

The equivalence testbench executed **243 cycles**. The SystemVerilog and Anvil implementations matched for the major routing, arbitration, concurrency, and packet-locking behaviors. One known discrepancy remains in the backpressure release-count check.

