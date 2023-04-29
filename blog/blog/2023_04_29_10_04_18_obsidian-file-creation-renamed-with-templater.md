---
title: Obsidian file creation renamed with templater
Created: 2023-04-29 10:39:00
Updated: 2023-04-29 10:45:52
---

# Obsidian file creation renamed with templater

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

### Linter plugin
The linter plugin makes it easy to update the updated and title metadata in the frontmatter, this is also similar to what i have in my emacs `blog.el` mode.


