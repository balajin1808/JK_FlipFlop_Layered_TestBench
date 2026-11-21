#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build"
mkdir -p "$BUILD_DIR"

iverilog -g2012 -Wall -s tb_top \
  -o "$BUILD_DIR/jk_ff_tb.vvp" \
  "$ROOT_DIR/rtl/jk_flip_flop.sv" \
  "$ROOT_DIR/tb/tb_generator.sv" \
  "$ROOT_DIR/tb/tb_driver.sv" \
  "$ROOT_DIR/tb/tb_monitor.sv" \
  "$ROOT_DIR/tb/tb_scoreboard.sv" \
  "$ROOT_DIR/tb/tb_environment.sv" \
  "$ROOT_DIR/tb/tb_top.sv"

vvp "$BUILD_DIR/jk_ff_tb.vvp"
