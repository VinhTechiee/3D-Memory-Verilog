# 8×8×8 Three-Dimensional Memory Design Using Verilog HDL

## Overview

This repository presents the design and verification of a memory module implemented using **Verilog Hardware Description Language (HDL)**. The objective of this project is to model a structured memory system and validate its functionality through simulation.

The proposed architecture conceptually represents an **8 × 8 × 8 three-dimensional memory structure**, resulting in a total of **512 addressable memory locations**, where each location stores an **8-bit data word**. The system supports synchronous **read and write operations**, controlled by a dedicated signal and synchronized by a clock.

This project was developed as part of the **Logic Design with HDL** course at **Ho Chi Minh City University of Technology**.

---

## System Architecture

The memory module operates synchronously with respect to a clock signal. The design consists of the following signals:

### Inputs
- `clk` – Clock signal used to synchronize memory operations  
- `reset` – Reset signal used to initialize the system  
- `wrt_read` – Control signal (`0 = write`, `1 = read`)  
- `row_addr` – Row address (3-bit)  
- `col_addr` – Column address (3-bit)  
- `depth_addr` – Depth address (3-bit)  
- `data_in` – 8-bit input data  

### Output
- `data_out` – 8-bit output data  

The addressing mechanism enables a unique memory location to be accessed through a combination of the three address indices.

---

## Memory Organization

The memory system is conceptually organized as a **three-dimensional array**:

```
8 × 8 × 8 memory array
```

This configuration results in:

- **512 memory cells**
- **8-bit data width per cell**
- **Three addressing dimensions (row, column, depth)**

Such a structure is useful for representing volumetric data and multidimensional data structures in digital systems.

In hardware description languages such as Verilog, multidimensional arrays can be used to represent this architecture. During synthesis, FPGA tools typically map this representation into **Block RAM (BRAM)** or distributed logic resources.

---

## Functional Operation

All memory operations are triggered on the **positive edge of the clock signal**.

### Reset
When `reset` is asserted:
- The output is cleared.
- The memory may optionally be initialized.

### Write Operation
When `wrt_read = 0`:
- The value on `data_in` is written to the selected memory location.
- The output remains inactive during the write operation.

### Read Operation
When `wrt_read = 1`:
- The value stored at the selected address is retrieved.
- The retrieved value is assigned to `data_out`.

---

## Verification

To verify the functionality of the memory module, a **testbench** was developed.

The testbench performs the following operations:

1. Generates a periodic clock signal  
2. Applies reset conditions  
3. Writes test data to selected memory locations  
4. Reads the stored data to verify correctness  

Simulation results demonstrate that the memory module correctly performs both **read** and **write** operations.

---

## Development Environment

The project was implemented and simulated using the following tools:

- **Hardware Description Language:** Verilog HDL  
- **Design and Simulation Tool:** Xilinx Vivado  

The Vivado simulator was used to observe waveform outputs and verify the functional behavior of the design.

---

## Repository Structure

```
3D-Memory-Verilog
│
├── memory3D.v        # Verilog implementation of the memory module
├── tb_memory3D.v     # Testbench for simulation
├── project_2.xpr     # Vivado project file
└── README.md
```

---

## Conclusion

This project demonstrates the modeling and verification of a structured memory system using Verilog HDL. The implemented design successfully supports synchronous read and write operations and was verified through simulation.

The modular architecture allows the design to be extended for larger memory sizes or integrated into more complex digital systems.

---

