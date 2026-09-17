# ---------------------------------------------------------
#  RUBY
# ---------------------------------------------------------

alias b='bundle'
alias be='bundle exec'
alias berails='bundle exec rails'
alias berake='bundle exec rake'
alias berspec='bundle exec rspec'
alias berubocop='bundle exec rubocop'

alias console='bin/console'
alias rails='bin/rails'

alias r='bin/rails'
alias rc='bin/rails console'
alias rs='bin/rails server'
alias rd='bin/dev'

alias rr='bundle exec rspec'
alias rrf='bundle exec rspec --fail-fast'
alias rro='bundle exec rspec --only-failures'
alias rrn='bundle exec rspec --next-failure'
alias rrr='bundle exec rspec; bundle exec rubocop'
alias rrrb='bundle exec rspec; bundle exec rubocop; bundle exec brakeman -q --no-pager'

alias rk='bundle exec rake'
alias rkt='bundle exec rake -T'

rubyver() {
  if [ -f ".ruby-version" ]; then
    echo "Warning: .ruby-version already exists with version: $(cat .ruby-version)" >&2
    return 1
  elif [ "$#" -gt 0 ]; then
    echo "$1" > .ruby-version
    echo ".ruby-version created with version: $1"
  else
    RB_VERSION=$(grep '^ruby ' "$HOME/.tool-versions" | cut -d' ' -f2)
    echo "$RB_VERSION" > .ruby-version
    echo ".ruby-version created with version: $RB_VERSION"
  fi
}

mkruby() {
  if [ -f "Gemfile" ]; then
    echo "Gemfile already exists. Aborting setup." >&2
    return 1
  fi

  cp -ai ~/.templates/ruby/. .
  rubyver "$@" && bundle install
}
