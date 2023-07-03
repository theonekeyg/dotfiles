#!/usr/bin/sh

XDOTOOL=xdotool
MAIM=maim
XCLIP=xclip

maim_exit() {
  echo "$0 error: $@"
}

maim_help() {
  echo "$0: helper commands for maim utility"
  echo "Arguments:"
  echo "  -h|--help - Show this help message"
  echo "  -f|--fullscreen - Screenshot the whole currently active screen"
  echo "  -w|--window - Choose a window to be saved to clipboard"
  echo "  -s|--select - Select a rectangular box to be the contents of the screenshot"
  exit 0
}

if [ -x $MAIM ]; then
  echo "maim is not installed."
  exit 1
fi

if [ -x $XCLIP ]; then
  echo "xclip is not installed."
  exit 1
fi

maim_fullscreen() {
  exec maim | xclip -selection clipboard -t image/png
}

maim_window() {
  if [ -x $XDOTOOL ]; then
    echo "xdotool is not installed."
    exit 1
  fi
  exec maim --window `xdotool selectwindow` | xclip -selection clipboard -t image/png
}

maim_select() {
  exec maim -s | xclip -selection clipboard -t image/png
}

for arg in "$@"
do
  case $arg in
    -h|--help)
      maim_help
    ;;
    -f|--fullscreen)
      maim_fullscreen
      exit 0
    ;;
    -w|--window)
      maim_window
      exit 0
    ;;
    -s|--select)
      maim_select
      exit 0
    ;;
    *)
      maim_exit "Invalid argument: $arg"
  esac
done

maim_fullscreen
