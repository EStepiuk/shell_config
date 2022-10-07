alias re-zshrc='source ~/.zshrc'

flutter-build-runner() {
  flutter pub run build_runner "$1" --delete-conflicting-outputs
}

alias flutter-build-runner-build='flutter-build-runner build'
alias flutter-build-runner-watch='flutter-build-runner watch'

alias cat='bat'

alias batdiff='git diff --name-only --relative --diff-filter=d | xargs bat --diff'
alias submodules='git submodule update --init --recursive'

adb-wifi() {
  adb tcpip 5555
  adb connect $1
}

# Fixes HDD issue with fsck.
# You need to already fix this HDD 😅
alias fix-hdd='sudo pkill -9 fsck'

alias brew-dump='brew bundle dump --force --file="$SHELL_CONFIG/Brewfile"'
