---
Created: 2023-04-29 11:22:17
Title: Diving into Jekyll
Updated: 2023-05-01 11:50:05
---

# Diving into Jekyll

I think I will stick with Jekyll. It is the default GitHub-pages generator, and since I split my blog articles source from the publish repository source I don't feel any problem into "polluting" the open one with configuration files.

Although there are several high performance static site generators, I will run the generation into GitHub CI, so I really don't need to wait anything (nor do I care how long it takes for my notes to be available online)

## What do I need in a blog?

Other than what I already have, I want to list the creation/update date, and probably add an RSS feed to it. This can be made by creating my own layout and use the Jekyll RSS plugin.

Also I wonder if I can integrate my `generate_index.rb` script into Jekyll build process itself, that would be cool. But for now I will experiment in a different repo to  see what I can come up with.

