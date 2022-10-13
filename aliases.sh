# Base
alias re-zshrc='source ~/.zshrc'

# Default tools replacement
alias cat='bat'
alias vim='nvim'
alias top='btop'

# Env
alias brew-dump='brew bundle dump --force --file="$SHELL_CONFIG/Brewfile"'

# Git
alias batdiff='git diff --name-only --relative --diff-filter=d | xargs bat --diff'
alias submodules='git submodule update --init --recursive'

# Misc
# Fixes HDD issue with fsck.
# You need to already fix this HDD 😅
alias fix-hdd='sudo pkill -9 fsck'

# Flutter
flutter-build-runner() {
  flutter pub run build_runner "$1" --delete-conflicting-outputs
}
alias flutter-build-runner-build='flutter-build-runner build'
alias flutter-build-runner-watch='flutter-build-runner watch'

# Android
adb-wifi() {
  adb tcpip 5555
  adb connect "$1"
}

# Notes
# Usage: quick-note <flag / arguments>
# Flags:
# * -v - view notes
# * -e - edit notes in editor
# No flags: arguments string will be added to $HOME/quick_notes/quick_notes.txt
quick-note() {
  current_path=$(pwd)
  quick_notes_path="$HOME/quick_notes"
  quick_notes_file="$quick_notes_path/quick_notes.txt"

  if [ "$1" = "-v" ]; then
    cat "$quick_notes_file"
    return 0
  elif [ "$1" = "-e" ]; then
    "${EDITOR:-nano}" "$quick_notes_file"
  else
    note="$*"
    if [ -z "$note" ]; then
      cecho "$Red" "No note provided"
      return 1
    fi
    printf '%s\n\n' "$note" >>quick_notes.txt
    commit_message="Add '$note'"
  fi

  cd "$quick_notes_path" || (
    cecho "$Red" "No notes dir"
    return 1
  )

  if [ ! -d .git ]; then
    git init
  fi

  git add quick_notes.txt

  if [ -z "$commit_message" ]; then
    git commit
  else
    git commit -m "$commit_message"
  fi
  
  # shellcheck disable=SC2164
  cd "$current_path"
}
