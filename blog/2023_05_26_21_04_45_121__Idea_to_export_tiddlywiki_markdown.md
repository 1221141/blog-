---
created: 20230526210445121
modified: 20230527200409131
title: Idea to export tiddlywiki markdown
---

# Idea to export tiddlywiki markdown

I need a cron job that every X seconds push the changes of the tiddlywiki folder to github.

Then, a action will parse every `.md` file and `.meta` and merge them in a `.md` file.

Since the tiddlywiki metadata contains the most important fields for a filename `created` and `title` I can create a file with the proper filename [](#Best%20way%20to%20name%20note%20files).

One problem might be linking files. How can I fix that? 
