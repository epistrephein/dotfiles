# ---------------------------------------------------------
#  PYTHON
# ---------------------------------------------------------

alias activate='source .venv/bin/activate'
alias act='source .venv/bin/activate'
alias dea='deactivate'
alias deac='deactivate'
alias deact='deactivate'

alias mkenv='python -m venv .venv --prompt $(basename $(pwd)) && activate'
alias rmenv='[ -z "$VIRTUAL_ENV" ] && [ -d .venv ] && rm -rf .venv || echo "In use"'

alias mkpip='pip install -U pip'
alias mkjup='pip install -U ipykernel'

alias req='pip install -r requirements.txt'

pythonlatest() {
  mise ls python --installed --json | jq -r '.[-1].version'
}

pyver() {
  if [ -f ".python-version" ]; then
    echo "Warning: .python-version already exists with version: $(cat .python-version)" >&2
  elif [ "$#" -gt 0 ]; then
    echo "$1" > .python-version
    echo ".python-version created with version: $1"
  else
    PY_VERSION=$(pythonlatest)
    echo "$PY_VERSION" > .python-version
    echo ".python-version created with version: $PY_VERSION"
  fi
}

mkpy() {
  if [ -d .venv ]; then
    echo ".venv already exists. Aborting setup." >&2
    return 1
  fi

  if [ ! -f requirements.txt ]; then
    cp -ai ~/.templates/python/. .
  fi

  pyver "$@" && mkenv && act && [ -n "$VIRTUAL_ENV" ] && mkpip && [ -f requirements.txt ] && req
}

uppy() {
  if [ ! -d .venv ]; then
    pyver "$@" && mkenv
  fi

  act && [ -n "$VIRTUAL_ENV" ] && mkpip && [ -f requirements.txt ] && req
}
