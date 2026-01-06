#!/bin/bash
# Read cava output and format for conky

FIFO="/tmp/cava_fifo"

# Create FIFO if it doesn't exist
if [ ! -p "$FIFO" ]; then
    mkfifo "$FIFO"
fi

# Read one line from cava output
if [ -p "$FIFO" ]; then
    timeout 0.1 head -n 1 "$FIFO" 2>/dev/null | awk '{
        for(i=1; i<=NF; i++) {
            if($i >= 0 && $i < 2) printf "▁"
            else if($i >= 2 && $i < 4) printf "▂"
            else if($i >= 4 && $i < 6) printf "▃"
            else if($i >= 6 && $i < 8) printf "▄"
            else if($i >= 8 && $i < 10) printf "▅"
            else if($i >= 10 && $i < 12) printf "▆"
            else if($i >= 12 && $i < 14) printf "▇"
            else printf "█"
        }
    }'
else
    echo "▁▂▃▄▅▆▇█▇▆▅▄▃▂▁"
fi
