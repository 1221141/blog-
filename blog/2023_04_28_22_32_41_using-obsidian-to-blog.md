---
Title: Using Obsidian to blog
Created: 2023-04-28 22:32:41
Updated: 2023-04-29 18:55:49
---

# Using Obsidian to blog

Just realized that if i have Obsidian connected to my blog repo I can leverage the Android app to create blog while I am not in my computer. 

Also it seems to be good to have an app to write the test, I wrote a full emacs mode to do it, but if I can replicate that in obsidian I think it is also good. I can have several different editors that will produce the same type of files and sync with git.

## Git Sync

In obsidian one can use the <https://github.com/denolehov/obsidian-git> plugin to sync with git (see docs here: <https://publish.obsidian.md/git-doc/01+Start+here>)

#### Windows
For windows it is required to use the https and the windows credential-manager. I had a previous user signed. 

Steps to fix it:
- <https://stackoverflow.com/a/47466980> check the windows part
- clone the repo in https
- when try to push choose manager and tick to always use that.
- profit

#### Linux
I just followed this guide: <https://linked-blog-starter.vercel.app/connect-obsidian-vault-with-github>
and this <https://publish.obsidian.md/git-doc/04+Authentication#Linux>
But basically: https, and the GitHub token.


## Frontmatter
the <https://github.com/platers/obsidian-linter/blob/master/docs/rules.md#yaml-timestamp> takes care of the frontmatter data.

> Using this proved that the file naming is good, having the creation date in the files made me easily add the created frontmatter

## File Name Spec
This template makes it easy to create a file with my specification and preserving the header.

```
---
Created: <% tp.file.creation_date("YYYY-MM-DD HH:MM:SS") %>
---

<%*
let title = tp.file.title
let filename = title
if ( title.startsWith("Untitled") ) {
  title = await tp.system.prompt("File name: ")
  filename = tp.file.creation_date("YYYY_MM_DD_HH_MM_SS")+"_"+title.replace(/\s+/g, '-').toLowerCase()
  await tp.file.rename(filename)
} 

tR += "# " + title;

%>


`<% tp.file.cursor() %>
```

When creating a new file in the blog folder a prompt asks for the title of the blog post, this is very similar to my emacs/vim approach.

#### Templater settings 

![Pasted image 20230429105252](assets/Pasted%20image%2020230429105252.png)

![](assets/Pasted%20image%2020230429185545.png)
### Linter plugin
The linter plugin makes it easy to update the updated and title metadata in the frontmatter, this is also similar to what I have in my emacs `blog.el` mode.


![Pasted image 20230429105352](assets/Pasted%20image%2020230429105352.png)
![Pasted image 20230429105410](assets/Pasted%20image%2020230429105410.png)