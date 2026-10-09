# Bug 3: OpenTitan LC_CTRL — Incorrect Escalation Priority

## 1. Instance

**Design:** OpenTitan Lifecycle Controller (`lc_ctrl`)

**References:**
- Issue: [OpenTitan #12204](https://github.com/lowRISC/opentitan/issues/12204)
- Fix: [OpenTitan PR #12218](https://github.com/lowRISC/opentitan/pull/12218)
- Commit: [37d73dc](https://github.com/lowRISC/opentitan/commit/37d73dc)

The lifecycle controller manages lifecycle-state transitions and must respond correctly to global escalation requests. When global escalation and a local FSM error occur simultaneously, escalation must take priority so the controller enters `EscalateSt`.

## 2. Mechanism

The bug occurs because the local FSM error condition is evaluated before the global escalation condition. If both conditions are true, the first branch selects `InvalidSt`, preventing the intended transition to `EscalateSt`.

The reduced behavioral model in `buggy.sv` reproduces this priority conflict. The model in `fixed.sv` gives global escalation the required priority.

The reduced models are illustrative reproductions of the reported behavior, not copies of the complete production RTL.

## 3. Why It Survived

Tests that exercise global escalation without simultaneously triggering a local FSM error will not expose the priority conflict. The failure requires both conditions to be active together, so ordinary tests may not cover the problematic combination.

A verification environment that does not explicitly specify and test the priority between global escalation and local FSM errors can miss this behavior. Conventional linting may also remain silent because the conditional statements are syntactically and structurally valid.

## 4. Bug Class

**Class:** Incorrect priority among competing control conditions.

**Violated invariant:** A global escalation request must take priority over a simultaneous local FSM error. When both are asserted, the next FSM state must be `EscalateSt`, subject to the specified transition latency and reset conditions.

**Independent instance:** A second instance must demonstrate the same general priority-error class in a different design. It must be supported by a separate issue, patch, or other primary-source reference. A related request-selection or transaction-association bug is not automatically evidence of the same priority-error class; the underlying mechanism must be compared explicitly.

## 5. Detection

A SystemVerilog Assertion can check the simultaneous-condition case:

```systemverilog
assert property (@(posedge clk_i) disable iff (!rst_ni)
  ((esc_scrap_state0_i || esc_scrap_state1_i) &&
   ((|state_invalid_error) || token_if_fsm_err_i))
  |=> (state_o == EscalateSt));
```

The assertion requires the appropriate production signal mapping, state encoding, reset behavior and transition latency. It should be run using a simulator or formal tool that supports concurrent assertions.

**Cost and limitations:** The property is inexpensive to evaluate, but its correctness depends on the specified priority and timing. Incorrect assumptions about reset or state-transition latency can produce false failures. Formal verification can explore simultaneous conditions systematically, but requires a suitable model and environment assumptions.

## 6. Files

| File | Description |
|---|---|
| `buggy.sv` | Reduced model containing the priority bug |
| `fixed.sv` | Reduced model with corrected priority |
| `tb_buggy.sv` | Testbench expecting the buggy behavior to trigger `$fatal` |
| `tb_fixed.sv` | Testbench verifying the corrected behavior |
| `run.sh` | Compiles and executes both reduced models |
| `lc_ctrl_escalation_sva.sv` | Proposed SVA checker, if saved separately |

## 7. Running the Reproducer

Requirements: Icarus Verilog with `iverilog` and `vvp` available in `PATH`.

Run:

```bash
chmod +x run.sh
./run.sh
```

Expected result:
- The buggy model triggers the deliberate `$fatal` because local FSM error handling overrides global escalation.
- The fixed model prints a `PASS` message confirming that global escalation takes priority and `EscalateSt` is retained.

The expected failure of the buggy test is evidence that the reduced model reproduces its intended fault. It is not a failure of the overall test procedure.

## 8. Limitations

The test script validates only the reduced behavioral models. It does not establish that the complete upstream RTL has been compiled, that the SVA checker has been executed, or that a formal proof has succeeded. These claims require separate tool runs and recorded results.

