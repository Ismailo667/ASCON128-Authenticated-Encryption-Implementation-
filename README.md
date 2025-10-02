# Digital System Design Project: ASCON128

---

## Table of Contents
- 1 Introduction  
- 2 Project Architecture  
  - 2.1 Structure and Components of ASCON Encryption  
  - 2.2 Code Structure  
- 3 Implementation of Elementary Transformations  
  - 3.1 Constant Addition pC  
    - 3.1.1 Simulation  
  - 3.2 Substitution Layer pS  
    - 3.2.1 Simulation  
  - 3.3 Linear Diffusion Layer pL  
- 4 Development of Permutations p⁶ and p¹²  
  - 4.1 XOR Operators in Permutations  
- 5 Finite State Machine (FSM) Development  
  - 5.1 Simulation  
- 6 Challenges Encountered  
- 7 Conclusion  

---

## 1. Introduction

In today’s digital era, **data security** has become a major concern in the face of cyberattacks and malicious intrusions. Sensitive and personal information is constantly stored and transmitted across networks, increasing the risk of privacy breaches.  

Encryption systems play a vital role in protecting data from unauthorized manipulation. The **ASCON128 encryption algorithm** stands out by providing both confidentiality of encrypted messages and authenticity of message headers using an authentication tag.  

The tag enables the recipient to verify the integrity of received data. If the recomputed tag differs from the transmitted one, the recipient can detect tampering and reject the message.  

The objective of this project was to design and implement the **ASCON128 encryption algorithm** in **SystemVerilog**, exploring both cryptographic principles and hardware design.  

---

## 2. Project Architecture

### 2.1 Structure and Components
The complete ASCON128 circuit is composed of:
- A **Finite State Machine (FSM)** controlling the encryption process.  
- A **Permutation & XOR block** implementing pC, pS, pL transformations and XOR operations.  
- Counters for managing permutation rounds and message block processing.  
- Registers for holding intermediate states, ciphertext, and authentication tags.  

### 2.2 Code Structure

ASCON/
├── SRC/
│ ├── RTL/ → SystemVerilog modules (permutation, S-box, diffusion, FSM, …)
│ └── BENCH/ → Testbenches for verification
├── LIB/
│ ├── LIBRTL → Source library for compilation
│ └── LIBBENCH → Test library for compilation
└── compil_ascon.txt → ModelSim compilation script


A dedicated library `asconpack` defines the 320-bit internal state **S**, split into 5 registers of 64 bits each.

---

## 3. Implementation of Elementary Transformations

### 3.1 Constant Addition (pC)
Adds round constants to the state register during each permutation round.  
**Simulation results** confirmed correct behavior according to the validation reference.  

### 3.2 Substitution Layer (pS)
Applies non-linear transformations using an S-box on 5-bit groups, across 64 columns of the state.  
**Simulation results** matched the expected outputs from the substitution table.  

### 3.3 Linear Diffusion Layer (pL)
Applies bitwise rotations and mixing to spread dependencies across state registers, ensuring proper diffusion.  

---

## 4. Development of Permutations p⁶ and p¹²

The permutation module integrates **pC, pS, and pL** transformations with XOR operations.  
Additional registers are used for storing the intermediate state, ciphertext blocks, and authentication tag.  

### 4.1 XOR Operators
- **XORbegin**: applied at the start with associated data, plaintext, and secret key.  
- **XORend**: applied during finalization with the key and last data block.  

**Simulation results** confirmed correct functionality of the permutation with XOR integration.  

---

## 5. FSM Development

The FSM controls the sequence of operations:
- **Idle**: resets values and waits for start.  
- **Conf Init / Init / End Init**: initialization rounds with key mixing.  
- **DA phases**: associated data processing.  
- **Plaintext phases**: handles multiple blocks of plaintext, with XOR operations and permutations.  
- **Finalization**: outputs ciphertext and authentication tag.  

### 5.1 Simulation
Final waveforms confirmed the expected output tag, validating overall encryption correctness.  

---

## 6. Challenges Encountered

- Understanding the theoretical foundation of the ASCON algorithm before implementation.  
- Translating course requirements into practical SystemVerilog design.  
- Synchronization issues inherent to hardware description languages.  
- Time management and debugging complex FSM behavior.  

Collaboration with classmates was essential to overcome difficulties and optimize implementations.  

---

## 7. Conclusion

This project was a valuable opportunity to bridge **microelectronics** and **cryptography**.  
It strengthened my skills in:
- SystemVerilog hardware design  
- Simulation and debugging of cryptographic circuits  
- Cryptographic primitives (substitution, diffusion, permutations)  

The ASCON project renewed my passion for engineering, combining rigorous debugging, modular design, and optimization. It highlighted the potential of **lightweight cryptography** in securing digital communications.  

---

