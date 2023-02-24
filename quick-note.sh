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
