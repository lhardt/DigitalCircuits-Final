# Digital Circuits Final Assignment

**Statement:** Create a verilog circuit that shows a sequence of numbers, in ascending
or descending order, depending on if an input variable (DOWN) is set as 0 or 1.

More specifically, we should:

- Make a finite state machine, which outputs the following numbers:
    - If DOWN=0, it prints  3 3 3 5 6 2, in this order.
    - If DOWN=1, it prints  2 6 5 3 3 3, in this order.

- The state machine should have the following codes:

    | Occurence | Digit     | State (bin.) |
    |-----------|-----------|--------------|
    |           | 6         | 111 (E)      |
    |           | 5         | 110 (D)      |
    | 1st       | 3         | 101 (A)      |
    | 2nd       | 3         | 100 (B)      |
    | 3rd       | 3         | 011 (C)      |
    |           | 2         | 010 (F)      |

- The state machine should switch digits every **three** seconds, using only
the 1s clock given by the board software. This means there will also be a
need for a clock state machine.

- The ENABLE pin for the internal flip-flops of the state machine must be 
the output of the frequency divider. So a consequence of this is that the 
frequency divider output must be `0` for two seconds and `1` in the other
second, and not the other way around. 


## Implementation

- **Internal State Switches** (in `internalstate.v`):
  -   If DOWN=0 (sequence = 3,3,3,5,6,2):
    
    | Current State   | Next State (DOWN=0) | Next State (DOWN=1)  |
    |-----------------|---------------------|----------------------|
    | A 101 (1st 3)   | B 100 (2nd 3)       | F 010 (2)            |
    | B 100 (2nd 3)   | C 011 (3rd 3)       | A 101 (1st 3)        |
    | C 011 (3rd 3)   | D 110 (5)           | B 100 (2nd 3)        |
    | D 110 (5)       | E 111 (6)           | C 011 (3rd 3)        |
    | E 111 (6)       | F 010 (2)           | D 110 (5)            |
    | F 010 (6)       | A 010 (2)           | E 110 (5)            |