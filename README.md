# 🔍 Mealy Sequence Detector (SystemVerilog)

## Overview

This project implements a **Mealy finite state machine (FSM)** in Verilog to detect specific bit sequences (e.g., `1011` or `1101`) in a **serial input stream**. The output signal goes high (`1`) **immediately** when the target sequence is detected.

A **Mealy machine** outputs based on both the current state and the current input, making it faster and slightly more hardware-efficient than a Moore machine.

---

## 🎯 Target Sequences

* `1011` (Example)
* `1101` (Optional – add additional logic or machine for detection)

---

## ⚙️ Features

* Efficient Mealy FSM implementation in Verilog
* Real-time sequence detection from serial input
* Testbench for simulation and verification
* Easily extendable for other sequences

---

## 🔄 Mealy FSM Operation

### States (for sequence `1011`):

* `S0`: Initial state
* `S1`: Detected `1`
* `S2`: Detected `10`
* `S3`: Detected `101`
* Output becomes `1` during transition from `S3` to `S1` on input `1` (i.e., when `1011` is fully detected)

### Transition Table

| Current State | Input | Next State | Output |
| ------------- | ----- | ---------- | ------ |
| S0            | 1     | S1         | 0      |
| S1            | 0     | S2         | 0      |
| S2            | 1     | S3         | 0      |
| S3            | 1     | S1         | **1**  |
| S3            | 0     | S2         | 0      |
| Others        | -     | S0         | 0      |

---

## 🆚 Mealy vs. Moore Comparison

| Feature           | Mealy FSM                       | Moore FSM                    |
| ----------------- | ------------------------------- | ---------------------------- |
| Output Depends On | Current State **and** Input     | Only on Current State        |
| Output Timing     | **Immediate** (on input change) | One clock cycle **later**    |
| Number of States  | Typically **fewer**             | Typically more               |
| Complexity        | Slightly more complex logic     | Easier to design/debug       |
| Efficiency        | More efficient in hardware      | Slightly more resource-heavy |
| Output Stability  | Can be glitchy on transitions   | More stable                  |

---

## 📁 File Structure

```
/mealy_sequence_detector
│
├── mealy_detector.v      # Verilog module for sequence detection
├── mealy_tb.v            # Testbench for simulation
├── waveform.vcd          # Optional: simulation waveform file
└── README.md             # Project documentation
