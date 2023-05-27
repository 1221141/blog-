---
created: 20230526211607394
modified: 20230527075618487
title: Cronjob to autopush tiddlers to github
---

# Cronjob to autopush tiddlers to github

in my LXC container where I am running portainer and the tiddlywiki container I created a cronjob for pushing the changes to github


`*/5 * * * * cd /root/config/tiddlywiki/notes && git add tiddlers/* && git commit -m "Auto-commit on $(date +'\%Y-\%m-\%d \>`

