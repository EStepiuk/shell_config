alias re-zshrc='source ~/.zshrc'

flutter_build_runner() {
  flutter pub run build_runner $1 --delete-conflicting-outputs
}

alias flutter_build_runner_build='flutter_build_runner build'
alias flutter_build_runner_watch='flutter_build_runner watch'

alias cat='bat'

alias batdiff='git diff --name-only --relative --diff-filter=d | xargs bat --diff'
alias submodules='git submodule update --init --recursive'

adb-wifi() {
  adb tcpip 5555
  adb connect $1
}
