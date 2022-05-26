alias re-zshrc='source ~/.zshrc'

flutter_build_runner() {
  flutter pub run build_runner $1 --delete-conflicting-outputs
}

alias flutter_build_runner_build='flutter_build_runner build'
alias flutter_build_runner_watch='flutter_build_runner watch'

