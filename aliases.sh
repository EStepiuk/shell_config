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
gitsu() {
  git "$@" && gsu
}

# Java
# Enable Android Studio JDK
alias asjdk='export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"'

# Gradle
alias gradle-cache-rm='rm -rf ~/.gradle/caches/'

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
  ip=$(adb -d shell ifconfig wlan0 | grep "inet " | awk -F'[: ]+' '{ print $4 }')
  adb -d tcpip 5555
  adb -d connect "$ip"
}

# Development
# Copies project with suffix and opens it in Android Studio.
# Example: 'studio-cp MyProject hot-fix' - copies MyProject to MyProject-hot-fix and opens it. 
studio-cp() {
  result_dir_name="$1-$2"
  cp -r "$1" "$result_dir_name" && studio "$result_dir_name"
}

# Quick notes
source quick-note.sh
