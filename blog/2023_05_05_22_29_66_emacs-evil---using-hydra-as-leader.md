---
Created: 2023-04-29 11:22:17
Title: Emacs Evil - Using Hydra as Leader
Updated: 2023-05-05 22:44:29
---

# Emacs Evil - Using Hydra as Leader

I am an avid user of Emacs with `evil-mode` and throughout the years I've used `general.el` as the leader library.

Lately I started using a different approach, remap space in normal mode to trigger a master hydra head, and from there i write all the commands that i use.


## Remap Space

`(define-key evil-normal-state-map (kbd "SPC") 'master-hydra/body)`

## Define the hydras

```elisp
(defhydra master-hydra ()
    "master"
    ("1" delete-other-windows "delete-other-windows" :exit t)
    ("SPC" execute-extended-command "M-x" :exit t)
    ("j" hydra-buffer/body "buffer" :exit t)
    (";" save-buffer "save-buffer" :exit t))

  ;; buffer operations
  (defhydra hydra-buffer (:color blue :columns 3)
    "buffers:"
    ("9" bookmark-set "bookmark-set" :exit t)
    ("w" bookmark-jump "bookmark-jump" :exit t)
    ("k" next-buffer "next" :color red)
    ("f" consult-buffer "switch" :exit t)
    ("e" find-file "find-file" :exit t)
    ("b" ibuffer "ibuffer")
    ("c" org-capture "org capture")
    ("j" previous-buffer "prev" :color red)
    ("a" avy-goto-char "goto char")
    ("L" avy-goto-line "goto line")
    ("l" consult-line "consult line")
    ("g" (consult-ripgrep "~/notes") "Find all notes")
    ("C-b" buffer-menu "buffer menu")
    ("n" evil-buffer-new "new")
    ("d" kill-this-buffer "delete" :color red)
    ("-" text-scale-decrease "text scale decrease" :color red)
    ("=" text-scale-increase "text scale increase" :color red)
    ("D" (progn (kill-this-buffer) (next-buffer)) "delete" :color red)
    ("s" save-buffer "save" :exit t)
```
`