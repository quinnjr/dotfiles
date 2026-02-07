#!/bin/bash
# Single nvidia-smi call, caches results to a temp file
CACHE=/tmp/conky-nvidia
nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,utilization.memory,memory.used,memory.total,clocks.current.graphics,clocks.current.memory,power.draw,power.limit,fan.speed,pstate,utilization.encoder,utilization.decoder --format=csv,noheader,nounits | \
awk -F', ' '{
    printf "GPU_TEMP %s\n", $1
    printf "GPU_UTIL %s\n", $2
    printf "MEM_UTIL %s\n", $3
    printf "VRAM_USED %s\n", $4
    printf "VRAM_TOTAL %s\n", $5
    printf "CORE_CLK %s\n", $6
    printf "MEM_CLK %s\n", $7
    printf "POWER %s\n", $8
    printf "POWER_LIM %s\n", $9
    printf "FAN %s\n", $10
    printf "PSTATE %s\n", $11
    printf "ENC %s\n", $12
    printf "DEC %s\n", $13
}' > "$CACHE"
