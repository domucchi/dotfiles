#!/usr/bin/env bash
set -euo pipefail

# A toggleable (or fixed-duration) PipeWire/FFmpeg recorder that
# captures your “.monitor” source, saves to ~/media/audio, and
# copies the resulting WAV file URI to the Wayland clipboard.

# --- USAGE ---
usage() {
  cat <<EOF
Usage: $(basename "$0") [duration_seconds]

Without arguments: toggles start/stop of recording.
With a single integer argument N: records for N seconds, then stops.

Options:
  -h, --help    Show this help message and exit.
EOF
}

# --- ARGUMENTS ---
if [[ "${1:-}" =~ ^(-h|--help)$ ]]; then
  usage
  exit 0
fi

if [[ $# -gt 1 ]]; then
  echo "❌ Error: Too many arguments." >&2
  usage
  exit 1
fi

DURATION=""
if [[ $# -eq 1 ]]; then
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    DURATION="$1"
  else
    echo "❌ Error: duration must be a positive integer." >&2
    usage
    exit 1
  fi
fi

# --- CONFIGURATION ---
RECORDINGS_DIR="$HOME/media/audio"
PIDFILE="$RECORDINGS_DIR/.rec.pid"
FILELIST="$RECORDINGS_DIR/.rec.last"
FORMAT="wav"

# --- DEPENDENCIES ---
for cmd in ffmpeg pactl notify-send wl-copy file realpath awk; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "❌ Error: '$cmd' not found in PATH." >&2
    exit 1
  fi
done

mkdir -p "$RECORDINGS_DIR"

# --- HELPERS ---
get_monitor() {
  pactl list sources short \
    | awk '/\.monitor/ { print $2; exit }'
}

# --- START RECORDING ---
start_recording() {
  local src ts out pid ff_args=()
  src=$(get_monitor)
  if [[ -z "$src" ]]; then
    notify-send "🚫 Audio Record Error" \
      "Could not find a .monitor source."
    exit 1
  fi

  ts=$(date +%Y%m%d_%H%M%S)
  out="$RECORDINGS_DIR/system_audio_${ts}.${FORMAT}"

  [[ -n "$DURATION" ]] && ff_args+=( -t "$DURATION" )

  ffmpeg -hide_banner -loglevel error \
    -f pulse -i "$src" "${ff_args[@]}" "$out" &
  pid=$!

  echo "$pid"   >"$PIDFILE"
  echo "$out"   >"$FILELIST"

  if [[ -n "$DURATION" ]]; then
    notify-send "⏺️ Recording Started" \
      "→ $(basename "$out") for ${DURATION}s"
  else
    notify-send "⏺️ Recording Started" \
      "→ $(basename "$out") (toggle mode)"
  fi
}

# --- STOP RECORDING ---
stop_recording() {
  local pid out uri

  if [[ ! -f "$PIDFILE" ]]; then
    notify-send "ℹ️ Audio Recorder" \
      "No recording in progress."
    exit 0
  fi

  pid=$(<"$PIDFILE"); rm -f "$PIDFILE"
  out=$(<"$FILELIST"); rm -f "$FILELIST"

  kill -INT "$pid" 2>/dev/null || true
  wait "$pid"    2>/dev/null || true
  sleep 0.2

  if [[ ! -s "$out" ]]; then
    notify-send "🚫 Audio Recorder" \
      "Recorded file is empty or missing!"
    exit 1
  fi

  uri="file://$(realpath "$out")"
  printf '%s\n' "$uri" | wl-copy --type text/uri-list

  notify-send "⏹️ Recording Stopped" \
    "Saved $(basename "$out") and copied URI"
}

# --- MAIN LOGIC ---
if [[ -n "$DURATION" ]]; then
  start_recording
  sleep "$DURATION"
  stop_recording
else
  if [[ -f "$PIDFILE" ]]; then
    stop_recording
  else
    start_recording
  fi
fi
