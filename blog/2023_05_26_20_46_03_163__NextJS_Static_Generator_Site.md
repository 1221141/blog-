---
created: 20230526204603163
modified: 20230527200409132
title: NextJS Static Generator Site
---

# NextJS Static Generator Site

# NextJS Static Generator Site

Previously I wrote about using mkdocs and other third-party site generators to
take my notes and create a blog.

I think I changed my mind, I believe it is much better if I have the markdown
files in a separated repo and then create a site generator using nextjs or
sveltekit. 

Javascript is not my favourite language, but there are several libraries to
deal with markdown in npm and I guess it will be easy to use and come up with
something fast.

Also, using this approach will make it easy to layout the blog as I see fit. I
just need to see how can i get the creation/edition date everytime I
create/update a blog and save that in the frontmatter.

Right now the creation date is in the filename, which I think is good. I plan
to keep all the blogs in a flag hierarchy and maybe a separated folder for
images/assets.

The idea is to have the files indepented of any structure and copy them using
some CI and publish in some place.

We will see.
