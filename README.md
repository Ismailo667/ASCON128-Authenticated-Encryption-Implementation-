# ASCON128 Authenticated Encryption Implementation

Implementation of the **ASCON-128 authenticated encryption algorithm (AEAD)** in **SystemVerilog**, carried out as part of the *Digital Systems Design* course.

## Overview
[ASCON](https://csrc.nist.gov/projects/lightweight-cryptography) is a family of **lightweight cryptographic algorithms** selected by NIST in 2023 for standardization.  
ASCON-128 provides **authenticated encryption with associated data (AEAD)**, ensuring both confidentiality and integrity of messages while leaving headers in plaintext.

This project implements and simulates core components of ASCON-128 in hardware using **SystemVerilog** and **ModelSim**.

## Features
- Round constant addition
- Substitution layer (S-box)
- Diffusion layer
- Permutation (6 or 12 rounds)
- XOR operations for key, plaintext, and associated data
- Finite State Machine (FSM) for process control (partially implemented)

## Repository Structure

SRC/RTL/ → source RTL modules (permutation, S-box, diffusion, FSM, …)
SRC/BENCH/ → testbenches for simulation
LIB/ → compiled libraries and support files
compil_ascon.txt → script for ModelSim compilation


## How to Run (ModelSim)
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ascon128-hw.git
   cd ascon128-hw
source compil_ascon.txt

