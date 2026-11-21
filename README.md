# JK Flip-Flop Layered Testbench

## Student Details

- **Name:** BALAJI N
- **Semester & Section:** 5A
- **SRN:** PES2UG24EC021

## JK Flip-Flop Design

A JK Flip-Flop implemented in SystemVerilog with an active-low asynchronous reset.

### Truth Table

| J | K | Next State (Q) | Operation |
|---|---|---|---|
| 0 | 0 | Q | Hold |
| 0 | 1 | 0 | Reset |
| 1 | 0 | 1 | Set |
| 1 | 1 | ~Q | Toggle |

Complementary output: Q_bar = ~Q.

## Layered Testbench Architecture

```text
                 +----------------------+
                 |        TB_TOP        |
                 |                      |
                 |   Clock and Reset    |
                 +----------+-----------+
                            |
             +--------------+--------------+
             |                             |
    +--------v---------+         +---------v----------+
    |     JK DUT       |         |  TB_ENVIRONMENT    |
    |                  |         |                    |
    | Inputs: J, K     |<--------|      DRIVER        |
    | Outputs: Q, Qbar |         |         ^          |
    +--------+---------+         |         |          |
             |                   |     GENERATOR      |
             |                   |                    |
             +------------------>|      MONITOR       |
                                 |         |          |
                                 |         v          |
                                 |    SCOREBOARD      |
                                 |                    |
                                 +--------------------+
