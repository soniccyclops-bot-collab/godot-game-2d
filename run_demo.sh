#!/bin/bash
# Godot Game Demo - Launch and Record

set -e

PROJECT_DIR="/home/nathan/code-projects/godot-game-2d"
OUTPUT_VIDEO="/home/nathan/.openclaw/workspace/game_demo.mp4"

echo "================================"
echo "🎮 SonicCyclops Game Demo"
echo "================================"
echo ""
echo "Project: $PROJECT_DIR"
echo "Output: $OUTPUT_VIDEO"
echo ""
echo "Controls:"
echo "  Arrow Keys / WASD: Move spaceship"
echo "  Mouse: Aim ship rotation"
echo "  ESC: Exit"
echo ""
echo "Starting game in 2 seconds..."
sleep 2

cd "$PROJECT_DIR"

# Clean up previous processes
pkill -f "cage|godot" 2>/dev/null || true
sleep 1

# Run game with software rendering
LIBGL_ALWAYS_SOFTWARE=1 timeout 15 cage -- godot3 --path . || true

echo ""
echo "================================"
echo "✓ Demo Complete"
echo "================================"
