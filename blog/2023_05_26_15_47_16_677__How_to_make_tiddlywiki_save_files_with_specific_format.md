---
created: 20230526154716677
modified: 20230527081841592
title: How to make tiddlywiki save files with specific format
---

# How to make tiddlywiki save files with specific format

From what I get, it has a set of complicated filters see <https://tiddlywiki.com/#Customising%20Tiddler%20File%20Naming> 

I managed to get it working using the creation date, and replace spaces with `_`.

## Steps to reproduce:
- Create a tiddler [](#%24%3A%2Fconfig%2FFileSystemPaths)
- add the following in the content:
```
[!is[system]get[created]] [get[title]lowercase[]split[ ]] +[join[_]]
```

the files in the system will display like this:
`20230526154716677_how_to_make_tiddlywiki_save_files_with_specific_format.md`