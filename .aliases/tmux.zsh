# ---------------------------------------------------------
#  TMUX
# ---------------------------------------------------------

# List tmux sessions.
tls() {
  tmux ls
}

# Detach from the current session.
td() {
  tmux detach
}

# Switch to the specified window.
tw() {
  tmux select-window -t ":$1"
}

# Attach to a session or create one for the current directory.
# When launched in the home directory, attach to the last used session.
ta() {
  session_name="${1:-$(basename "$PWD")}"

  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach -t "$session_name"
    return
  elif [ "$PWD" = "$HOME" ]; then
    tmux attach
    return
  fi

  tmux new-session -d -s "$session_name" -n app -c "$PWD"
  tmux new-window -t "$session_name" -n shell -c "$PWD"

  tmux select-window -t "$session_name":0
  tmux attach -t "$session_name"
}

# Kill the current session.
tq() {
  if [ -z "$TMUX" ]; then
    echo "Not inside a tmux session"
    return 1
  fi

  tmux kill-session -t "$(tmux display-message -p '#S')"
}
