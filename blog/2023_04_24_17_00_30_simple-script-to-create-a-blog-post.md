---
Title: Simple script to create a blog post
Created: 2023-04-24 17:00:30
Updated: 2023-04-29 16:54:46
---
# Simple script to create a blog post

This simple bash script will:
  - prompt for a title
  - sanitized th title and use to create a filename
  - open in vim with and add the title to the markdown file

## Bash script (depends on vim, tr, read, git)
```bash
#!/bin/bash

# Prompt user for title
read -p "Enter title: " title

# Sanitize title for use as web slug
slug="$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr '[:space:]' '-' | tr -cd '[:alnum:]-')"

# Create new file in blog folder with current date and time in format YYYY_MM_DD_HH_MM_SS_title.md
filename="$(date +%Y_%m_%d_%H_%M_%S)_$slug.md"

# Open file in Vim
vim "blog/$filename" +"normal! i# $title
"

# Check if file has been modified in Vim
if [[ $(git diff --name-only) == "blog/$filename" ]]; then
  # Add file to Git and push to remote repository
  git add "blog/$filename"
  git commit -m "Add $filename"
  git push
else
  echo "File not modified or saved, changes not committed"
fi
```

