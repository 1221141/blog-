---
Title: Create blog file with emacs
Created: 2023-04-25 15:00:39
Updated: 2023-04-29 16:55:26
---

# Create blog file with emacs

Just wrote a couple of functions to make writing emacs blogging really
easy. I can easily create a new blog file with markdown frontmatter
and then on each save add the updated field to it.

This will make it easier to have an organized blog online.


## Functions

- [x] Create a new File
  - [x] Add frontmatter with title and created date
  - [x] Add "Updated" frontmatter on each save pass the first one
- [x] Open last created file
- [x] Open last updated file
- [ ] Open files (probably just use ripgrep and consult)

## Code

```elisp
(defvar blog-folder "~/notes/blog/blog"
  "The folder where blog files are stored.")

(defvar repo-folder "~/notes/blog"
  "The folder where the git repo is located")

(defun insert-blog-header (title)
  "Insert a YAML header and title into a new blog file."
  (let ((date (format-time-string "%Y-%m-%d %H:%M:%S")))
    (insert "---\nTitle: " title "\nCreated: " date "\n---\n\n# " title "\n\n")))

(defun open-blog-file (title)
  "Create a new blog file with TITLE in `blog-folder' and enable `blog-mode'."
  (interactive "sEnter blog title: ")
  (let* ((slug (replace-regexp-in-string " " "-" (downcase title)))
        (filename (concat (format-time-string "%Y_%m_%d_%H_%M_%S_") slug ".md"))
        (fullpath (concat blog-folder filename)))
    (find-file fullpath)
    (insert-blog-header title)
    (blog-mode)))

(defun update-blog-header ()
  "Insert or update the Updated field in the YAML header of a blog file."
  (let ((updated (format-time-string "%Y-%m-%d %H:%M:%S")))
    (when (and (buffer-file-name)
               (file-exists-p (buffer-file-name)))
      (save-excursion
        (goto-char (point-min))
        (when (re-search-forward "^Created: \\(.+\\)$" nil t)
          (if (re-search-forward "^Updated: .*$" nil t)
              (replace-match (concat "Updated: " updated))
            (progn
              (end-of-line)
              (insert "\nUpdated: " updated))))))))

;; Commit

(defun blog-title-from-file-name (filename)
  "Extract the blog title from FILENAME."
  (with-temp-buffer
    (insert-file-contents filename)
    (goto-char (point-min))
    (when (re-search-forward "^Title: \\(.*\\)$" nil t)
      (let ((title (match-string 1)))
        (concat (format-time-string "%Y-%m-%d" (current-time))
                " "
                (replace-regexp-in-string "[^[:alnum:]]" "-" title)
                ".md")))))

(defun blog-frontmatter-has-updated ()
  "Check if the current buffer's frontmatter has an 'Updated' field."
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "^Updated: .*$" nil t)))

(defun commit-blog-file ()
  (interactive)
  "Add the current file to Git and commit with a message based on whether the file is new or updated."
  (let* ((filename (buffer-file-name))
         (default-directory blog-folder)
         (title (substring-no-properties (blog-title-from-file-name filename)))
         (message (if (blog-frontmatter-has-updated)
                      (concat "Updated: " title)
                    (concat "Created: " title))))
    (when (file-exists-p (expand-file-name ".git" repo-folder))
      (shell-command (concat "git add " (shell-quote-argument filename)))
      (shell-command (concat "git commit -m " (shell-quote-argument message))))))

(defun open-latest-blog-file ()
  "Open the latest created file in `blog-folder'."
  (interactive)
  (let ((latest-file nil)
        (latest-time 0))
    (dolist (file (directory-files blog-folder t "\\.md$"))
      (when (time-less-p latest-time (nth 5 (file-attributes file)))
        (setq latest-time (nth 5 (file-attributes file)))
        (setq latest-file file)))
    (when latest-file
      (find-file latest-file))))

(defun open-latest-created-file ()
  "Open the latest created file in `blog-folder`."
  (interactive)
  (let* ((files (directory-files blog-folder t "^[0-9]\\{4\\}_[0-9]\\{2\\}_[0-9]\\{2\\}.*\\.md$"))
         (latest-file (car (last (sort files #'string<)))))
    (when latest-file
      (find-file latest-file))))

;; minor mode

(defun blog-mode ()
  "Enable blog mode."
  (interactive)
  (setq-local blog-mode t)
  (add-hook 'before-save-hook 'update-blog-header)
  (add-hook 'after-save-hook 'commit-blog-file))
```

