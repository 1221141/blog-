---
created: 20230424092334070
modified: 20230527200409131
title: How to publish my blog?
---

# How to publish my blog?

---
title: How to publish my blog?
Created: 2023-04-24 09:23:34 -0700
Updated: 2023-04-29 11:14:34 -0700
---
# How to publish my blog?

I recently stumble upon rwxrob skilstak site. He rewrote using `mkdocs` and I
decided to start looking into it.


In the past I looked at `nanoc` but eventually I dropped. I think the main
takeaway is that I want my markdown files to saved on git and have a external
build process that will copy the files and then perform modifications in it.
This way I can keep the original data intact and change "blog" providers
easily.

Looking into `mkdocs` seems they have several plugins for free that I can use
in conjuction with the material theme.

## Plugins

### Git Date
      uses git to display creation and modification date of a page

    - https://timvink.github.io/mkdocs-git-revision-date-localized-plugin
    
### Blogging

    Simple blogging system

    - https://liang2kl.github.io/mkdocs-blogging-plugin

