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
