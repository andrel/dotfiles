(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-refile-targets '(
   (nil :maxlevel . 2)              ; refile to headings in the current buffer
   (org-agenda-files :maxlevel . 2) ; refile to any of these files
    ))
