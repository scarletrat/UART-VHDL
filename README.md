
This project implements a UART transmitter, UART receiver, a sender FSM, and a top-level hardware design for the Zybo board.  
The design sends a hardcoded string over serial at 115200 baud using a USB-UART PMOD module.

## Files

| File | Description |
|------|-------------|
| `uart_tx.vhd`        | UART transmitter FSM implementing 8-N-1 protocol (8 data bits, no parity, 1 stop bit). |
| `uart_rx.vhd`        | UART receiver FSM. |
| `uart.vhd`           | Wrapper that integrates both UART TX and RX modules. |
| `sender.vhd`         | FSM that sends each character of a hardcoded string one at a time when the button is pressed. |
| `top_level.vhd`      | Instantiates UART, sender, debounce circuits, and clock divider. |
| `clock_div.vhd`      | Generates a 115200 Hz enable signal for UART timing. |
| `debounce.vhd`       | Debounces button input (two instances used). |
| `uart_tb.vhd`        | Testbench for simulation of UART behavior. |
| `zybo_old_board.xdc` | Constraints file mapping Zybo pins to the UART PMOD adapter. |

## UART Transmitter (uart_tx.vhd)

Implements the UART TX protocol:

- Idle (line high)
- Start bit (low)
- 8 data bits, LSB first
- Stop bit (high)
- `ready` output goes high when idle
- Transmission begins when `send = '1'` and the baud enable signal is asserted

## Sender FSM (sender.vhd)

A small state machine that:

- Stores a hardcoded string as an array of ASCII bytes
- On button press:
  - Places the next character on the UART data line
  - Pulses `send`
  - Waits until UART finishes transmitting
- Wraps the index when the entire string has been sent

## Top-Level Design (top_level.vhd)

Instantiates:

- UART (TX and RX)
- Sender FSM
- Clock divider (115200 Hz)
- Debounce filters
- Button interface
- PMOD TX/RX routing for the USB-UART bridge

The PMOD adapter connects to PMOD port JB on the Zybo (top row), with TX and RX crossed.
