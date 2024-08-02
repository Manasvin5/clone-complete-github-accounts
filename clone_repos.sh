#!/bin/bash
echo "Hello User, This Program  This Script Clones a Complete Github Account with All Its Repositories "
read -p "Enter GitHub username: " USERNAME




mkdir -p $USERNAME
cd $USERNAME





clone_repos() {
  PAGE=1
  while :; do
    REPOS=$(curl -s "https://api.github.com/users/$USERNAME/repos?per_page=100&page=$PAGE" | jq -r '.[].clone_url')
    if [ -z "$REPOS" ]; then
      break
    fi

    for REPO in $REPOS; do
      git clone $REPO
    done

    ((PAGE++))
  done
}



clone_repos


echo "All repositories have been cloned into the directory $USERNAME. Thank-you For Using This Program !!!!"
