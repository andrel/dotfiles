(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cs" 'org-schedule)

(setq org-refile-targets '(
   (nil :maxlevel . 2)              ; refile to headings in the current buffer
   ("~/Documents/gtd/projects.org" :maxlevel . 2)
   ("~/Documents/gtd/someday.org" :maxlevel . 1)
   ("~/Documents/gtd/tickler.org" :maxlevel . 2)
    ))

(custom-set-variables
 '(org-agenda-file-regexp "\\`[^.].*\\.org\\'\\|\\`[0-9]+\\'")
 '(org-agenda-files
   (quote
    ("~/Documents/hjemmefront.org" "~/Documents/kantega/TODO.org" "~/Documents/journal" "~/Documents/gtd/inbox.org" "~/Documents/gtd/projects.org" "~/Documents/gtd/tickler.org"))
   )
)

;; Capture templates
(setq org-capture-templates '(
                              ("t" "Todo [inbox]" entry (file+headline "~/Documents/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry (file+headline "~/Documents/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

;; Org Todo Keywords
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

;;(setq debug-on-error t)
