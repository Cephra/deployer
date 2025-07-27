#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Usage: deploy.sh <git-repo-url>
# -----------------------------------------------------------------------------
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <git-repo-url>" >&2
    exit 1
fi
repo_url=$1

deploy_dir=$(mktemp -d "${HOME}/deploy.XXXXXXXXXX") \
    || { echo "Error: failed to create temp directory" >&2; exit 1; }

cleanup() {
    rm -rf "$deploy_dir"
}
trap cleanup EXIT

git clone --depth 1 -- "$repo_url" "$deploy_dir" \
    || { echo "Error: git clone failed" >&2; exit 1; }

cd "$deploy_dir"

if [[ ! -f "./deploy.sh" ]]; then
    echo "Error: deploy.sh not found in repository" >&2
    exit 1
elif [[ ! -x "./deploy.sh" ]]; then
    echo "Info: making deploy.sh executable"
    chmod +x ./deploy.sh
fi

./deploy.sh
