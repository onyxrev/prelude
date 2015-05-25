(add-to-list 'custom-theme-load-path "~/.emacs.d/personal/themes")

t(setq load-path (append
  '("~/.emacs.d/personal")
  load-path))

(require 'yaml-mode)
(require 'misc)
(require 'web-mode)

(autoload 'feature-mode "~/.emacs.d/personal/cucumber/feature-mode" nil t)

(setq auto-mode-alist (append
  '(("\\.rb$"          . ruby-mode)
    ("\\.xhtml$"       . web-mode)
    ("\\.html$"        . web-mode)
    ("\\.ejs$"         . web-mode)
    ("\\.feature$"     . feature-mode)
    ("Rakefile$"       . ruby-mode)
    ("\\.rake$"        . ruby-mode)
    ("\\.rhtml$"       . web-mode)
    ("\\.erb$"         . web-mode)
    ("\\.less$"        . css-mode)
    ("\\.scss$"        . css-mode)
    ("\\.sass$"        . css-mode)
    ("\\.yml$"         . yaml-mode)
    ("\\.phtml\\'"     . web-mode)
    ("\\.html\\'"      . web-mode)
    ("\\.tpl\\.php\\'" . web-mode)
    ("\\.jsp\\'"       . web-mode)
    ("\\.as[cp]x\\'"   . web-mode)
    ("\\.erb\\'"       . web-mode)
    ("\\.mustache\\'"  . web-mode)
    ("\\.ejs$"         . sgml-mode)
    ("\\.feature$"     . feature-mode)
    ("\\.djhtml\\'"    . web-mode))
  auto-mode-alist))

(setq web-mode-disable-autocompletion t)
(setq web-mode-tag-auto-close-style 0)

(defun ruby-eval-buffer () (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(add-hook 'ruby-mode-hook
  (lambda ()
    (setq ruby-deep-indent-paren nil)
    (setq ruby-indent-level 2)
    (setq fill-column 90)
    (define-key ruby-mode-map "\C-c\C-c" 'ruby-eval-buffer)
    )
  )

(add-hook 'css-mode-hook
          (lambda ()
            (setq css-indent-offset 2)
            )
          )

(add-hook 'js-mode-hook
          (lambda ()
            (setq js-indent-level 2)
            )
          )

(setq sgml-basic-offset 2)

;; turn off network and other slow features in ffap, which slow down
;; helm-for-files when the thing under point looks like a url or domain.
;;
;; having (type . file) in a source can also lead to attempts to open network
;; connections. maybe because some entries look like tramp paths? who knows.
;; regardless, watch out for that.
(custom-set-variables
 '(ffap-alist nil)                ; faster, dumber prompting
 '(ffap-machine-p-known 'accept)  ; don't ping domains
                                        ; disable URLs, FTP, remote filesystems, etc. would set them to nil except
                                        ; that some fns like helm-find-files-get-candidates pass them directly to
                                        ; string-match, which complains.
 '(ffap-url-regexp nil)
 '(helm-ff-url-regexp "^$")       ; a helm variant
 '(ffap-ftp-regexp nil)
 '(ffap-ftp-sans-slash-regexp nil)
 '(ffap-rfs-regexp nil)
 '(ffap-shell-prompt-regexp nil)) ; disable shell prompt stripping

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(global-hl-line-mode +0)

(global-set-key [(control meta f)] 'forward-to-word)

;; provides \cs regexp for "all white space"
(defun define-all-whitespace-category (table)
  "Define the 'all-whitespace' category, 's', in the category table TABLE."
  ;; First, clear out any existing definition for category 's'. Otherwise,
  ;; define-category throws an error if one calls this function more than once.
  (aset (char-table-extra-slot table 0) (- ?s ? ) nil)
  ;; Define the new category.
  (define-category ?s "all whitespace
All whitespace characters, including tab, form feed, and newline"
    table)
  ;; Add characters to it.
  (mapc (lambda (c) (modify-category-entry c ?s table))
        '(?  ?\n ?\f ?\t)))

(define-all-whitespace-category (standard-category-table))

;; get rid of evil whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun align-commas (beg end)
  (interactive "r")
  (align-regexp beg end ",\\(\\s-*\\)" 1 1 t))

(defun align-colons (beg end)
  (interactive "r")
  (align-regexp beg end ":\\(\\s-*\\)" 1 1 t))

(defun align-hash (beg end)
  (interactive "r")
  (align-regexp beg end "\\(\\s-*\\)\=\>\\(\\s-*\\)" 1 1 t))

(defun align-equals (beg end)
  (interactive "r")
  (align-regexp beg end "\\(\\s-*\\)\=\\(\\s-*\\)" 1 1 t))

(defun align-c-comment (beg end)
  (interactive "r")
  (align-regexp beg end "\\(-*\\)//" 1 0 t))

(defun align-attributes (beg end)
  (interactive "r")
  (align-regexp beg end "\\(\\s-*\\) \\(\\s-*\\)" 1 0 t))

;; allow arrow keys
(setq prelude-guru nil)

;; disable smartparens
(setq sp-autoinsert-pair nil)
(setq sp-autoescape-string-quote nil)

;; don't limit line length
(setq whitespace-line-column 999999999)

(scroll-bar-mode -1)
(setq ns-use-srgb-colorspace t)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)t

(load-theme 'tango-dark t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#151515" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(command-t-ctmatch-path "~/.emacs.d/elpa/command-t-0.0.1/ctmatch")
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("39d61a8edea28875bc28d5994ff50afd30650eb4d8e15b54c1365d9303e50ad7" "ac69b7e2e928dc1560d5a556043c99d8cb0614c30957bd03dfe82be4a9e917ee" "f28f591962950b8718042a7c37de038edfbd9faeacdb6c21f6db9e0702d71055" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "3ad55e40af9a652de541140ff50d043b7a8c8a3e73e2a649eb808ba077e75792" "be99dd67b8b81de8d11f055f8f4276a65099e52eaa5efe035e7409027e272521" "1cc69add80a116d4ceee9ab043bb3d372f034586da54c9677d0fff99231e5eb9" "bd6e539f641b33aeaf21ae51266bd9dfd6c1f2d550d109192e1c678b440242ad" "03b649ae49a7d40c7115611f1da3e126c33c10b96dd18ee45bdd8319ed375a78" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "86c3a8994b7455bda5b680b9b17e04ce6a092b5ef48f0662d681e9be9f852427" default)))
 '(fci-rule-color "#393939")
 '(js2-basic-offset 4)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
