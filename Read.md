# A matrix multiplier using four multiplying units

A matrix multiplier can be implemented in various applications such as CNN and Massive MIMO technology. By implementing matrix multiplication in ASIC allows us to take advantage of parallelism and high memory bandwidth to improve performance sigificantly. The design is evaluated with synthesis constraints on speed and area, using **65 nm** standard cell library. The input matrix is 4x8 and the coefficient matrix is 8x4. The design utilizes only **four multiplier units** and is implmented in **VHDL 2002**. **QuestaSim** is used for simulation, **Genus**/ for synthesus and **Cadence Innovus** for Placement and routing.

## Algorithm
First we take the product of matrix multiplication:

P(n) = X(n)A, ...(1)

Where P(n) is the product matrix, X(n) is the input matrix of size 4x8 and A is the coeffi-
cient matrix of size 8x4.

The coefficients
of the matrix are stored in a ROM. The first element in P is computed as:

p1,1 = x1,1a1,1 +x1,2a2,1 +x1,3a3,1 +x1,4a4,1 +x1,5a5,1 +x1,6a6,1, +x1,7(n)a7,1 +x1,8(n)a8,1 ........(2)

or in a generalized equation

pi, j =
N
∑
r=1
xi,r ar, j ....(3)

The first row of matrix P is computed by setting i = 1 and processing all the columns
( j = 1, 2, ...) in (3). Similarly, compute the other rows of matrix P, and store these rows
in a RAM

## ASMD
The ASMD describes describes both the behaviour of registers oprations and control units.

![ASMD](link)

## Block diagram
In the block diagram we have explained the interconnections and the modules used for the matrix multiplication.

![Block_Diagram](link)

## Repository
The following folders contains:

* **Diagrams_Documents:** Contains the ASMD, Block diagram, reference document for Matrix_multiplier and a diagram explaining the working of RAM.

* **Matrix_multiplier:** Has the RTL files.

* **PnR:** The PnR layout, SOC_file (contains the .cmd, I/O, .v (with netlist) and th .global files), Timing_reports,  folder.

* **a**
