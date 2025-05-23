# Common functionality for git scripts

# Print to stderr
echoerr() { echo "[ERROR]:" "$@" 1>&2; }

assert_git_repo() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echoerr "This is not a git repository."
    exit 1
  fi
}

assert_default_branch() {
  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  if [[ "$current_branch" != "main" && "$current_branch" != "master" ]]; then
    echoerr "Not on 'main' or 'master' branch"
    exit 1
  fi
}

assert_no_unpulled_changes() {
  # Sync remotes with state of remote git servers
  git remote update >/dev/null 2>&1
  local local_commit
  local remote_commit
  local_commit=$(git rev-parse HEAD)

  if ! remote_commit=$(git rev-parse '@{upstream}' 2>/dev/null); then
    echoerr "No upstream branch set for current branch"
    exit 1
  fi

  if [ "$local_commit." != "$remote_commit" ]; then
    local behind_count
    behind_count=$(git rev-list 'HEAD..@{upstream}' --count)
    if [ "$behind_count" -gt 0 ]; then
      echoerr "Local branch is behind remote by $behind_count commit(s). Please pull changes first."
      exit 1
    fi
  fi
}

assert_tag_does_not_exist() {
  local new_tag=$1
  if git rev-parse "$new_tag" >/dev/null 2>&1; then
    echoerr "Tag '$new_tag' already exists"
    exit 1
  fi
}

# Function to extract ticket number from the latest commit title
extract_ticket_number() {
  local commit_title
  local ticket_number
  commit_title=$(git log -1 --pretty=%s)
  ticket_number=$(echo "$commit_title" | grep -oE '\[([^]]+)\]' | head -n 1 | tr -d '[]')

  if [[ -z "$ticket_number" ]]; then
    echoerr "No ticket number found in commit title: '$commit_title' "
    exit 1
  fi
  echo "$ticket_number"
}

# Function to bump the next major minor or patch version
# Args:
# tag: X.Y.Z
# vers: major | minor | patch
bump_version() {
  local latest_tag="$1"
  local vers="$2"

  # Parse the current version
  IFS='.' read -r MAJOR MINOR PATCH <<<"$latest_tag"

  case "$vers" in
  --major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  --minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  --patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    echoerr "Invalid version spec: '$vers'"
    exit 1
    ;;
  esac

  # Return the new tag
  echo "$MAJOR.$MINOR.$PATCH"
}
