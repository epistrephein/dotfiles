# ---------------------------------------------------------
#  NODE
# ---------------------------------------------------------

nodever() {
  if [ -f ".node-version" ]; then
    echo "Warning: .node-version already exists with version: $(cat .node-version)" >&2
    return 1
  elif [ "$#" -gt 0 ]; then
    echo "$1" > .node-version
    echo ".node-version created with version: $1"
  else
    NODE_VERSION=$(grep '^nodejs ' "$HOME/.tool-versions" | cut -d' ' -f2)
    echo "$NODE_VERSION" > .node-version
    echo ".node-version created with version: $NODE_VERSION"
  fi
}
