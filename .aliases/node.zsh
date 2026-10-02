# ---------------------------------------------------------
#  NODE
# ---------------------------------------------------------

nodelatest() {
  mise ls nodejs --installed --json | jq -r '.[-1].version'
}

nodever() {
  if [ -f ".node-version" ]; then
    echo "Warning: .node-version already exists with version: $(cat .node-version)" >&2
    return 1
  elif [ "$#" -gt 0 ]; then
    echo "$1" > .node-version
    echo ".node-version created with version: $1"
  else
    NODE_VERSION=$(nodelatest)
    echo "$NODE_VERSION" > .node-version
    echo ".node-version created with version: $NODE_VERSION"
  fi
}
