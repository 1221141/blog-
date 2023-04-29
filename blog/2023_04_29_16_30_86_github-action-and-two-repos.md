---
Title: Github Action and Two Repos
Created: 2023-04-29 16:30:13
Updated: 2023-04-29 16:55:49
---

# Github Action and Two Repos

I managed to successfully create a way to have my main blog folder in a private repo and publish only the public folder in another public repo using github actions.


## Setup

#### Private Repo

The private repo contains all the folders and private files that are not necessarily the main blog posts, it will have a action that will trigger another job in another repo

```yaml
name: CI
on:
  push:
    branches: [ "main" ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Repository Dispatch
        uses: peter-evans/repository-dispatch@v2
        with:
          token: ${{ secrets.PAT }}
          repository: user/another-repo
          event-type: build-blog
```

#### Public Repo

Then the public repo will have the following action

```yaml
name: CI
on:
  repository_dispatch:
    types:
      - build-blog

  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
	    # this will clone the original repo in a origin folder
      - uses: actions/checkout@v3
        with:
          repository: user/original-repo
          token: ${{ secrets.PAT }}
          path: origin
        # This will clone the current publid repo in a main folder
      - name: Checkout
        uses: actions/checkout@v3
        with:
          path: main
          token: ${{ secrets.PAT }}
		# move the files from the origin to the new one
      - name: remove-all-else
        run: cp -r origin/blog main/
	    # publish changes
      - name: Commit blog
        run: |
          cd main
          git config --global user.name '1221141'
          git config --global user.email 'redacted@nope.np'
          git add .
          git commit -m 'pushing blog'
          git push -f
```