# GameMachine (Verilog)

A simple Verilog-based game machine implemented as a finite state machine (FSM).  
The design collects inputs from two players, compares them, and computes scores
according to predefined matching rules.

---

## Overview

- Two players enter 4 values each (3-bit wide)
- Inputs are collected sequentially using an FSM
- After all inputs are received, scores are calculated automatically
- Final scores are stored in output registers

---

## Design Highlights

- Fully synchronous FSM design
- Inputs are sampled on the positive edge of the clock
- Clear separation between:
  - State control
  - Input sampling
  - Score calculation
- Deterministic and repeatable simulation behavior

---

## Scoring Rules

- **Exact match** (same value, same position)  
  → Player 2 gains 2 points

- **Value match, different position**  
  → Player 1 gains 1 point  
  → Player 2 gains 1 point

- **No match**  
  → Player 1 gains 2 points

---

## Files

- `gamemachine.v`  
  Contains the main FSM, input registers, and scoring logic.

- `gamemachine_tb.v`  
  Testbench that applies multiple test cases and generates waveform output.

---

## Simulation

The project can be simulated using Icarus Verilog:

```bash
iverilog -o gamemachine gamemachine.v gamemachine_tb.v
vvp gamemachine
