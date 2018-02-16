(require 'mu4e)

;; default
(setq mu4e-maildir (expand-file-name "~/Maildir"))

(setq mu4e-drafts-folder "/runbox/Drafts")
(setq mu4e-sent-folder   "/runbox/Sent")
(setq mu4e-trash-folder  "/runbox/Trash")

;; don't save message to Sent Messages, GMail/IMAP will take care of this
;;(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
      '(("/kantega/INBOX"            . ?i)
        ("/runbox/Trash"             . ?t)
        ("/kantega/Trash"            . ?y)
        ("/kantega/Archives.2018"    . ?s)
        ("/runbox/Archive"           . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
;; I don't use a signature...
(setq
 user-mail-address "andre@lindhjem.net"
 user-full-name "André Lindhjem"
 ;; message-signature
 ;;  (concat
 ;;    "Foo X. Bar\n"
 ;;    "http://www.example.com\n")
 )

;; Support for two mail accounts
(defvar my-mu4e-account-alist
  '(("kantega"
     (user-mail-address  "andre.lindhjem@kantega.no")
     (user-full-name     "André Lindhjem")
     (mu4e-sent-folder   "/kantega/Sendte Elementer")
     (mu4e-drafts-folder "/kantega/Drafts")
     (mu4e-trash-folder  "/kantega/Trash")
     (mu4e-refile-folder "/kantega/Archives.2018"))
    ;; ("gmail"
    ;;  (user-mail-address  "belgarat1@gmail.com")
    ;;  (user-full-name     "André Lindhjem")
    ;;  (mu4e-sent-folder   "/gmail/[Google Mail].Sent Mail")
    ;;  (mu4e-drafts-folder "/gmail/[Google Mail].Drafts")
    ;;  ;; (mu4e-trash-folder  "/gmail/[Google Mail].Bin")
    ;;  )
    ;; ("lindhjem"
    ;;  (user-mail-address "andre@lindhjem.net")
    ;;  (user-full-name "André Lindhjem")
    ;;  )
    ("runbox"
     (user-email-address "andre@lindhjem.net")
     (user-full-name     "André Lindhjem")
     (mu4e-refile-folder "/runbox/Archive")
     (mu4e-sent-folder   "/runbox/Sent")
     (mu4e-trash-folder  "/runbox/Trash"))
    ))

(setq mu4e-user-mail-address-list
      (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
              my-mu4e-account-alist))
(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

;; (defun my-mu4e-set-account ()
;;   "Set the account for composing a message."
;;   (let* ((account
;;           (if mu4e-compose-parent-message
;;               (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
;;                 (string-match "/\\(.*?\\)/" maildir)
;;                 (match-string 1 maildir))
;;             (completing-read (format "Compose with account: (%s) "
;;                                      (mapconcat #'(lambda (var) (car var))
;;                                                 my-mu4e-account-alist "/"))
;;                              (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
;;                              nil t nil nil (caar my-mu4e-account-alist))))
;;          (account-vars (cdr (assoc account my-mu4e-account-alist))))
;;     (if account-vars
;;         (mapc #'(lambda (var)
;;                   (set (car var) (cadr var)))
;;               account-vars)
;;       (error "No email account found"))))

;; ask for account when composing mail
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; Custom trash folder - we don't want all deleted emails to be moved between accounts.
(defun custom-mu4e-trash-folder (msg)
  (if msg
      (cond
       ((string-match "kantega" (mu4e-message-field msg :maildir))
        "/kantega/Trash")
       ((string-match "runbox" (mu4e-message-field msg :maildir))
        "/runbox/Trash")
       ))
    (mu4e-ask-maildir-check-exists "Save message to maildir: "))

(setq mu4e-trash-folder 'custom-mu4e-trash-folder)

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu, 'gnutls' in Archlinux.

(require 'smtpmail)

;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials
;;       '(("smtp.office365.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       (expand-file-name "~/.authinfo.gpg")
;;       smtpmail-default-smtp-server "smtp.office365.com"
;;       smtpmail-smtp-server "smtp.office365.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-debug-info t)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "mail.runbox.com"
      smtpmail-smtp-server "mail.runbox.com"
      smtpmail-smtp-service 587)

(setq message-kill-buffer-on-exit t)

;; mu4e uses this to create text-representations of HMTL emails.
(setq mu4e-html2text-command "html2text -utf8 -width 72")

;; Fancy UTF-8 chars
(setq mu4e-use-fancy-chars t)

;; Confirmation before sending
(add-hook 'message-send-hook
  (lambda ()
    (unless (yes-or-no-p "Sure you want to send this?")
      (signal 'quit nil))))
