# Bug 1: OTP ECC Error Reporting

## 1. Overview

This experiment investigates a reduced SystemVerilog model of an ECC error-reporting problem associated with the OpenTitan OTP Controller.

- **Project:** OpenTitan
- **Reference:** [Issue #5175](https://github.com/lowRISC/opentitan/issues/5175)
- **Bug class:** Error propagation and status-register consistency
- **Language:** SystemVerilog
- **Simulation tool:** Icarus Verilog

**Verification scope:** The implementation in this directory is a reduced behavioral model. Its simulation results demonstrate the modeled failure and correction, but do not establish exact equivalence to the historical OpenTitan RTL.

## 2. Bug Mechanism

The reduced buggy implementation samples the ECC error only when the response-valid signal is asserted. If an error occurs earlier and disappears before the response arrives, the error is lost.

The corrected implementation stores an observed error in a register and reports it when the response becomes valid.

This experiment focuses on the following invariant:

> An ECC error detected during a multi-cycle read must not be lost before the corresponding operation's result is reported.

## 3. Directory Contents

| File | Purpose |
|---|---|
| `otp_ecc_buggy.sv` | Reduced buggy RTL |
| `tb_otp_ecc_buggy.sv` | Testbench for the buggy implementation |
| `otp_ecc_fixed.sv` | Reduced corrected RTL |
| `tb_otp_ecc_fixed.sv` | Testbench for the corrected implementation |
| `otp_ecc_sva.sv` | Assertion-based checker |
| `results.txt` | Captured simulation output |

## 4. Running the Simulation on macOS

Install Icarus Verilog if needed:

```bash
brew install icarus-verilog
```

Navigate to the project directory:

```bash
cd ~/Desktop/otp_bug
```

### 4.1 Buggy implementation

Compile and run:

```bash
iverilog -g2012 -s tb_otp_ecc_buggy \
  -o buggy_sim otp_ecc_buggy.sv tb_otp_ecc_buggy.sv

vvp buggy_sim
```

**Expected outcome:** The test terminates with `$fatal` because the early ECC error was lost. This failure is intentional and demonstrates the modeled bug.

### 4.2 Corrected implementation

Compile and run:

```bash
iverilog -g2012 -s tb_otp_ecc_fixed \
  -o fixed_sim otp_ecc_fixed.sv tb_otp_ecc_fixed.sv

vvp fixed_sim
```

**Expected outcome:** The test passes and reports:

```text
status_err_o = 1
err_code_o   = 2
PASS: ECC error correctly reported.
```

These are the expected results from the reduced model. Refer to `results.txt` for the actual output recorded during execution.

## 5. Assertion-Based Detection

The file `otp_ecc_sva.sv` contains two conceptual SystemVerilog Assertion (SVA) properties.

### Property 1: Previously detected ECC error

If an ECC error was observed before the response-valid cycle, the status and error-code outputs must indicate the error after the response is processed.

```systemverilog
property p_ecc_error_reported;
    @(posedge clk)
    disable iff (!rst_n)
    (err_seen_q && otp_rvalid_i)
    |=> (status_err_o && err_code_o == ECC_ERROR);
endproperty
```

### Property 2: ECC error on the response-valid cycle

An ECC error occurring on the response-valid cycle must also be reported.

```systemverilog
property p_ecc_error_on_response;
    @(posedge clk)
    disable iff (!rst_n)
    (otp_err_i && otp_rvalid_i)
    |=> (status_err_o && err_code_o == ECC_ERROR);
endproperty
```

The non-overlapping implication operator `|=>` checks the consequent at the next sampled clock. This accommodates the registered output update in the reduced model.

**Implementation note:** The checker must have access to `err_seen_q` and the `ECC_ERROR` constant, either through its own tracking logic and local parameter or through explicit input ports. These snippets are property examples, not standalone compilable assertions. Validate the complete checker against the implementation before relying on it.

Icarus Verilog may not support the concurrent assertion constructs used here. Run the properties with a simulator or formal verification tool that supports the required SVA features.

## 6. Why the Bug May Have Survived

A plausible explanation is that earlier verification did not exercise an ECC error occurring before the final response-valid cycle. Tests that inject errors only on the response cycle could miss this timing scenario.

This explanation is an inference. The historical verification gap for OpenTitan issue #5175 has not been independently established here.

## 7. Verification Results

The reduced model was tested with Icarus Verilog.

| Test | Expected result | Observed result |
|---|---|---|
| Buggy implementation | Failure | `$fatal`: ECC error was lost |
| Corrected implementation | Pass | `status_err_o = 1`, `err_code_o = 2` |

The buggy test failed as expected, while the corrected test passed. These outcomes demonstrate the behavior of the reduced model only.

## 8. Limitations and Trade-offs

- The model simplifies the OTP Controller's internal read and error-propagation logic.
- The simulation does not establish equivalence to the original RTL.
- The assertion examples require adaptation to the real interface, transaction boundaries, and register-update timing.
- Assertion-based verification checks the specified invariant; formal verification may explore more input sequences but depends on accurate assumptions and a faithful design model.
- The historical explanation of why the issue escaped detection requires confirmation from the original issue discussion, affected source revision, and verification history.

Before presenting this as a faithful reproduction, compare the model with the affected upstream RTL and its historical fix.

## 9. References

- OpenTitan issue #5175: https://github.com/lowRISC/opentitan/issues/5175
- OpenTitan repository: https://github.com/lowRISC/opentitan
